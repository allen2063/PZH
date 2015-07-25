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
@interface NewsViewController ()<DJRefreshDelegate,UITableViewDelegate,UITableViewDataSource>{
    AppDelegate * appDelegate;
    DJRefreshDirection directionForNow;
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

        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(segTouched:) name:@"segTouched" object:nil];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        appDelegate.touchedSegBtnTag = 1000;//默认第一个seg
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
            self.segArray = [NSMutableArray arrayWithObjects:@"部门会议", nil];
        }
        else if ([appDelegate.title isEqualToString:@"区县快讯"]){
            self.segArray = [NSMutableArray arrayWithObjects:@"区县快讯", nil];
        }
        _dataList=[[NSMutableArray alloc] init];

//        self.tempArray = [[NSMutableArray alloc]init];
        self.currentSegTitle = @"城市新貌";
        [self createSegmentedControl];
    }
    return self;
}

- (void)GetGGGS_ListResult:(NSNotification *)note{
    
    NSString *info = @"攀钢1×300MW煤矸石综合利用自备电厂工程变更环评二次公示;中共攀枝花市委群众工作局关于市民热线受理中心公开考调工作人员拟调人员公示;攀枝花市妇幼保健院空调电力线路改造工程比选公告;共青团“SYE”助青年创业;高炉除尘灰综合利用项目第二次公示;攀枝花市中西医结合医院新住院大楼设备层防水工程比选公告;钒钛产业园区物流园主干道工程环评第一次公示;攀枝花钒钛产业园区三号路延长线及三号路与金江城区二号路连接线项目环评第一次公示;攀枝花钒钛产业园区三号道路（北段）工程第四标段项目 环评第一次公示;2015年攀枝花市领军型创新创业项目征集公告;攀枝花市水上应急救援中心考核招聘高层次人才和紧缺专业人员的公告;成昆铁路峨眉至米易段扩能工程变更环境影响评价第二次公告及报告书（简本）;“攀枝花市民讲坛”2015年6月14日预告;中共攀枝花市纪委监察局2015年公开考调公务员面试成绩公告;攀枝花市人民政府办公室公开考调机关工作人员公告";//[[note userInfo] objectForKey:@"info"];
    self.tempArray = (NSMutableArray *)[info componentsSeparatedByString:@";"];
    [self.tempArray removeLastObject];
    for (int i = 0; i < self.tempArray.count; i++) {
        [self.dataList addObject:[tempArray objectAtIndex:i]];
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
    self.titleLabel.text = appDelegate.title;
    
    
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

}

- (void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}



- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    directionForNow = direction;
    
    NSString * countOfPic = [NSString stringWithFormat:@"%d",NUMBEROFTITLEFORPAGE];
    if([appDelegate.title isEqualToString:@"公告公示"]){
        if (self.refresh.refreshingDirection==DJRefreshingDirectionTop)
        {
            [self.dataList removeAllObjects];
            appDelegate.currentPageNumber = 1;
            [appDelegate.conAPI getAnnouncementOfPublicArrayListWithPageSize:countOfPic andCurPage:@"1"];
        }
        else if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
            NSString * curPage = [NSString stringWithFormat:@"%d",++appDelegate.currentPageNumber];
            [appDelegate.conAPI getAnnouncementOfPublicArrayListWithPageSize:countOfPic andCurPage:curPage];
        }
    }
    else if([appDelegate.title isEqualToString:@"领导活动"]){
        if (self.refresh.refreshingDirection==DJRefreshingDirectionTop)
        {
            [self.dataList removeAllObjects];
            appDelegate.currentPageNumber = 1;
            [appDelegate.conAPI getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsWithChannelName:appDelegate.title andChannelNext:@"讲话" andPageSize:countOfPic andCurPage:@"1"];
        }
        else if (self.refresh.refreshingDirection==DJRefreshingDirectionBottom){
            NSString * curPage = [NSString stringWithFormat:@"%d",++appDelegate.currentPageNumber];
            
            [appDelegate.conAPI getLeaderLeadersActivitiesAndWorkConferenceAndDynamicOfDepartmentAndCountyNewsWithChannelName:appDelegate.title andChannelNext:[self.segArray objectAtIndex:appDelegate.touchedSegBtnTag-1000] andPageSize:countOfPic andCurPage:curPage];
        }
    }
    
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[self addDataWithDirection:direction];
    });
    
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{ 
//    for (NSInteger i=0; i<20; i++) {
//        [self.dataList addObject:@""];
//    }
    
    [_refresh finishRefreshingDirection:direction animation:YES];
    
    [self.tableView reloadData];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.text= [self.dataList objectAtIndex:indexPath.row];//[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailWebViewController * detailViewController = [[DetailWebViewController alloc] initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.segArray];
    //appDelegate.title = @"公告公示";
    [self.navigationController pushViewController:detailViewController animated:YES];
    [appDelegate.conAPI getAnnouncementOfPublicContentWithTitle:[self.dataList objectAtIndex:indexPath.row] ];
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
