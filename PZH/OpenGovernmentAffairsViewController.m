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
#define INTERVALX UISCREENWIDTH/18
#define INTERVALY UISCREENHEIGHT/35
#define MAINBTNWIDTH UISCREENWIDTH*1/3
#define MAINBTNHEIGHT UISCREENWIDTH/4
@synthesize countyNewsArray,leadersActivitiesArray,dynamicOfDepartmentArray,workConferenceArray,announcementOfPublicArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        UIScrollView * scrView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        scrView.contentSize =  CGSizeMake( UISCREENWIDTH, NAVIGATIONHIGHT+MAINBTNHEIGHT*5+INTERVALY*6);
        scrView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:scrView];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        
        UIImageView * splitLineImgView1 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"xian.png"]];
        splitLineImgView1.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT+INTERVALY*1.5, UISCREENWIDTH, 1);
        [scrView addSubview:splitLineImgView1];
        UIImageView * splitLineImgView2 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"xian.png"]];
        splitLineImgView2.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT*2+INTERVALY*2.5, UISCREENWIDTH, 1);
        [scrView addSubview:splitLineImgView2];
        UIImageView * splitLineImgView3 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"xian.png"]];
        splitLineImgView3.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT*3+INTERVALY*3.5, UISCREENWIDTH, 1);
        [scrView addSubview:splitLineImgView3];
        UIImageView * splitLineImgView4 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"xian.png"]];
        splitLineImgView4.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT*4+INTERVALY*4.5, UISCREENWIDTH, 1);
        [scrView addSubview:splitLineImgView4];
        UIImageView * splitLineImgView5 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"xian.png"]];
        splitLineImgView5.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT*5+INTERVALY*5.5, UISCREENWIDTH, 1);
        [scrView addSubview:splitLineImgView5];
        
        //公告公示
        self.announcementOfPublicArray = [[NSMutableArray alloc]initWithObjects:@"公告公示", nil];
        
        UIButton * announcementOfPublicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        announcementOfPublicBtn.frame = CGRectMake(0,NAVIGATIONHIGHT,UISCREENWIDTH,MAINBTNHEIGHT+INTERVALY*1.5);
        [announcementOfPublicBtn addTarget:self action:@selector(jumpPageForOpenGovernmentAffairs:) forControlEvents:UIControlEventTouchUpInside];
        announcementOfPublicBtn.tag = 1;
        [announcementOfPublicBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * announcementOfPublicLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        announcementOfPublicLabel.text = @"公告公示";
        announcementOfPublicLabel.font = [UIFont systemFontOfSize:12];
        announcementOfPublicLabel.textAlignment = NSTextAlignmentLeft;
        [announcementOfPublicBtn addSubview:announcementOfPublicLabel];
        
        UIImageView * announcementOfPublicImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gggs.png"]];
        announcementOfPublicImgView.frame = CGRectMake(INTERVALX,INTERVALY,MAINBTNWIDTH,MAINBTNHEIGHT);
        UIImage * announcementOfPublicLabelImg = [UIImage imageNamed:@"zi_1.png"];
        UIImageView * cannouncementOfPublicLabelImgView = [[UIImageView alloc]initWithImage:announcementOfPublicLabelImg];
        cannouncementOfPublicLabelImgView.frame = CGRectMake(0, 0, announcementOfPublicLabelImg.size.width/3.3, announcementOfPublicLabelImg.size.height/3.3);
        cannouncementOfPublicLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [announcementOfPublicImgView addSubview:cannouncementOfPublicLabelImgView];
        [announcementOfPublicBtn addSubview:announcementOfPublicImgView];
        [scrView addSubview:announcementOfPublicBtn];
        
        //领导活动
        self.leadersActivitiesArray = [[NSMutableArray alloc]initWithObjects:@"讲话",@"活动",@"会议",@"调研",@"其他", nil];
        UIButton * leadersActivitiesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leadersActivitiesBtn.frame = CGRectMake(0,NAVIGATIONHIGHT+INTERVALY*1.5+MAINBTNHEIGHT,UISCREENWIDTH,MAINBTNHEIGHT+INTERVALY);
        [leadersActivitiesBtn addTarget:self action:@selector(jumpPageForOpenGovernmentAffairs:) forControlEvents:UIControlEventTouchUpInside];
        leadersActivitiesBtn.tag = 2;
        [leadersActivitiesBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * leadersActivitiesLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        leadersActivitiesLabel1.text = @"讲话   活动   会议";
        leadersActivitiesLabel1.font = [UIFont systemFontOfSize:12];
        leadersActivitiesLabel1.textAlignment = NSTextAlignmentLeft;
        [leadersActivitiesBtn addSubview:leadersActivitiesLabel1];
        UILabel * leadersActivitiesLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+leadersActivitiesLabel1.frame.size.height, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        leadersActivitiesLabel2.text = @"调研   其他";
        leadersActivitiesLabel2.font = [UIFont systemFontOfSize:12];
        leadersActivitiesLabel2.textAlignment = NSTextAlignmentLeft;
        [leadersActivitiesBtn addSubview:leadersActivitiesLabel2];
        
        UIImageView * leadersActivitiesImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ldhd.png"]];
        leadersActivitiesImgView.frame = CGRectMake(INTERVALX,INTERVALY/2,MAINBTNWIDTH,MAINBTNHEIGHT);;
        UIImage * leadersActivitiesLabelImg = [UIImage imageNamed:@"zi_2.png"];
        UIImageView * leadersActivitiesLabelImgView = [[UIImageView alloc]initWithImage:leadersActivitiesLabelImg];
        leadersActivitiesLabelImgView.frame = CGRectMake(0, 0, leadersActivitiesLabelImg.size.width/3.3, leadersActivitiesLabelImg.size.height/3.3);
        leadersActivitiesLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [leadersActivitiesImgView addSubview:leadersActivitiesLabelImgView];
        [leadersActivitiesBtn addSubview:leadersActivitiesImgView];
        [scrView addSubview:leadersActivitiesBtn];
        
        //工作会议
        self.workConferenceArray = [[NSMutableArray alloc]initWithObjects:@"市委会议",@"政府会议",@"人大会议",@"政协会议", nil];
        UIButton * workConferenceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        workConferenceBtn.frame = CGRectMake(0,NAVIGATIONHIGHT+INTERVALY*2.5+MAINBTNHEIGHT*2,UISCREENWIDTH,MAINBTNHEIGHT+INTERVALY);
        [workConferenceBtn addTarget:self action:@selector(jumpPageForOpenGovernmentAffairs:) forControlEvents:UIControlEventTouchUpInside];
        workConferenceBtn.tag = 3;
        [workConferenceBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * workConferenceLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        workConferenceLabel1.text = @"市委会议   政府会议    人大会议";
        workConferenceLabel1.font = [UIFont systemFontOfSize:12];
        workConferenceLabel1.textAlignment = NSTextAlignmentLeft;
        workConferenceLabel1.backgroundColor = [UIColor clearColor];
        [workConferenceBtn addSubview:workConferenceLabel1];
        UILabel * workConferenceLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+workConferenceLabel1.frame.size.height, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        workConferenceLabel2.text = @"政协会议";
        workConferenceLabel2.font = [UIFont systemFontOfSize:12];
        workConferenceLabel2.textAlignment = NSTextAlignmentLeft;
        [workConferenceBtn addSubview:workConferenceLabel2];
        
        UIImageView * workConferenceImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gzhy.png"]];
        workConferenceImgView.frame = CGRectMake(INTERVALX,INTERVALY/2,MAINBTNWIDTH,MAINBTNHEIGHT);
        UIImage * workConferenceLabelImg = [UIImage imageNamed:@"zi_3.png"];
        UIImageView * workConferenceLabelImgView = [[UIImageView alloc]initWithImage:workConferenceLabelImg];
        workConferenceLabelImgView.frame = CGRectMake(0, 0, workConferenceLabelImg.size.width/3.3, workConferenceLabelImg.size.height/3.3);
        workConferenceLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [workConferenceImgView addSubview:workConferenceLabelImgView];
        [workConferenceBtn addSubview:workConferenceImgView];
        [scrView addSubview:workConferenceBtn];
        
        //部门动态
        self.dynamicOfDepartmentArray = [[NSMutableArray alloc]initWithObjects:@"部门会议", nil];
        UIButton * dynamicOfdepartmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dynamicOfdepartmentBtn.frame = CGRectMake(0,NAVIGATIONHIGHT+INTERVALY*3.5+MAINBTNHEIGHT*3,UISCREENWIDTH,MAINBTNHEIGHT+INTERVALY);
        [dynamicOfdepartmentBtn addTarget:self action:@selector(jumpPageForOpenGovernmentAffairs:) forControlEvents:UIControlEventTouchUpInside];
        dynamicOfdepartmentBtn.tag = 3;
        [dynamicOfdepartmentBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * dynamicOfdepartmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        dynamicOfdepartmentLabel.text = @"部门会议";
        dynamicOfdepartmentLabel.font = [UIFont systemFontOfSize:12];
        dynamicOfdepartmentLabel.textAlignment = NSTextAlignmentLeft;
        dynamicOfdepartmentLabel.backgroundColor = [UIColor clearColor];
        [dynamicOfdepartmentBtn addSubview:dynamicOfdepartmentLabel];
        
        UIImageView * dynamicOfdepartmentImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bmdt.png"]];
        dynamicOfdepartmentImgView.frame = CGRectMake(INTERVALX,INTERVALY/2,MAINBTNWIDTH,MAINBTNHEIGHT);
        UIImage * dynamicOfdepartmentLabelImg = [UIImage imageNamed:@"zi_4.png"];
        UIImageView * dynamicOfdepartmentLabelImgView = [[UIImageView alloc]initWithImage:dynamicOfdepartmentLabelImg];
        dynamicOfdepartmentLabelImgView.frame = CGRectMake(0, 0, dynamicOfdepartmentLabelImg.size.width/3.3, dynamicOfdepartmentLabelImg.size.height/3.3);
        dynamicOfdepartmentLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [dynamicOfdepartmentImgView addSubview:dynamicOfdepartmentLabelImgView];
        [dynamicOfdepartmentBtn addSubview:dynamicOfdepartmentImgView];
        [scrView addSubview:dynamicOfdepartmentBtn];
        
        //区县快讯
        self.countyNewsArray = [[NSMutableArray alloc]initWithObjects:@"区县快讯", nil];
        UIButton * countyNewsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        countyNewsBtn.frame = CGRectMake(0,NAVIGATIONHIGHT+INTERVALY*4.5+MAINBTNHEIGHT*4,UISCREENWIDTH,MAINBTNHEIGHT+INTERVALY);
        [countyNewsBtn addTarget:self action:@selector(jumpPageForOpenGovernmentAffairs:) forControlEvents:UIControlEventTouchUpInside];
        countyNewsBtn.tag = 3;
        [countyNewsBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * countyNewsLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        countyNewsLabel.text = @"区县快讯";
        countyNewsLabel.font = [UIFont systemFontOfSize:12];
        countyNewsLabel.textAlignment = NSTextAlignmentLeft;
        countyNewsLabel.backgroundColor = [UIColor clearColor];
        [countyNewsBtn addSubview:countyNewsLabel];
        
        UIImageView * countyNewsImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qxkx.png"]];
        countyNewsImgView.frame = CGRectMake(INTERVALX,INTERVALY/2,MAINBTNWIDTH,MAINBTNHEIGHT);
        UIImage * countyNewsLabelImg = [UIImage imageNamed:@"zi_5.png"];
        UIImageView * countyNewsLabelImgView = [[UIImageView alloc]initWithImage:countyNewsLabelImg];
        countyNewsLabelImgView.frame = CGRectMake(0, 0, countyNewsLabelImg.size.width/3.3, countyNewsLabelImg.size.height/3.3);
        countyNewsLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [countyNewsImgView addSubview:countyNewsLabelImgView];
        [countyNewsBtn addSubview:countyNewsImgView];
        [scrView addSubview:countyNewsBtn];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //appDelegate.title = @"走进攀枝花";
    self.titleLabel.text = @"政务公开";
    appDelegate.parentTitle = @"政务公开";
}

- (void)jumpPageForOpenGovernmentAffairs:(UIButton *)btn{
    NewsViewController * newsViewController = [NewsViewController alloc];
//    VideoForPZHViewController * videoForPZH = [[VideoForPZHViewController alloc]init];
//    DetailWebViewController * detailViewController = [DetailWebViewController alloc];
//    EconomyViewController * economyViewController = [[EconomyViewController alloc]init];
    switch (btn.tag) {
        case 1:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.cityOverview];
            appDelegate.title = @"公告公示";
            newsViewController = [newsViewController init];
            [self.navigationController pushViewController:newsViewController animated:YES];
//            [appDelegate.conAPI getAnnouncementOfPublicArrayListWithPageSize:@"15" andCurPage:@"1"];
//            [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
            
            break;
        case 2:
            appDelegate.title = @"领导活动";
            newsViewController = [newsViewController init];
            [self.navigationController pushViewController:newsViewController animated:YES];
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.naturalOverview];
//            appDelegate.title = @"自然概况";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"自然概况" andChannelNext:@"地理位置"];
//            [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
            
            break;
        case 3:
//            appDelegate.title = @"国民经济";
//            [self.navigationController pushViewController:economyViewController animated:YES];
//            //[appDelegate.conAPI getMenuContentAPIWithChannelName:@"自然概况" andChannelNext:@"地理位置"];
            break;
        case 4:
//            appDelegate.title = @"图看攀枝花";
//            //[self.navigationController pushViewController:collectionViewController animated:YES];
//            [self.navigationController pushViewController:picForPZH animated:YES];
//            //[appDelegate.conAPI getPicForPZHAPIWithChannelName:@"图看攀枝花" andHannelNext:@"城市新貌" andPageSize:@"15" andCurPage:@"1"];
//            //[GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
            
            break;
        case 5:
//            appDelegate.title = @"视频攀枝花";
//            [self.navigationController pushViewController:videoForPZH animated:YES];
//            [appDelegate.conAPI getVideoForPZHAPIWihtChannelName:@"视频攀枝花" andChannelNext:@"形象片"];
//            [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
            
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
