//
//  StatisticsOfWorkViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/29.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "StatisticsOfWorkViewController.h"
#import "AppDelegate.h"
#import "HYSegmentedControl.h"
@interface StatisticsOfWorkViewController (){
    AppDelegate * appDelegate;
    UILabel * accumulateCountLabel;
    UILabel * acceptCountLabel;
    UILabel * lastMonthAcceptedCountLabel;
    UILabel * lastMonthAccumulateCountLabel;
    UILabel * yesterdayAcceptedCountLabel;
    UILabel * yesterdayAccumulateCountLabel;

}
@property (nonatomic,strong)HYSegmentedControl * seg;

@end

@implementation StatisticsOfWorkViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetBJTJ_SUMResult:) name:@"GetBJTJ_SUMResult" object:nil];

        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.titleLabel.text = appDelegate.title;
        self.segArray = [NSMutableArray arrayWithObjects:appDelegate.sonTitle, nil];
        [self createSegmentedControl];
        
        acceptCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, UISCREENWIDTH/2, 30)];
        acceptCountLabel.text = @"累计受理:";
        acceptCountLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:acceptCountLabel];
        
        accumulateCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2+10, 120, UISCREENWIDTH/2, 30)];
        accumulateCountLabel.text = @"累计办结:";
        accumulateCountLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:accumulateCountLabel];
        
        lastMonthAcceptedCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, UISCREENWIDTH/2, 30)];
        lastMonthAcceptedCountLabel.text = @"上月受理:";
        lastMonthAcceptedCountLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:lastMonthAcceptedCountLabel];
        
        lastMonthAccumulateCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2+10, 160, UISCREENWIDTH/2, 30)];
        lastMonthAccumulateCountLabel.text = @"上月办结:";
        lastMonthAccumulateCountLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:lastMonthAccumulateCountLabel];
        
        yesterdayAcceptedCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, UISCREENWIDTH/2, 30)];
        yesterdayAcceptedCountLabel.text = @"昨日受理:";
        yesterdayAcceptedCountLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:yesterdayAcceptedCountLabel];
        
        yesterdayAccumulateCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2+10, 200, UISCREENWIDTH/2, 30)];
        yesterdayAccumulateCountLabel.text = @"昨日办结:";
        yesterdayAccumulateCountLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:yesterdayAccumulateCountLabel];

        
    }
    return self;
}

- (void)GetBJTJ_SUMResult:(NSNotification *)note{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    NSString *info =[[note userInfo] objectForKey:@"info"];
    NSMutableArray * tempArrays = (NSMutableArray *)[info componentsSeparatedByString:@";"];
    if (tempArrays.count>6) {
        [tempArrays removeLastObject];
    }
    acceptCountLabel.text = [NSString stringWithFormat:@"累计受理:%@件",[tempArrays objectAtIndex:0]] ;
    accumulateCountLabel.text = [NSString stringWithFormat:@"累计办结:%@件",[tempArrays objectAtIndex:1]] ;
    lastMonthAcceptedCountLabel.text = [NSString stringWithFormat:@"上月受理:%@件",[tempArrays objectAtIndex:2]] ;
    lastMonthAccumulateCountLabel.text = [NSString stringWithFormat:@"上月办结:%@件",[tempArrays objectAtIndex:3]] ;
    yesterdayAcceptedCountLabel.text = [NSString stringWithFormat:@"昨日受理:%@件",[tempArrays objectAtIndex:4]] ;
    yesterdayAccumulateCountLabel.text = [NSString stringWithFormat:@"昨日办结:%@件",[tempArrays objectAtIndex:5]] ;
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
