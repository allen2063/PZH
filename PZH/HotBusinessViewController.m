//
//  HotBusinessViewController.m
//  PZH
//
//  Created by ZengYifei on 15/8/5.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "HotBusinessViewController.h"
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "DetailWebViewController.h"
@interface HotBusinessViewController ()<DJRefreshDelegate,UITableViewDelegate,UITableViewDataSource>{
    AppDelegate * appDelegate;
    DJRefreshDirection directionForNow;
    int totalTitleForSeg;        //此seg里面共有多少文章
    BOOL isLoading;              //  加载状态
    BOOL loadNextPage ;
    BOOL shouldUpdateCacheForTitle;
}
@property (strong,nonatomic)HYSegmentedControl * seg;
@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic,strong)NSMutableArray *dataList;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary * cachaDic;

@end

@implementation HotBusinessViewController
@synthesize titleLabel,seg,segArray;
#define NUMBEROFTITLEFORPAGES 15   //每页15条记录
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetRDBS_ListResult:) name:@"GetRDBS_ListResult" object:nil];
        isLoading = NO;
        loadNextPage = YES;
        shouldUpdateCacheForTitle = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.titleLabel.text = appDelegate.title;
        [self createSegmentedControl];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    self.segArray = [NSMutableArray arrayWithObjects:appDelegate.sonTitle, nil];
    
    //读取缓存数据
    self.cachaDic = [ConnectionAPI readFileDic];
    if (self.cachaDic == nil) {
        self.cachaDic = [[NSMutableDictionary alloc]init];
    }
    if ([[self.cachaDic objectForKey:[NSString stringWithFormat:@"%@%@",appDelegate.title,appDelegate.sonTitle]] isKindOfClass:[NSArray class]]) {
        _dataList = [self.cachaDic objectForKey:[NSString stringWithFormat:@"%@%@",appDelegate.title,appDelegate.sonTitle]];
        //如果读取的数据大于每页请求数
        while (_dataList.count >NUMBEROFTITLEFORPAGE) {
            [_dataList removeLastObject];
        }
    }else _dataList=[[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONHIGHT + HYSegmentedControl_Height, UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHIGHT - HYSegmentedControl_Height)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    _refresh=[[DJRefresh alloc] initWithScrollView:self.tableView delegate:self];
    _refresh.topEnabled=YES;
    _refresh.bottomEnabled=YES;
    
    if (_type==eRefreshTypeProgress) {
        [_refresh registerClassForTopView:[DJRefreshProgressView class]];
    }
    
    [_refresh startRefreshingDirection:DJRefreshDirectionTop animation:YES];
}

- (void)createSegmentedControl
{
    self.seg = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:self.segArray delegate:self] ;
    self.seg.frame = CGRectMake(0, NAVIGATIONHIGHT, self.view.frame.size.width, HYSegmentedControl_Height);
    [self.view addSubview:self.seg];
}

- (void)GetRDBS_ListResult:(NSNotification *)note{

    NSString *info =[[note userInfo] objectForKey:@"info"];
    NSMutableArray * tempArrays = (NSMutableArray *)[info componentsSeparatedByString:@";"];
    totalTitleForSeg = [[tempArrays objectAtIndex:0] intValue ];           //当前列表下文章的总数
    if (totalTitleForSeg <= (NUMBEROFTITLEFORPAGES * appDelegate.currentPageNumber)) {
        loadNextPage = NO;
    }
    [tempArrays removeObjectAtIndex:0];
    [tempArrays removeLastObject];
    NSMutableArray * tempArray = [[NSMutableArray alloc]init];
    NSMutableDictionary * dic;
    for (int i = 0; i < tempArrays.count; i++) {
        NSArray * arr = [[tempArrays objectAtIndex:i]componentsSeparatedByString:@","];
        dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[arr objectAtIndex:0],@"title",[arr objectAtIndex:1],@"label", nil];
        [tempArray addObject:dic];
    }
    
    NSString * serverMD5 = [ConnectionAPI md5:[NSString stringWithFormat:@"%@",tempArray]];
    NSString * cacheMD5 = [ConnectionAPI md5:[NSString stringWithFormat:@"%@",[self.cachaDic objectForKey:[NSString stringWithFormat:@"%@%@",appDelegate.title,appDelegate.sonTitle]]]];
    
    if(shouldUpdateCacheForTitle && ![serverMD5 isEqualToString:cacheMD5]){
        [self.cachaDic setObject:tempArray forKey:[NSString stringWithFormat:@"%@%@",appDelegate.title,appDelegate.sonTitle]];
        [NSThread detachNewThreadSelector:@selector(writeFileDic:) toTarget:self withObject:self.cachaDic];
        shouldUpdateCacheForTitle = NO;
        NSLog(@"Title缓存已更新");
    }
    //temparry ->_datalist;
    if (directionForNow == DJRefreshDirectionTop) {
        [_dataList removeAllObjects];
    }
    for (id dic in tempArray) {
        [_dataList addObject:dic];
    }
    [self addDataWithDirection:directionForNow];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //appDelegate.title = @"面向市民";
    self.titleLabel.text = appDelegate.title;
}

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    directionForNow = direction;
    isLoading = YES;
    NSString * countOfTitle = [NSString stringWithFormat:@"%d",NUMBEROFTITLEFORPAGES];
    if (self.refresh.refreshingDirection==DJRefreshingDirectionTop)
    {
        //下拉更新时将第一页数据缓存
        shouldUpdateCacheForTitle = YES;
        appDelegate.currentPageNumber = 1;
        [appDelegate.conAPI getHotBusinessListWithPageSize:countOfTitle andCurPage:@"1"];
    }
    else if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
        NSString * curPage = [NSString stringWithFormat:@"%d",++appDelegate.currentPageNumber];
        [appDelegate.conAPI getHotBusinessListWithPageSize:countOfTitle andCurPage:curPage];
    }
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    [self.tableView reloadData];
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    if (!loadNextPage) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"所有新闻加载已完成！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    isLoading =NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if ([[self.dataList objectAtIndex:0]isKindOfClass:[NSMutableDictionary class]]) {
        cell.textLabel.text = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"title"];
        cell.detailTextLabel.text = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"label"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    if (isLoading) {
        return;
    }
    //UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"目前跳转外链有问题！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //[alert show];
//#warning    目前外链有问题

    NSMutableArray * segLabelArray = [[NSMutableArray alloc]initWithObjects:appDelegate.sonTitle, nil];
    DetailWebViewController * detailViewController = [[DetailWebViewController alloc] initWithNibName:nil bundle:nil WithURL:nil andSegArray:segLabelArray];
    NSString * currentPassageTitle = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"title"];
    
    [appDelegate.conAPI getHotBusinessContentWithTitle:currentPassageTitle];
    [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

#pragma mark - 写入缓存
- (void)writeFileDic:(NSMutableDictionary *)dic{
    //写入对应位置
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"cacheDic.archiver"];//拓展名可以自己随便取
    
    BOOL writeResult =[NSKeyedArchiver archiveRootObject:dic toFile:path];
    NSLog(@"%@",writeResult ? @"写入缓存成功table":@"写入缓存失败table");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
