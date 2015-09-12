//
//  OpenGovernmentAffairsViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/24.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "OpenGovernmentAffairsViewController.h"
#import "AppDelegate.h"
#import "NewsViewController.h"
@interface OpenGovernmentAffairsViewController (){
    AppDelegate * appDelegate;
}

@end

@implementation OpenGovernmentAffairsViewController
#define INTERVALX (UISCREENWIDTH*2/25)
#define INTERVALY (INTERVALX*2/3.)
#define FONT 14
#define TYPE1BTNWIDTH ((UISCREENWIDTH - INTERVALX*2.5)/2)
#define TYPE1BTNHEIGHT (UISCREENHEIGHT/7)
#define TYPE2BTNWIDTH (UISCREENWIDTH - INTERVALX*2)
#define TYPE2BTNHEIGHT TYPE1BTNHEIGHT

@synthesize countyNewsArray,leadersActivitiesArray,dynamicOfDepartmentArray,workConferenceArray,announcementOfPublicArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        
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
        
        //公告公示
        self.announcementOfPublicArray = [[NSMutableArray alloc]initWithObjects:@"公告公示", nil];
        
        UIButton * announcementOfPublicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        announcementOfPublicBtn.frame = CGRectMake(INTERVALX,INTERVALY + NAVIGATIONHIGHT,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);;
        [announcementOfPublicBtn addTarget:self action:@selector(jumpPageForOpenGovernmentAffairs:) forControlEvents:UIControlEventTouchUpInside];
        announcementOfPublicBtn.tag = 1;
        [announcementOfPublicBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [announcementOfPublicBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * announcementOfPublicLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        announcementOfPublicLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        announcementOfPublicLabel.text = @"公告公示";
        announcementOfPublicLabel.textColor = [UIColor whiteColor];
        announcementOfPublicLabel.font = [UIFont boldSystemFontOfSize:FONT];
        announcementOfPublicLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * announcementOfPublicImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gggs"]];
        announcementOfPublicImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        announcementOfPublicImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - announcementOfPublicLabel.frame.size.height/3);
        
        [announcementOfPublicBtn addSubview:announcementOfPublicLabel];
        [announcementOfPublicBtn addSubview:announcementOfPublicImgView];
        [self.view addSubview:announcementOfPublicBtn];
        
        //领导活动
        self.leadersActivitiesArray = [[NSMutableArray alloc]initWithObjects:@"讲话",@"活动",@"会议",@"调研",@"其他", nil];
        
        UIButton * leadersActivitiesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leadersActivitiesBtn.frame = CGRectMake(INTERVALX*1.5 + TYPE1BTNWIDTH,INTERVALY + NAVIGATIONHIGHT,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);
        [leadersActivitiesBtn addTarget:self action:@selector(jumpPageForOpenGovernmentAffairs:) forControlEvents:UIControlEventTouchUpInside];
        leadersActivitiesBtn.tag = 2;
        
        [leadersActivitiesBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [leadersActivitiesBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * leadersActivitiesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        leadersActivitiesLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        leadersActivitiesLabel.text = @"领导活动";
        leadersActivitiesLabel.textColor = [UIColor whiteColor];
        leadersActivitiesLabel.font = [UIFont boldSystemFontOfSize:FONT];
        leadersActivitiesLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * leadersActivitiesImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ldhd"]];
        leadersActivitiesImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        leadersActivitiesImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - leadersActivitiesLabel.frame.size.height/3);
        
        [leadersActivitiesBtn addSubview:leadersActivitiesLabel];
        [leadersActivitiesBtn addSubview:leadersActivitiesImgView];
        [self.view addSubview:leadersActivitiesBtn];
        
        //工作会议
        self.workConferenceArray = [[NSMutableArray alloc]initWithObjects:@"市委会议",@"政府会议",@"人大会议",@"政协会议", nil];
        
        UIButton * workConferenceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        workConferenceBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*2+TYPE2BTNHEIGHT,TYPE2BTNWIDTH,TYPE2BTNHEIGHT);
        [workConferenceBtn addTarget:self action:@selector(jumpPageForOpenGovernmentAffairs:) forControlEvents:UIControlEventTouchUpInside];
        workConferenceBtn.tag = 3;
        [workConferenceBtn setBackgroundImage:[UIImage imageNamed:@"tb_2"] forState:UIControlStateNormal];
        [workConferenceBtn setBackgroundImage:[UIImage imageNamed:@"tb_2dj"] forState:UIControlStateHighlighted];
        
        UILabel * workConferenceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE2BTNWIDTH, TYPE2BTNHEIGHT/3)];
        workConferenceLabel.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT*6/7);
        workConferenceLabel.text = @"工作会议";
        workConferenceLabel.textColor = [UIColor whiteColor];
        workConferenceLabel.font = [UIFont boldSystemFontOfSize:FONT];
        workConferenceLabel.textAlignment = NSTextAlignmentCenter;
        workConferenceLabel.backgroundColor = [UIColor clearColor];
        [workConferenceBtn addSubview:workConferenceLabel];
        
        UIImageView * workConferenceImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gzhy"]];
        workConferenceImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        workConferenceImgView.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT/2 - workConferenceLabel.frame.size.height/3);
        
        [workConferenceBtn addSubview:workConferenceLabel];
        [workConferenceBtn addSubview:workConferenceImgView];
        [self.view addSubview:workConferenceBtn];
        
        //部门动态
        self.dynamicOfDepartmentArray = [[NSMutableArray alloc]initWithObjects:@"部门动态", nil];
        
        UIButton * dynamicOfdepartmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dynamicOfdepartmentBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*3+TYPE2BTNHEIGHT*2,TYPE2BTNWIDTH,TYPE2BTNHEIGHT);
        [dynamicOfdepartmentBtn addTarget:self action:@selector(jumpPageForOpenGovernmentAffairs:) forControlEvents:UIControlEventTouchUpInside];
        dynamicOfdepartmentBtn.tag = 4;
        [dynamicOfdepartmentBtn setBackgroundImage:[UIImage imageNamed:@"tb_2"] forState:UIControlStateNormal];
        [dynamicOfdepartmentBtn setBackgroundImage:[UIImage imageNamed:@"tb_2dj"] forState:UIControlStateHighlighted];
        
        UILabel * dynamicOfdepartmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE2BTNWIDTH, TYPE2BTNHEIGHT/3)];
        dynamicOfdepartmentLabel.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT*6/7);
        dynamicOfdepartmentLabel.text = @"部门动态";
        dynamicOfdepartmentLabel.textColor = [UIColor whiteColor];
        dynamicOfdepartmentLabel.font = [UIFont boldSystemFontOfSize:FONT];
        dynamicOfdepartmentLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * dynamicOfdepartmentImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bmdt"]];
        dynamicOfdepartmentImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        dynamicOfdepartmentImgView.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT/2 - workConferenceLabel.frame.size.height/3);
        
        [dynamicOfdepartmentBtn addSubview:dynamicOfdepartmentLabel];
        [dynamicOfdepartmentBtn addSubview:dynamicOfdepartmentImgView];
        [self.view addSubview:dynamicOfdepartmentBtn];
        
        //区县快讯
        self.countyNewsArray = [[NSMutableArray alloc]initWithObjects:@"区县快讯", nil];
        
        UIButton * countyNewsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        countyNewsBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*4+TYPE2BTNHEIGHT*3,TYPE2BTNWIDTH,TYPE2BTNHEIGHT);
        [countyNewsBtn addTarget:self action:@selector(jumpPageForOpenGovernmentAffairs:) forControlEvents:UIControlEventTouchUpInside];
        countyNewsBtn.tag = 5;
        [countyNewsBtn setBackgroundImage:[UIImage imageNamed:@"tb_2"] forState:UIControlStateNormal];
        [countyNewsBtn setBackgroundImage:[UIImage imageNamed:@"tb_2dj"] forState:UIControlStateHighlighted];
        
        UILabel * countyNewsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE2BTNWIDTH, TYPE2BTNHEIGHT/3)];
        countyNewsLabel.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT*6/7);
        countyNewsLabel.text = @"区县快讯";
        countyNewsLabel.textColor = [UIColor whiteColor];
        countyNewsLabel.font = [UIFont boldSystemFontOfSize:FONT];
        countyNewsLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * countyNewsImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qxkx"]];
        countyNewsImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        countyNewsImgView.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT/2 - workConferenceLabel.frame.size.height/3);
        
        [countyNewsBtn addSubview:countyNewsLabel];
        [countyNewsBtn addSubview:countyNewsImgView];
        [self.view addSubview:countyNewsBtn];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14, 23)];
    backImageView.image = [UIImage imageNamed:@"fh"];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 14, 24);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImageView];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = backItem;
    backItem.customView = backBtn;
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //appDelegate.title = @"走进攀枝花";
    self.titleLabel.text = @"政务公开";
    appDelegate.title = @"政务公开";
}

- (void)jumpPageForOpenGovernmentAffairs:(UIButton *)btn{
    NewsViewController * newsViewController = [NewsViewController alloc];
    switch (btn.tag) {
        case 1:
            appDelegate.title = @"公告公示";
            newsViewController = [newsViewController init];
            [self.navigationController pushViewController:newsViewController animated:YES];
            break;
        case 2:
            appDelegate.title = @"领导活动";
            newsViewController = [newsViewController init];
            [self.navigationController pushViewController:newsViewController animated:YES];
            break;
        case 3:
            appDelegate.title = @"工作会议";
            newsViewController = [newsViewController init];
            [self.navigationController pushViewController:newsViewController animated:YES];
            break;
        case 4:
            appDelegate.title = @"部门动态";
            newsViewController = [newsViewController init];
            [self.navigationController pushViewController:newsViewController animated:YES];
            break;
        case 5:
            appDelegate.title = @"区县快讯";
            newsViewController = [newsViewController init];
            [self.navigationController pushViewController:newsViewController animated:YES];
            break;
            
            break;
        default:
            break;
    }
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
