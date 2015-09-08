//
//  IntoPZHViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "IntoPZHViewController.h"
#import "PicForPZHViewController.h"
#import "VideoForPZHViewController.h"
#import "AppDelegate.h"
#import "DetailWebViewController.h"
#import "EconomyViewController.h"
#import "GMDCircleLoader.h"
@interface IntoPZHViewController (){
    AppDelegate * appDelegate;
}

@end

@implementation IntoPZHViewController
@synthesize videoForPZHBtn,picForPZHBtn,cityOverview,economyOverview,naturalOverview,titleLabel;

#define INTERVALX (UISCREENWIDTH*2/25)
#define INTERVALY (INTERVALX*2/3.)
#define FONT 14
#define TYPE1BTNWIDTH ((UISCREENWIDTH - INTERVALX*2.5)/2)
#define TYPE1BTNHEIGHT (UISCREENHEIGHT/7)
#define TYPE2BTNWIDTH (UISCREENWIDTH - INTERVALX*2)
#define TYPE2BTNHEIGHT TYPE1BTNHEIGHT


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
        
        UIImageView * backgroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        backgroundImageView.image = [UIImage imageNamed:@"bjgy"];
        [self.view addSubview:backgroundImageView];
        
        UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH*4/9,UISCREENWIDTH*4/9/400*60 )];
        logoImageView.center = CGPointMake(self.view.center.x, UISCREENHEIGHT - NAVIGATIONHIGHT*2/3);
        logoImageView.image = [UIImage imageNamed:@"bg_wenzi"];
        [self.view addSubview:logoImageView];
        
        //市情概况
        self.cityOverview = [[NSMutableArray alloc]initWithObjects:@"市情概况", nil];
        
        UIButton * cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cityBtn.frame = CGRectMake(INTERVALX,INTERVALY + NAVIGATIONHIGHT,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);;
        [cityBtn addTarget:self action:@selector(jumpPageForIntoPZH:) forControlEvents:UIControlEventTouchUpInside];
        cityBtn.tag = 1;
        [cityBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [cityBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * cityOverviewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        cityOverviewLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        cityOverviewLabel.text = @"市情概况";
        cityOverviewLabel.textColor = [UIColor whiteColor];
        cityOverviewLabel.font = [UIFont boldSystemFontOfSize:FONT];
        cityOverviewLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * cityOverviewImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sqgk"]];
        cityOverviewImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        cityOverviewImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - cityOverviewLabel.frame.size.height/3);
        
        [cityBtn addSubview:cityOverviewLabel];
        [cityBtn addSubview:cityOverviewImgView];
        [self.view addSubview:cityBtn];
        
        //自然概况
        self.naturalOverview = [[NSMutableArray alloc]initWithObjects:@"地理位置",@"行政区划",@"自然资源",@"自然概貌",@"建置人口",@"历史沿革", nil];
        UIButton * naturalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        naturalBtn.frame = CGRectMake(INTERVALX*1.5 + TYPE1BTNWIDTH,INTERVALY + NAVIGATIONHIGHT,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);
        [naturalBtn addTarget:self action:@selector(jumpPageForIntoPZH:) forControlEvents:UIControlEventTouchUpInside];
        naturalBtn.tag = 2;
        
        [naturalBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [naturalBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * naturalOverviewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        naturalOverviewLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        naturalOverviewLabel.text = @"自然概况";
        naturalOverviewLabel.textColor = [UIColor whiteColor];
        naturalOverviewLabel.font = [UIFont boldSystemFontOfSize:FONT];
        naturalOverviewLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * naturalOverviewImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zrgk"]];
        naturalOverviewImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        naturalOverviewImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - naturalOverviewLabel.frame.size.height/3);

        [naturalBtn addSubview:naturalOverviewLabel];
        [naturalBtn addSubview:naturalOverviewImgView];
        [self.view addSubview:naturalBtn];
        
        //国民经济
        self.economyOverview = [[NSMutableArray alloc]initWithObjects:@"经济综述",@"农业",@"收入与消费",@"房地产业",@"工业",@"金融保险业",@"运输邮电",@"建筑业",@"固定资产投资",@"财政税收", nil];
        UIButton * economyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        economyBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*2+TYPE2BTNHEIGHT,TYPE2BTNWIDTH,TYPE2BTNHEIGHT);
        [economyBtn addTarget:self action:@selector(jumpPageForIntoPZH:) forControlEvents:UIControlEventTouchUpInside];
        economyBtn.tag = 3;
        [economyBtn setBackgroundImage:[UIImage imageNamed:@"tb_2"] forState:UIControlStateNormal];
        [economyBtn setBackgroundImage:[UIImage imageNamed:@"tb_2dj"] forState:UIControlStateHighlighted];
        
        UILabel * economyOverviewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE2BTNWIDTH, TYPE2BTNHEIGHT/3)];
        economyOverviewLabel.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT*6/7);
        economyOverviewLabel.text = @"国民经济";
        economyOverviewLabel.textColor = [UIColor whiteColor];
        economyOverviewLabel.font = [UIFont boldSystemFontOfSize:FONT];
        economyOverviewLabel.textAlignment = NSTextAlignmentCenter;
        economyOverviewLabel.backgroundColor = [UIColor clearColor];
        [economyBtn addSubview:economyOverviewLabel];
        
        UIImageView * economyOverviewImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gmjj.png"]];
        economyOverviewImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        economyOverviewImgView.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT/2 - naturalOverviewLabel.frame.size.height/3);

        [economyBtn addSubview:economyOverviewLabel];
        [economyBtn addSubview:economyOverviewImgView];
        [self.view addSubview:economyBtn];
        
        //图看攀枝花
        self.picForPZHBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //self.picForPZHBtn.backgroundColor = [UIColor lightGrayColor];
        self.picForPZHBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*3+TYPE2BTNHEIGHT*2,TYPE2BTNWIDTH,TYPE2BTNHEIGHT);
        [self.picForPZHBtn addTarget:self action:@selector(jumpPageForIntoPZH:) forControlEvents:UIControlEventTouchUpInside];
        self.picForPZHBtn.tag = 4;
        
        [self.picForPZHBtn setBackgroundImage:[UIImage imageNamed:@"tb_2"] forState:UIControlStateNormal];
        [self.picForPZHBtn setBackgroundImage:[UIImage imageNamed:@"tb_2dj"] forState:UIControlStateHighlighted];
        
        UILabel * picForPZHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE2BTNWIDTH, TYPE2BTNHEIGHT/3)];
        picForPZHLabel.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT*6/7);
        picForPZHLabel.text = @"图看攀枝花";
        picForPZHLabel.textColor = [UIColor whiteColor];
        picForPZHLabel.font = [UIFont boldSystemFontOfSize:FONT];
        picForPZHLabel.textAlignment = NSTextAlignmentCenter;
        picForPZHLabel.backgroundColor = [UIColor clearColor];
        [self.picForPZHBtn addSubview:picForPZHLabel];
        
        UIImageView * picForPZHImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tkpzh"]];
        picForPZHImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        picForPZHImgView.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT/2 - picForPZHLabel.frame.size.height/3);
        
        [self.picForPZHBtn addSubview:picForPZHLabel];
        [self.picForPZHBtn addSubview:picForPZHImgView];
        [self.view addSubview:self.picForPZHBtn];
        
        
        //视频攀枝花
        self.videoForPZHBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //self.videoForPZHBtn.backgroundColor = [UIColor lightGrayColor];
        self.videoForPZHBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*4+TYPE2BTNHEIGHT*3,TYPE2BTNWIDTH,TYPE2BTNHEIGHT);
        [self.videoForPZHBtn addTarget:self action:@selector(jumpPageForIntoPZH:) forControlEvents:UIControlEventTouchUpInside];
        self.videoForPZHBtn.tag = 5;
        [self.videoForPZHBtn setBackgroundImage:[UIImage imageNamed:@"tb_2"] forState:UIControlStateNormal];
        [self.videoForPZHBtn setBackgroundImage:[UIImage imageNamed:@"tb_2dj"] forState:UIControlStateHighlighted];
        
        UILabel * videoForPZHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE2BTNWIDTH, TYPE2BTNHEIGHT/3)];
        videoForPZHLabel.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT*6/7);
        videoForPZHLabel.text = @"视频攀枝花";
        videoForPZHLabel.textColor = [UIColor whiteColor];
        videoForPZHLabel.font = [UIFont boldSystemFontOfSize:FONT];
        videoForPZHLabel.textAlignment = NSTextAlignmentCenter;
        videoForPZHLabel.backgroundColor = [UIColor clearColor];
        [self.videoForPZHBtn addSubview:videoForPZHLabel];
        
        UIImageView * videoForPZHImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sppzh"]];
        videoForPZHImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        videoForPZHImgView.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT/2 - picForPZHLabel.frame.size.height/3);
        
        [self.videoForPZHBtn addSubview:videoForPZHLabel];
        [self.videoForPZHBtn addSubview:videoForPZHImgView];
        [self.view addSubview:self.videoForPZHBtn];
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
    appDelegate.title = @"走进攀枝花";
    self.titleLabel.text = @"走进攀枝花";
}

-(void)jumpPageForIntoPZH:(UIButton *)btn{
    PicForPZHViewController * picForPZH = [[PicForPZHViewController alloc]init];
    VideoForPZHViewController * videoForPZH = [[VideoForPZHViewController alloc]init];
    DetailWebViewController * detailViewController = [DetailWebViewController alloc];
    EconomyViewController * economyViewController = [[EconomyViewController alloc]init];
    switch (btn.tag) {
        case 1:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.cityOverview];
            appDelegate.title = @"市情概况";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"走进攀枝花" andChannelNext:@"市情概况"];
            [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];

            break;
        case 2:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.naturalOverview];
            appDelegate.title = @"自然概况";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"自然概况" andChannelNext:@"地理位置"];
            [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];

            //[appDelegate playStreamFromURL:[NSURL URLWithString:@"http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4"]];
            break;
        case 3:
            appDelegate.title = @"国民经济";
            [self.navigationController pushViewController:economyViewController animated:YES];
            //[appDelegate.conAPI getMenuContentAPIWithChannelName:@"自然概况" andChannelNext:@"地理位置"];
            break;
        case 4:
            appDelegate.title = @"图看攀枝花";
            //[self.navigationController pushViewController:collectionViewController animated:YES];
            [self.navigationController pushViewController:picForPZH animated:YES];
            //[appDelegate.conAPI getPicForPZHAPIWithChannelName:@"图看攀枝花" andHannelNext:@"城市新貌" andPageSize:@"15" andCurPage:@"1"];
            //[GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];

            break;
        case 5:
            appDelegate.title = @"视频攀枝花";
            [self.navigationController pushViewController:videoForPZH animated:YES];
            [appDelegate.conAPI getVideoForPZHAPIWithChannelName:@"视频攀枝花" andChannelNext:@"形象片"];
            [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];

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
