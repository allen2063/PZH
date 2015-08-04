//
//  DetailCellViewController.m
//  PZH
//
//  Created by ZengYifei on 15/8/4.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "DetailCellViewController.h"
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "AppDelegate.h"
#import "HYSegmentedControl.h"
#import "DetailWebViewController.h"
#import "CustomBtnTableViewCell.h"
#import "GMDCircleLoader.h"
@interface DetailCellViewController ()<DJRefreshDelegate,UITableViewDelegate,UITableViewDataSource>{
    AppDelegate * appDelegate;
    DJRefreshDirection directionForNow;
    int countForView;//此页面第一次出现时自动下拉刷新
    int totalTitleForSeg;        //此seg里面共有多少文章
    BOOL isLoading;              //  加载状态
    BOOL loadNextPage ;
}
@property (strong,nonatomic)HYSegmentedControl * seg;
@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic,strong)NSMutableArray *dataList;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation DetailCellViewController
@synthesize titleLabel,seg,segArray,tempArray;
#define NUMBEROFTITLEFORPAGES 10   //每页10条记录
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PassageListResult:) name:@"PassageListResult" object:nil];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetGGGS_ListResult:) name:@"GetZWGK_ListResult" object:nil];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(segTouchedForNews:) name:@"segTouched" object:nil];
        isLoading = NO;
        countForView = 0;
        loadNextPage = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整

        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(segTouched:) name:@"segTouched" object:nil];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.titleLabel.text = appDelegate.title;
        self.segArray = [NSMutableArray arrayWithObjects:appDelegate.sonTitle, nil];
        _dataList=[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
        
        self.tempArray = [[NSMutableArray alloc]init];
        [self createSegmentedControl];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONHIGHT + HYSegmentedControl_Height, UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHIGHT - HYSegmentedControl_Height)];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        [self.view addSubview:self.tableView];
    }
    return self;
}

- (void)PassageListResult:(NSNotification *)note{
    if (directionForNow == DJRefreshDirectionTop) {
        [self.dataList removeAllObjects];
    }
    [self.tempArray removeAllObjects];
    NSString *info =[[note userInfo] objectForKey:@"info"];
    NSMutableArray * tempArrays = (NSMutableArray *)[info componentsSeparatedByString:@";"];
    totalTitleForSeg = [[tempArrays objectAtIndex:0] intValue ];           //当前列表下文章的总数
    if (totalTitleForSeg <= (NUMBEROFTITLEFORPAGES * appDelegate.currentPageNumber)) {
        loadNextPage = NO;
    }
    [tempArrays removeObjectAtIndex:0];
    [tempArrays removeLastObject];
    NSMutableDictionary * dic;
    for (int i = 0; i < tempArrays.count; i++) {
        NSArray * arr = [[tempArrays objectAtIndex:i]componentsSeparatedByString:@","];
//        if (arr.count == 2) {
//            dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[arr objectAtIndex:0],@"title",[arr objectAtIndex:1],@"time", nil];
//        }else if (arr.count == 3){
            dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[arr objectAtIndex:0],@"title",[arr objectAtIndex:1],@"time",[arr objectAtIndex:2],@"label", nil];
//        }
        [self.dataList addObject:dic];
        [self.tempArray addObject:dic];
    }
    [self addDataWithDirection:directionForNow];
}


- (void)createSegmentedControl
{
    self.seg = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:self.segArray delegate:self] ;
    self.seg.frame = CGRectMake(0, NAVIGATIONHIGHT, self.view.frame.size.width, HYSegmentedControl_Height);
    [self.view addSubview:self.seg];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //self.titleLabel.text = appDelegate.title;
    
    if (countForView == 0) {                                //因为写在viewWillAppear里面  所以只在第一次出现时自动请求更新
        self.automaticallyAdjustsScrollViewInsets=NO;
        
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
        countForView ++;
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    directionForNow = direction;
    isLoading = YES;
    NSString * countOfTitle = [NSString stringWithFormat:@"%d",NUMBEROFTITLEFORPAGES];
    if (self.refresh.refreshingDirection==DJRefreshingDirectionTop)
    {
        appDelegate.currentPageNumber = 1;
        [appDelegate.conAPI getWorkOnlineListWithChannelName:appDelegate.title andChannelNext:appDelegate.sonTitle andPageSize:countOfTitle andCurPage:@"1"];
    }
    else if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
        NSString * curPage = [NSString stringWithFormat:@"%d",++appDelegate.currentPageNumber];
        [appDelegate.conAPI getWorkOnlineListWithChannelName:appDelegate.title andChannelNext:appDelegate.sonTitle andPageSize:countOfTitle andCurPage:curPage];
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
    CustomBtnTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[CustomBtnTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if ([[self.dataList objectAtIndex:0]isKindOfClass:[NSMutableDictionary class]]) {
        cell.titleLabel.text = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"title"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    if (isLoading) {
        return;
    }
    NSMutableArray * segLabelArray = [[NSMutableArray alloc]initWithObjects:appDelegate.sonTitle, nil];
    DetailWebViewController * detailViewController = [[DetailWebViewController alloc] initWithNibName:nil bundle:nil WithURL:nil andSegArray:segLabelArray];
    NSString * currentPassageTitle = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"title"];
    NSString * createTime = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"time"];;

    [appDelegate.conAPI getPassageContentWithChannelName:appDelegate.title andChannelNext:appDelegate.sonTitle andTitle:currentPassageTitle andCreateTime:createTime];
    [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
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
