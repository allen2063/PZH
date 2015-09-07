//
//  NewsViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/25.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "NewsViewController.h"
#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import "AppDelegate.h"
#import "HYSegmentedControl.h"
#import "DetailWebViewController.h"
#import "CustomTableViewCell.h"
#import "GMDCircleLoader.h"
@interface NewsViewController ()<DJRefreshDelegate,UITableViewDelegate,UITableViewDataSource>{
    AppDelegate * appDelegate;
    DJRefreshDirection directionForNow;
    int totalTitleForSeg;        //此seg里面共有多少文章
    BOOL isLoading;              //  加载状态
    BOOL shouldUpdateCacheForTitle;
}
@property (strong,nonatomic)HYSegmentedControl * seg;
@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic,strong)NSMutableArray *dataList;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary * cachaDic;

@end

@implementation NewsViewController
@synthesize titleLabel,seg,segArray,currentSegTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetGGGS_ListResult:) name:@"GetGGGS_ListResult" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetGGGS_ListResult:) name:@"GetZWGK_ListResult" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(segTouchedForNews:) name:@"segTouched" object:nil];
        isLoading = NO;
        shouldUpdateCacheForTitle = NO;
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(segTouched:) name:@"segTouched" object:nil];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        //appDelegate.touchedSegBtnTag = 1000;//默认第一个seg
        
        [self createSegmentedControl];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([appDelegate.title isEqualToString:@"公告公示"]) {
        self.segArray = [NSMutableArray arrayWithObjects:@"公告公示", nil];
    }
    else if ([appDelegate.title isEqualToString:@"领导活动"]){
        self.segArray = [NSMutableArray arrayWithObjects:@"讲话",@"活动",@"会议",@"调研",@"其他", nil];
    }
    else if ([appDelegate.title isEqualToString:@"工作会议"]){
        self.segArray = [NSMutableArray arrayWithObjects:@"市委会议",@"政府会议",@"人大会议",@"政协会议", nil];
    }
    else if ([appDelegate.title isEqualToString:@"部门动态"]){
        self.segArray = [NSMutableArray arrayWithObjects:@"部门动态", nil];
    }
    else if ([appDelegate.title isEqualToString:@"区县快讯"]){
        self.segArray = [NSMutableArray arrayWithObjects:@"区县快讯", nil];
    }
    self.currentSegTitle = [self.segArray objectAtIndex:0];
    self.automaticallyAdjustsScrollViewInsets=NO;
    //读取缓存数据
    self.cachaDic = [ConnectionAPI readFileDic];
    if (self.cachaDic == nil) {
        self.cachaDic = [[NSMutableDictionary alloc]init];
    }
    
    if ([[self.cachaDic objectForKey:[NSString stringWithFormat:@"%@%@",appDelegate.title,self.currentSegTitle]] isKindOfClass:[NSArray class]]) {
        _dataList = [self.cachaDic objectForKey:[NSString stringWithFormat:@"%@%@",appDelegate.title,self.currentSegTitle]];
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

- (void)GetGGGS_ListResult:(NSNotification *)note{
    
    NSString *info =[[note userInfo] objectForKey:@"info"];
    NSMutableArray * tempArrays = (NSMutableArray *)[info componentsSeparatedByString:@";"];
    totalTitleForSeg = [[tempArrays objectAtIndex:0] intValue];           //当前列表下文章的总数
    [tempArrays removeObjectAtIndex:0];
    [tempArrays removeLastObject];
    NSMutableArray * tempArray = [[NSMutableArray alloc]init];
    NSMutableDictionary * dic;
    for (int i = 0; i < tempArrays.count; i++) {
        NSArray * arr = [[tempArrays objectAtIndex:i]componentsSeparatedByString:@","];
        if (arr.count == 2) {
            dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[arr objectAtIndex:0],@"title",[arr objectAtIndex:1],@"time", nil];
        }else if (arr.count == 3){
            dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[arr objectAtIndex:0],@"title",[arr objectAtIndex:1],@"time",[arr objectAtIndex:2],@"label", nil];
        }
        [tempArray addObject:dic];
    }
    
    NSString * serverMD5 = [ConnectionAPI md5:[NSString stringWithFormat:@"%@",tempArray]];
    NSString * cacheMD5 = [ConnectionAPI md5:[NSString stringWithFormat:@"%@",[self.cachaDic objectForKey:[NSString stringWithFormat:@"%@%@",appDelegate.title,self.currentSegTitle]]]];
    
    if(shouldUpdateCacheForTitle && ![serverMD5 isEqualToString:cacheMD5]){
        [self.cachaDic setObject:tempArray forKey:[NSString stringWithFormat:@"%@%@",appDelegate.title,self.currentSegTitle]];
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


- (void)segTouchedForNews:(NSNotification *)note{
    //调用动画效果  并更新列表
    self.currentSegTitle = [[note userInfo] objectForKey:@"title"];
    [_refresh startRefreshingDirection:DJRefreshDirectionTop animation:NO];
}

- (void)createSegmentedControl
{
    self.seg = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:self.segArray delegate:self] ;
    self.seg.frame = CGRectMake(0, NAVIGATIONHIGHT, self.view.frame.size.width, HYSegmentedControl_Height);
    [self.view addSubview:self.seg];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.titleLabel.text = appDelegate.title;
}

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    directionForNow = direction;
    isLoading = YES;
    NSString * countOfPic = [NSString stringWithFormat:@"%d",NUMBEROFTITLEFORPAGE];
    if([appDelegate.title isEqualToString:@"公告公示"]){
        if (self.refresh.refreshingDirection==DJRefreshingDirectionTop)
        {
            //下拉更新时将第一页数据缓存
            shouldUpdateCacheForTitle = YES;
            appDelegate.currentPageNumber = 1;
            [appDelegate.conAPI getAnnouncementOfPublicArrayListWithPageSize:countOfPic andCurPage:@"1"];
        }
        else if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
            NSString * curPage = [NSString stringWithFormat:@"%d",++appDelegate.currentPageNumber];
            [appDelegate.conAPI getAnnouncementOfPublicArrayListWithPageSize:countOfPic andCurPage:curPage];
        }
    }
    else {//if([appDelegate.title isEqualToString:@"领导活动"]){
        if (self.refresh.refreshingDirection==DJRefreshingDirectionTop)
        {
            //下拉更新时将第一页数据缓存
            shouldUpdateCacheForTitle = YES;
            appDelegate.currentPageNumber = 1;
            if([appDelegate.title isEqualToString:@"部门动态"]|| [appDelegate.title isEqualToString:@"区县快讯"]){     //接口格式上对部门动态和区县快讯不一样
                [appDelegate.conAPI getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsListWithChannelName:@"工作动态"andChannelNext:appDelegate.title  andPageSize:countOfPic andCurPage:@"1"];
            }else
            [appDelegate.conAPI getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsListWithChannelName:appDelegate.title andChannelNext:self.currentSegTitle andPageSize:countOfPic andCurPage:@"1"];
        }
        else if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
            NSString * curPage = [NSString stringWithFormat:@"%d",++appDelegate.currentPageNumber];
            if([appDelegate.title isEqualToString:@"部门动态"]|| [appDelegate.title isEqualToString:@"区县快讯"]){
                [appDelegate.conAPI getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsListWithChannelName:@"工作动态"andChannelNext:appDelegate.title  andPageSize:countOfPic andCurPage:curPage];
            }else
            [appDelegate.conAPI getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsListWithChannelName:appDelegate.title andChannelNext:self.currentSegTitle andPageSize:countOfPic andCurPage:curPage];
            //[self.segArray objectAtIndex:appDelegate.touchedSegBtnTag-1000]
        }
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
//    if (directionForNow == DJRefreshDirectionTop) {
//        [self.dataList removeAllObjects];
//    }
//    for (id dic in self.tempArray) {
//        [self.dataList addObject:dic];
//    }
    [self.tableView reloadData];
    
    [_refresh finishRefreshingDirection:direction animation:YES];

    isLoading =NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    NSDictionary * dic = (NSDictionary * )[_dataList objectAtIndex:indexPath.row];
    cell.titleLabel.text= [dic objectForKey:@"title"];
    cell.timeLabel.text =[dic objectForKey:@"time"];
    if (dic.count == 3) {               //详情标签  并不是每一项都有
        cell.accessoryTextLabel.text = [[_dataList objectAtIndex:indexPath.row]objectForKey:@"label"];;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    if (isLoading) {
        return;
    }
    NSMutableArray * segLabelArray = [[NSMutableArray alloc]initWithObjects:self.currentSegTitle, nil];
    DetailWebViewController * detailViewController = [[DetailWebViewController alloc] initWithNibName:nil bundle:nil WithURL:nil andSegArray:segLabelArray];
    NSString * currentPassageTitle = [[_dataList objectAtIndex:indexPath.row]objectForKey:@"title"];
    NSString * createTime = [[_dataList objectAtIndex:indexPath.row]objectForKey:@"time"];;
    if ([appDelegate.title isEqualToString: @"公告公示"]) {
        [appDelegate.conAPI getAnnouncementOfPublicContentWithTitle:[[_dataList objectAtIndex:indexPath.row] objectForKey:@"title"] ];
    }
    else if ([appDelegate.title isEqualToString: @"部门动态"]){                 //新接口
        [appDelegate.conAPI getBUMENDONGTAIContentWithChannelName:@"工作动态" andChannelNext:@"部门动态" andTitle:currentPassageTitle andCreateTime:createTime];
    }
    else if([appDelegate.title isEqualToString: @"部门动态"]||[appDelegate.title isEqualToString: @"区县快讯"]){
        //NSString * channelNext = [self.segArray objectAtIndex:(appDelegate.touchedSegBtnTag - 1000)];
        
        [appDelegate.conAPI getPassageContentWithChannelName:@"工作动态" andChannelNext:appDelegate.title andTitle:currentPassageTitle andCreateTime:createTime];
    }
    else{
        [appDelegate.conAPI getPassageContentWithChannelName:appDelegate.title andChannelNext:self.currentSegTitle andTitle:currentPassageTitle andCreateTime:createTime];
    }
    [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
    [self.navigationController pushViewController:detailViewController animated:YES];
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
