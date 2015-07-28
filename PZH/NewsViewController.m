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
    int countForView;//此页面第一次出现时自动下拉刷新
    int totalTitleForSeg;        //此seg里面共有多少文章
    BOOL isLoading;              //  加载状态
}
@property (strong,nonatomic)HYSegmentedControl * seg;
@property (nonatomic,strong)DJRefresh *refresh;
@property (nonatomic,strong)NSMutableArray *dataList;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation NewsViewController
@synthesize titleLabel,seg,segArray,tempArray,currentSegTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetGGGS_ListResult:) name:@"GetGGGS_ListResult" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetGGGS_ListResult:) name:@"GetZWGK_ListResult" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(segTouchedForNews:) name:@"segTouched" object:nil];
        isLoading = NO;
        countForView = 0;
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(segTouched:) name:@"segTouched" object:nil];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        //appDelegate.touchedSegBtnTag = 1000;//默认第一个seg
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
        _dataList=[[NSMutableArray alloc] init];

        self.tempArray = [[NSMutableArray alloc]init];
        self.currentSegTitle = [self.segArray objectAtIndex:0];
        [self createSegmentedControl];
    }
    return self;
}

- (void)GetGGGS_ListResult:(NSNotification *)note{
    if (directionForNow == DJRefreshDirectionTop) {
        [self.dataList removeAllObjects];
    }
    [self.tempArray removeAllObjects];
    NSString *info =[[note userInfo] objectForKey:@"info"];
    NSMutableArray * tempArrays = (NSMutableArray *)[info componentsSeparatedByString:@";"];
    totalTitleForSeg = (int)[tempArrays objectAtIndex:0];           //当前列表下文章的总数
    [tempArrays removeObjectAtIndex:0];
    [tempArrays removeLastObject];
    NSMutableDictionary * dic;
    for (int i = 0; i < tempArrays.count; i++) {
        NSArray * arr = [[tempArrays objectAtIndex:i]componentsSeparatedByString:@","];
        if (arr.count == 2) {
            dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[arr objectAtIndex:0],@"title",[arr objectAtIndex:1],@"time", nil];
        }else if (arr.count == 3){
            dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[arr objectAtIndex:0],@"title",[arr objectAtIndex:1],@"time",[arr objectAtIndex:2],@"label", nil];
        }
        [self.dataList addObject:dic];
        [self.tempArray addObject:dic];
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
    
    if (countForView == 0) {
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
    NSString * countOfPic = [NSString stringWithFormat:@"%d",NUMBEROFTITLEFORPAGE];
    if([appDelegate.title isEqualToString:@"公告公示"]){
        if (self.refresh.refreshingDirection==DJRefreshingDirectionTop)
        {
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
            //[self.dataList removeAllObjects];
            appDelegate.currentPageNumber = 1;
            if([appDelegate.title isEqualToString:@"部门动态"]|| [appDelegate.title isEqualToString:@"区县快讯"]){     //接口格式上对部门动态和区县快讯不一样
                [appDelegate.conAPI getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsWithChannelName:@"工作动态"andChannelNext:appDelegate.title  andPageSize:countOfPic andCurPage:@"1"];
            }else
            [appDelegate.conAPI getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsWithChannelName:appDelegate.title andChannelNext:self.currentSegTitle andPageSize:countOfPic andCurPage:@"1"];
        }
        else if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
            NSString * curPage = [NSString stringWithFormat:@"%d",++appDelegate.currentPageNumber];
            if([appDelegate.title isEqualToString:@"部门动态"]|| [appDelegate.title isEqualToString:@"区县快讯"]){
                [appDelegate.conAPI getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsWithChannelName:@"工作动态"andChannelNext:appDelegate.title  andPageSize:countOfPic andCurPage:curPage];
            }else
            [appDelegate.conAPI getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsWithChannelName:appDelegate.title andChannelNext:self.currentSegTitle andPageSize:countOfPic andCurPage:curPage];
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
    NSDictionary * dic = (NSDictionary * )[self.dataList objectAtIndex:indexPath.row];
    cell.titleLabel.text= [dic objectForKey:@"title"];
    cell.timeLabel.text =[dic objectForKey:@"time"];
    if (dic.count == 3) {
        cell.accessoryTextLabel.text = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"label"];;
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
    NSString * currentPassageTitle = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"title"];
    NSString * createTime = [[self.dataList objectAtIndex:indexPath.row]objectForKey:@"time"];;
    if ([appDelegate.title isEqualToString: @"公告公示"]) {
        [appDelegate.conAPI getAnnouncementOfPublicContentWithTitle:[[self.dataList objectAtIndex:indexPath.row] objectForKey:@"title"] ];
    }else if([appDelegate.title isEqualToString: @"部门动态"]||[appDelegate.title isEqualToString: @"区县快讯"]){
        //NSString * channelNext = [self.segArray objectAtIndex:(appDelegate.touchedSegBtnTag - 1000)];
        
        [appDelegate.conAPI getPassageContentWithChannelName:@"工作动态" andChannelNext:appDelegate.title andTitle:currentPassageTitle andCreateTime:createTime];
    }else{
        [appDelegate.conAPI getPassageContentWithChannelName:appDelegate.title andChannelNext:self.currentSegTitle andTitle:currentPassageTitle andCreateTime:createTime];
    }
    [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
    [self.navigationController pushViewController:detailViewController animated:YES];
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
