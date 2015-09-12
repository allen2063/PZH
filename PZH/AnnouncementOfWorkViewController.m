//
//  announcementOfWorkViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/29.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "AnnouncementOfWorkViewController.h"
#import "StatisticsOfWorkViewController.h"
#import "OnlineBusinessSearchViewController.h"
#import "DetailTableViewController.h"
#import "HotBusinessViewController.h"
#import "DetailWebViewController.h"
@interface AnnouncementOfWorkViewController (){
    AppDelegate * appDelegate;
}

@end

@implementation AnnouncementOfWorkViewController
@synthesize titleLabel;
#define INTERVALX (UISCREENWIDTH*2/25)
#define INTERVALY (INTERVALX*2/3.)
#define FONT 14
#define TYPE1BTNWIDTH ((UISCREENWIDTH - INTERVALX*2.5)/2)
#define TYPE1BTNHEIGHT (UISCREENHEIGHT/7)
#define TYPE2BTNWIDTH (UISCREENWIDTH - INTERVALX*2)
#define TYPE2BTNHEIGHT TYPE1BTNHEIGHT

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIImageView * backgroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        backgroundImageView.image = [UIImage imageNamed:@"bjgy"];
        [self.view addSubview:backgroundImageView];
        
        UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH*4/9,UISCREENWIDTH*4/9/400*60 )];
        logoImageView.center = CGPointMake(self.view.center.x, UISCREENHEIGHT - NAVIGATIONHIGHT*2/3);
        logoImageView.image = [UIImage imageNamed:@"bg_wenzi"];
        [self.view addSubview:logoImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        
        //办事公告
        UIButton * announcementOfWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        announcementOfWorkBtn.frame = CGRectMake(INTERVALX,INTERVALY + NAVIGATIONHIGHT,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);;
        [announcementOfWorkBtn addTarget:self action:@selector(jumpPageForAnnouncementOfWork:) forControlEvents:UIControlEventTouchUpInside];
        announcementOfWorkBtn.tag = 1;
        [announcementOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [announcementOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * announcementOfWorkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        announcementOfWorkLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        announcementOfWorkLabel.text = @"办事公告";
        announcementOfWorkLabel.textColor = [UIColor whiteColor];
        announcementOfWorkLabel.font = [UIFont boldSystemFontOfSize:FONT];
        announcementOfWorkLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * announcementOfWorkImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bsggg"]];
        announcementOfWorkImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        announcementOfWorkImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - announcementOfWorkLabel.frame.size.height/3);
        
        [announcementOfWorkBtn addSubview:announcementOfWorkLabel];
        [announcementOfWorkBtn addSubview:announcementOfWorkImgView];
        [self.view addSubview:announcementOfWorkBtn];
        
        //办件统计
        UIButton * statisticsOfWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statisticsOfWorkBtn.frame = CGRectMake(INTERVALX*1.5 + TYPE1BTNWIDTH,INTERVALY + NAVIGATIONHIGHT,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);
        [statisticsOfWorkBtn addTarget:self action:@selector(jumpPageForAnnouncementOfWork:) forControlEvents:UIControlEventTouchUpInside];
        statisticsOfWorkBtn.tag = 2;
        
        [statisticsOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [statisticsOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * statisticsOfWorkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        statisticsOfWorkLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        statisticsOfWorkLabel.text = @"办件统计";
        statisticsOfWorkLabel.textColor = [UIColor whiteColor];
        statisticsOfWorkLabel.font = [UIFont boldSystemFontOfSize:FONT];
        statisticsOfWorkLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * statisticsOfWorkImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bjtji"]];
        statisticsOfWorkImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        statisticsOfWorkImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - statisticsOfWorkLabel.frame.size.height/3);
        
        [statisticsOfWorkBtn addSubview:statisticsOfWorkLabel];
        [statisticsOfWorkBtn addSubview:statisticsOfWorkImgView];
        [self.view addSubview:statisticsOfWorkBtn];
        
        //在线办事查询
        UIButton * onlineBusinessSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        onlineBusinessSearchBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*2+TYPE2BTNHEIGHT,TYPE2BTNWIDTH,TYPE2BTNHEIGHT);
        [onlineBusinessSearchBtn addTarget:self action:@selector(jumpPageForAnnouncementOfWork:) forControlEvents:UIControlEventTouchUpInside];
        onlineBusinessSearchBtn.tag = 3;
        [onlineBusinessSearchBtn setBackgroundImage:[UIImage imageNamed:@"tb_2"] forState:UIControlStateNormal];
        [onlineBusinessSearchBtn setBackgroundImage:[UIImage imageNamed:@"tb_2dj"] forState:UIControlStateHighlighted];
        
        UILabel * onlineBusinessSearchLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE2BTNWIDTH, TYPE2BTNHEIGHT/3)];
        onlineBusinessSearchLabel.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT*6/7);
        onlineBusinessSearchLabel.text = @"在线办事查询";
        onlineBusinessSearchLabel.textColor = [UIColor whiteColor];
        onlineBusinessSearchLabel.font = [UIFont boldSystemFontOfSize:FONT];
        onlineBusinessSearchLabel.textAlignment = NSTextAlignmentCenter;
        onlineBusinessSearchLabel.backgroundColor = [UIColor clearColor];
        [onlineBusinessSearchBtn addSubview:onlineBusinessSearchLabel];
        
        UIImageView * onlineBusinessSearchImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zxbscx"]];
        onlineBusinessSearchImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        onlineBusinessSearchImgView.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT/2 - onlineBusinessSearchLabel.frame.size.height/3-2);
        
        [onlineBusinessSearchBtn addSubview:onlineBusinessSearchLabel];
        [onlineBusinessSearchBtn addSubview:onlineBusinessSearchImgView];
        [self.view addSubview:onlineBusinessSearchBtn];
        
        //热点办事事项
        UIButton * hotWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        hotWorkBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*3+TYPE2BTNHEIGHT*2,TYPE2BTNWIDTH,TYPE2BTNHEIGHT);
        [hotWorkBtn addTarget:self action:@selector(jumpPageForAnnouncementOfWork:) forControlEvents:UIControlEventTouchUpInside];
        hotWorkBtn.tag = 4;
        [hotWorkBtn setBackgroundImage:[UIImage imageNamed:@"tb_2"] forState:UIControlStateNormal];
        [hotWorkBtn setBackgroundImage:[UIImage imageNamed:@"tb_2dj"] forState:UIControlStateHighlighted];
        
        UILabel * hotWorkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE2BTNWIDTH, TYPE2BTNHEIGHT/3)];
        hotWorkLabel.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT*6/7);
        hotWorkLabel.text = @"热点办事事项";
        hotWorkLabel.textColor = [UIColor whiteColor];
        hotWorkLabel.font = [UIFont boldSystemFontOfSize:FONT];
        hotWorkLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * hotWorkImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rdbssx"]];
        hotWorkImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        hotWorkImgView.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT/2 - hotWorkLabel.frame.size.height/3);
        
        [hotWorkBtn addSubview:hotWorkLabel];
        [hotWorkBtn addSubview:hotWorkImgView];
        [self.view addSubview:hotWorkBtn];
    }
    return self;
}

-(void)jumpPageForAnnouncementOfWork:(UIButton *)btn{
    DetailWebViewController * detailViewController = [DetailWebViewController alloc];
    StatisticsOfWorkViewController * statisticsOfWorkViewController = [StatisticsOfWorkViewController alloc];
    OnlineBusinessSearchViewController * onlineBusinessSearchViewController = [OnlineBusinessSearchViewController alloc];
    HotBusinessViewController * detailTableViewController = [HotBusinessViewController alloc];
    NSMutableArray * segLabelArray = [[NSMutableArray alloc]initWithObjects:@"办事公告", nil];
    switch (btn.tag) {
        case 1:
            appDelegate.sonTitle = @"办事公告";
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:segLabelArray];
            [appDelegate.conAPI getAnnouncementOfWorkList];
            [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
            [self.navigationController pushViewController:detailViewController animated:YES];
            break;
        case 2:
            appDelegate.sonTitle = @"办件统计";
            statisticsOfWorkViewController = [statisticsOfWorkViewController init];             //为了statisticsOfWorkViewController读进去sontitle  只能复制后再初始化
            [appDelegate.conAPI getStatisticsOfWork];
            [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
            [self.navigationController pushViewController:statisticsOfWorkViewController animated:YES];
            
            break;
        case 3:
            appDelegate.sonTitle = @"在线办事";
            onlineBusinessSearchViewController = [onlineBusinessSearchViewController init];             //为了statisticsOfWorkViewController读进去sontitle  只能复制后再初始化
            [self.navigationController pushViewController:onlineBusinessSearchViewController animated:YES];
            break;
        case 4:
            appDelegate.sonTitle = @"热点办事";
            detailTableViewController = [detailTableViewController init];             //为了statisticsOfWorkViewController读进去sontitle  只能复制后再初始化
            //[appDelegate.conAPI getHotBusinessListWithPageSize:<#(NSString *)#> andCurPage:<#(NSString *)#>];
            //[GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
            [self.navigationController pushViewController:detailTableViewController animated:YES];
            break;
            
        default:
            break;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.titleLabel.text = @"办事公告";
    appDelegate.title = @"办事公告";
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
