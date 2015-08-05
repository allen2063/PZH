//
//  DetailTableViewController.m
//  PZH
//
//  Created by ZengYifei on 15/8/5.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "DetailTableViewController.h"
#import "AppDelegate.h"
#import "GMDCircleLoader.h"
#import "DetailWebViewController.h"
#import "HYSegmentedControl.h"

@interface DetailTableViewController (){
    AppDelegate * appDelegate;
}
@property (strong,nonatomic)HYSegmentedControl * seg;

@end

@implementation DetailTableViewController
@synthesize tableViews,titleLabel,dataList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.titleLabel.text = appDelegate.title;
        self.dataList=[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ListResult:) name:@"GetMXQY_ListResult" object:nil];                 //常见问题、相关政策
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ListResult:) name:@"GetRDBS_ListResult" object:nil];//热点办事
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        self.tableViews = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATIONHIGHT+HYSegmentedControl_Height, UISCREENWIDTH, UISCREENHEIGHT - NAVIGATIONHIGHT - HYSegmentedControl_Height)];
        self.tableViews.delegate=self;
        self.tableViews.dataSource=self;
        [self.view addSubview:self.tableViews];
        self.segArray = [NSMutableArray arrayWithObjects:appDelegate.grandsonTitle, nil];
        [self createSegmentedControl];
    }
    return self;
}

- (void)createSegmentedControl
{
    self.seg = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:self.segArray delegate:self] ;
    self.seg.frame = CGRectMake(0, NAVIGATIONHIGHT, self.view.frame.size.width, HYSegmentedControl_Height);
    [self.view addSubview:self.seg];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ListResult:(NSNotification *)note{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    NSString *info = [[note userInfo] objectForKey:@"info"];
    NSMutableArray * tempArrays = (NSMutableArray *)[info componentsSeparatedByString:@";"];
    if (tempArrays.count >1) {
        [tempArrays removeLastObject];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"该项数据为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    self.dataList = [NSMutableArray arrayWithArray:(NSArray *)tempArrays];
    [self.tableViews reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    NSMutableArray * segLabelArray = [[NSMutableArray alloc]initWithObjects:appDelegate.sonTitle, nil];
    DetailWebViewController * detailViewController = [[DetailWebViewController alloc] initWithNibName:nil bundle:nil WithURL:nil andSegArray:segLabelArray];
    NSString * currentPassageTitle = [self.dataList objectAtIndex:indexPath.row];
    
    [appDelegate.conAPI getCommonProblemsAndPoliciesAndRegulationsContentWithChannelName:appDelegate.parentTitle andChannelNext:appDelegate.grandsonTitle andTitle:currentPassageTitle];
    [GMDCircleLoader setOnView:detailViewController.view withTitle:@"加载中..." animated:YES];
    [self.navigationController pushViewController:detailViewController animated:YES];
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
