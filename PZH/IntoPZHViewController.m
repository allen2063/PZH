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
#import "SXZWMainViewController.h"
@interface IntoPZHViewController (){
    AppDelegate * appDelegate;
}

@end

@implementation IntoPZHViewController
@synthesize videoForPZHBtn,picForPZHBtn,cityOverview,economyOverview,naturalOverview,titleLabel;

#define INTERVALX UISCREENWIDTH/18
#define INTERVALY UISCREENHEIGHT/15
#define MAINBTNWIDTH UISCREENWIDTH*2/5
#define MAINBTNHEIGHT UISCREENWIDTH/5


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
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = item;

        //市情概况
        self.cityOverview = [[NSMutableArray alloc]initWithObjects:@"市情概况", nil];
        UIButton * cityBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cityBtn.backgroundColor = [UIColor lightGrayColor];
        cityBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY,MAINBTNWIDTH,MAINBTNHEIGHT);
        [cityBtn setTitle:@"市情概况" forState:UIControlStateNormal];
        [cityBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        cityBtn.tag = 3;
        [self.view addSubview:cityBtn];
        
        //自然概况
        self.naturalOverview = [[NSMutableArray alloc]initWithObjects:@"地理位置",@"行政区划",@"自然资源",@"自然概貌",@"建制人口",@"历史沿革", nil];
        UIButton * naturalBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        naturalBtn.backgroundColor = [UIColor lightGrayColor];
        naturalBtn.frame = CGRectMake(40,200,120,60);
        [naturalBtn setTitle:@"自然概况" forState:UIControlStateNormal];
        [naturalBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        naturalBtn.tag = 4;
        [self.view addSubview:naturalBtn];
        
        //国民经济
        self.economyOverview = [[NSMutableArray alloc]initWithObjects:@"经济综述",@"农业",@"收入与消费",@"房地产业",@"工业",@"金融保险业",@"运输邮电",@"建筑业",@"固定资产投资",@"财政税收", nil];
        UIButton * economyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        economyBtn.backgroundColor = [UIColor lightGrayColor];
        economyBtn.frame = CGRectMake(40,300,120,60);
        [economyBtn setTitle:@"国民经济" forState:UIControlStateNormal];
        [economyBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        economyBtn.tag = 5;
        [self.view addSubview:economyBtn];
        
        //图看攀枝花
        self.picForPZHBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.picForPZHBtn.backgroundColor = [UIColor lightGrayColor];
        self.picForPZHBtn.frame = CGRectMake(40,400,120,60);
        [self.picForPZHBtn setTitle:@"图看攀枝花" forState:UIControlStateNormal];
        [self.picForPZHBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        self.picForPZHBtn.tag = 1;
        
        //视频攀枝花
        self.videoForPZHBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.videoForPZHBtn.backgroundColor = [UIColor lightGrayColor];
        self.videoForPZHBtn.frame = CGRectMake(180,400,120,60);
        [self.videoForPZHBtn setTitle:@"视频攀枝花" forState:UIControlStateNormal];
        [self.videoForPZHBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        self.videoForPZHBtn.tag = 2;
        
        [self.view addSubview:self.picForPZHBtn];
        [self.view addSubview:self.videoForPZHBtn];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //appDelegate.title = @"走进攀枝花";
    self.titleLabel.text = appDelegate.title;
}

-(void)jumpPage:(UIButton *)btn{
    PicForPZHViewController * picForPZH = [[PicForPZHViewController alloc]init];
    VideoForPZHViewController * videoForPZH = [[VideoForPZHViewController alloc]init];
    //AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    DetailWebViewController * detailViewController = [DetailWebViewController alloc];
    SXZWMainViewController * mainVc = [[SXZWMainViewController alloc] init];
    switch (btn.tag) {
        case 1:
            [self.navigationController pushViewController:picForPZH animated:YES];
            //[appDelegate playStreamFromURL:[NSURL URLWithString:@"http://www.panzhihua.gov.cn/images/zjpzh/yxpzh/sppzh/xxp/2323.wmv"]];
            break;
        case 2:
            [self.navigationController pushViewController:videoForPZH animated:YES];
            //[appDelegate playStreamFromURL:[NSURL URLWithString:@"http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4"]];
            break;
        case 3:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.cityOverview];
            [self.navigationController pushViewController:detailViewController animated:YES];
            break;
        case 4:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.naturalOverview];
            [self.navigationController pushViewController:detailViewController animated:YES];
            break;
        case 5:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyOverview];
            [self.navigationController pushViewController:detailViewController animated:YES];
//            [self.navigationController pushViewController:mainVc animated:YES];
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
