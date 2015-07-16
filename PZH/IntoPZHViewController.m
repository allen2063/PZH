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

#define INTERVALX UISCREENWIDTH/18
#define INTERVALY UISCREENHEIGHT/35
#define MAINBTNWIDTH UISCREENWIDTH*1/3
#define MAINBTNHEIGHT UISCREENWIDTH/4


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.title = @"走进攀枝花";
        //appDelegate.title =@"走进攀枝花";
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        
        UIImageView * splitLineImgView1 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"Line"]];
        splitLineImgView1.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT+INTERVALY*1.5, UISCREENWIDTH, 1);
        [self.view addSubview:splitLineImgView1];
        UIImageView * splitLineImgView2 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"Line"]];
        splitLineImgView2.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT*2+INTERVALY*2.5, UISCREENWIDTH, 1);
        [self.view addSubview:splitLineImgView2];
        UIImageView * splitLineImgView3 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"Line"]];
        splitLineImgView3.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT*3+INTERVALY*3.5, UISCREENWIDTH, 1);
        [self.view addSubview:splitLineImgView3];

        //市情概况
        self.cityOverview = [[NSMutableArray alloc]initWithObjects:@"市情概况", nil];
        
        UIButton * cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cityBtn.frame = CGRectMake(0,NAVIGATIONHIGHT,UISCREENWIDTH,MAINBTNHEIGHT+INTERVALY*1.5);
        [cityBtn addTarget:self action:@selector(jumpPageForIntoPZH:) forControlEvents:UIControlEventTouchUpInside];
        cityBtn.tag = 1;
        [cityBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * cityOverviewLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        cityOverviewLabel.text = @"市情概况";
        cityOverviewLabel.font = [UIFont systemFontOfSize:12];
        cityOverviewLabel.textAlignment = NSTextAlignmentLeft;
        [cityBtn addSubview:cityOverviewLabel];
        
        UIImageView * cityOverviewImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tu_1.png"]];
        cityOverviewImgView.frame = CGRectMake(INTERVALX,INTERVALY,MAINBTNWIDTH,MAINBTNHEIGHT);
        UIImage * cityOverviewLabelImg = [UIImage imageNamed:@"1.png"];
        UIImageView * cityOverviewLabelImgView = [[UIImageView alloc]initWithImage:cityOverviewLabelImg];
        cityOverviewLabelImgView.frame = CGRectMake(0, 0, cityOverviewLabelImg.size.width/3.3, cityOverviewLabelImg.size.height/3.3);
        cityOverviewLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [cityOverviewImgView addSubview:cityOverviewLabelImgView];
        [cityBtn addSubview:cityOverviewImgView];
        [self.view addSubview:cityBtn];
        
        //自然概况
        self.naturalOverview = [[NSMutableArray alloc]initWithObjects:@"地理位置",@"行政区划",@"自然资源",@"自然概貌",@"建置人口",@"历史沿革", nil];
        UIButton * naturalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        naturalBtn.frame = CGRectMake(0,NAVIGATIONHIGHT+INTERVALY*1.5+MAINBTNHEIGHT,UISCREENWIDTH,MAINBTNHEIGHT+INTERVALY);
        [naturalBtn addTarget:self action:@selector(jumpPageForIntoPZH:) forControlEvents:UIControlEventTouchUpInside];
        naturalBtn.tag = 2;
        [naturalBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];

        UILabel * naturalOverviewLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        naturalOverviewLabel1.text = @"地理位置   行政区划   自然资源";
        naturalOverviewLabel1.font = [UIFont systemFontOfSize:12];
        naturalOverviewLabel1.textAlignment = NSTextAlignmentLeft;
        [naturalBtn addSubview:naturalOverviewLabel1];
        UILabel * naturalOverviewLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+naturalOverviewLabel1.frame.size.height, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        naturalOverviewLabel2.text = @"自然概貌   建置人口   历史沿革";
        naturalOverviewLabel2.font = [UIFont systemFontOfSize:12];
        naturalOverviewLabel2.textAlignment = NSTextAlignmentLeft;
        [naturalBtn addSubview:naturalOverviewLabel2];
        
        UIImageView * naturalOverviewImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tu_2.png"]];
        naturalOverviewImgView.frame = CGRectMake(INTERVALX,INTERVALY/2,MAINBTNWIDTH,MAINBTNHEIGHT);;
        UIImage * naturalOverviewLabelImg = [UIImage imageNamed:@"2.png"];
        UIImageView * naturalOverviewLabelImgView = [[UIImageView alloc]initWithImage:naturalOverviewLabelImg];
        naturalOverviewLabelImgView.frame = CGRectMake(0, 0, naturalOverviewLabelImg.size.width/3.3, naturalOverviewLabelImg.size.height/3.3);
        naturalOverviewLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);

        [naturalOverviewImgView addSubview:naturalOverviewLabelImgView];
        [naturalBtn addSubview:naturalOverviewImgView];
        [self.view addSubview:naturalBtn];
        
        //国民经济
        self.economyOverview = [[NSMutableArray alloc]initWithObjects:@"经济综述",@"农业",@"收入与消费",@"房地产业",@"工业",@"金融保险业",@"运输邮电",@"建筑业",@"固定资产投资",@"财政税收", nil];
        UIButton * economyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        economyBtn.frame = CGRectMake(0,NAVIGATIONHIGHT+INTERVALY*2.5+MAINBTNHEIGHT*2,UISCREENWIDTH,MAINBTNHEIGHT+INTERVALY);
        [economyBtn addTarget:self action:@selector(jumpPageForIntoPZH:) forControlEvents:UIControlEventTouchUpInside];
        economyBtn.tag = 3;
        [economyBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * economyOverviewLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        economyOverviewLabel1.text = @"经济综述   农业       收入与消费";
        economyOverviewLabel1.font = [UIFont systemFontOfSize:12];
        economyOverviewLabel1.textAlignment = NSTextAlignmentLeft;
        economyOverviewLabel1.backgroundColor = [UIColor clearColor];
        [economyBtn addSubview:economyOverviewLabel1];
        UILabel * economyOverviewLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+economyOverviewLabel1.frame.size.height, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        economyOverviewLabel2.text = @"房地产业   工业       金融保险业";
        economyOverviewLabel2.font = [UIFont systemFontOfSize:12];
        economyOverviewLabel2.textAlignment = NSTextAlignmentLeft;
        [economyBtn addSubview:economyOverviewLabel2];
        UILabel * economyOverviewLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7, INTERVALY/2+economyOverviewLabel1.frame.size.height*2, UISCREENWIDTH*4/7,MAINBTNHEIGHT/4)];
        economyOverviewLabel3.text = @"运输邮电   建筑业   固定资产投资";
        economyOverviewLabel3.font = [UIFont systemFontOfSize:12];
        economyOverviewLabel3.textAlignment = NSTextAlignmentLeft;
        [economyBtn addSubview:economyOverviewLabel3];
        UILabel * economyOverviewLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+economyOverviewLabel1.frame.size.height*3, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        economyOverviewLabel4.text = @"财政税收";
        economyOverviewLabel4.font = [UIFont systemFontOfSize:12];
        economyOverviewLabel4.textAlignment = NSTextAlignmentLeft;
        [economyBtn addSubview:economyOverviewLabel4];
        
        UIImageView * economyOverviewImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tu_3.png"]];
        economyOverviewImgView.frame = CGRectMake(INTERVALX,INTERVALY/2,MAINBTNWIDTH,MAINBTNHEIGHT);
        UIImage * economyOverviewLabelImg = [UIImage imageNamed:@"3.png"];
        UIImageView * economyOverviewLabelImgView = [[UIImageView alloc]initWithImage:economyOverviewLabelImg];
        economyOverviewLabelImgView.frame = CGRectMake(0, 0, economyOverviewLabelImg.size.width/3.3, economyOverviewLabelImg.size.height/3.3);
        economyOverviewLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [economyOverviewImgView addSubview:economyOverviewLabelImgView];
        [economyBtn addSubview:economyOverviewImgView];
        [self.view addSubview:economyBtn];
        
        //图看攀枝花
        self.picForPZHBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.picForPZHBtn.backgroundColor = [UIColor lightGrayColor];
        self.picForPZHBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*4+MAINBTNHEIGHT*3,MAINBTNWIDTH+INTERVALX,MAINBTNHEIGHT+INTERVALY/2);
        [self.picForPZHBtn addTarget:self action:@selector(jumpPageForIntoPZH:) forControlEvents:UIControlEventTouchUpInside];
        self.picForPZHBtn.tag = 4;
        [self.picForPZHBtn setBackgroundImage:[UIImage imageNamed:@"tu_4.png"] forState:UIControlStateNormal];
        [self.picForPZHBtn setBackgroundImage:[UIImage imageNamed:@"dj_4.png"] forState:UIControlStateHighlighted];

        UIImageView * picForPZHBtnImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tu_4.png"]];
        picForPZHBtnImgView.frame = self.picForPZHBtn.bounds;
        UIImage * picForPZHBtnLabelImg = [UIImage imageNamed:@"4.png"];
        UIImageView * picForPZHBtnLabelImgView = [[UIImageView alloc]initWithImage:picForPZHBtnLabelImg];
        picForPZHBtnLabelImgView.frame = CGRectMake(0, 0, picForPZHBtnLabelImg.size.width/3.3, picForPZHBtnLabelImg.size.height/3.3);
        picForPZHBtnLabelImgView.center = CGPointMake(self.picForPZHBtn.frame.size.width*2/3,self.picForPZHBtn.frame.size.height*3/4);
        
        [self.picForPZHBtn addSubview:picForPZHBtnLabelImgView];
        //[self.picForPZHBtn addSubview:picForPZHBtnImgView];
        
        //视频攀枝花
        self.videoForPZHBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.videoForPZHBtn.backgroundColor = [UIColor lightGrayColor];
        self.videoForPZHBtn.frame = CGRectMake(INTERVALX*4+MAINBTNWIDTH,NAVIGATIONHIGHT+INTERVALY*4+MAINBTNHEIGHT*3,MAINBTNWIDTH+INTERVALX,MAINBTNHEIGHT+INTERVALY/2);
        [self.videoForPZHBtn addTarget:self action:@selector(jumpPageForIntoPZH:) forControlEvents:UIControlEventTouchUpInside];
        self.videoForPZHBtn.tag = 5;
        [self.videoForPZHBtn setBackgroundImage:[UIImage imageNamed:@"tu_5.png"] forState:UIControlStateNormal];
        [self.videoForPZHBtn setBackgroundImage:[UIImage imageNamed:@"dj_5.png"] forState:UIControlStateHighlighted];
        UIImageView * videoForPZHBtnImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tu_5.png"]];
        videoForPZHBtnImgView.frame = self.videoForPZHBtn.bounds;
        UIImage * videoForPZHBtnLabelImg = [UIImage imageNamed:@"5.png"];
        UIImageView * videoForPZHBtnLabelImgView = [[UIImageView alloc]initWithImage:videoForPZHBtnLabelImg];
        videoForPZHBtnLabelImgView.frame = CGRectMake(0, 0, videoForPZHBtnLabelImg.size.width/3.3, videoForPZHBtnLabelImg.size.height/3.3);
        videoForPZHBtnLabelImgView.center = CGPointMake(self.picForPZHBtn.frame.size.width*2/3,self.picForPZHBtn.frame.size.height*3/4);
        
        [videoForPZHBtnImgView addSubview:videoForPZHBtnLabelImgView];
        [self.videoForPZHBtn addSubview:videoForPZHBtnLabelImgView];
        
        [self.view addSubview:self.picForPZHBtn];
        [self.view addSubview:self.videoForPZHBtn];
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
            [self.navigationController pushViewController:picForPZH animated:YES];
            [appDelegate.conAPI getPicForPZHAPIWithChannelName:@"图看攀枝花" andHannelNext:@"城市新貌" andPageSize:@"15" andCurPage:@"1"];
            [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];

            break;
        case 5:
            appDelegate.title = @"视频攀枝花";
            [self.navigationController pushViewController:videoForPZH animated:YES];
            [appDelegate.conAPI getVideoForPZHAPIWihtChannelName:@"视频攀枝花" andChannelNext:@"形象片"];
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
