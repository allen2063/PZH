//
//  VideoForPZHViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "VideoForPZHViewController.h"
#import "AppDelegate.h"
#import "GMDCircleLoader.h"
@interface VideoForPZHViewController (){
    AppDelegate * appDelegate;
}

@end

@implementation VideoForPZHViewController
@synthesize videoArray,seg,titleLabel,urlString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.touchedSegBtn = 1000;    //设置默认播放链接
        //self.urlString = @"http://www.panzhihua.gov.cn/images/zjpzh/yxpzh/sppzh/xxp/2323.wmv";
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.videoArray = [[NSMutableArray alloc]initWithObjects:@"形象片",@"规划片",@"岩箭之迷",@"阴传的秘密", nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetSPPZH_ContentResult:) name:@"GetSPPZH_ContentResult" object:nil];

        [self createSegmentedControl];
        UIButton * vedioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        vedioBtn.backgroundColor = [UIColor lightGrayColor];
        vedioBtn.frame = CGRectMake(UISCREENWIDTH*0.025,NAVIGATIONHIGHT+HYSegmentedControl_Height+UISCREENHEIGHT/18,UISCREENWIDTH*0.95,UISCREENWIDTH*0.85/1.72);
        [vedioBtn addTarget:self action:@selector(jumpPageForVideoPZH:) forControlEvents:UIControlEventTouchUpInside];
        [vedioBtn setBackgroundImage:[UIImage imageNamed:@"bf_bj1.png"] forState:UIControlStateNormal];
        [vedioBtn setBackgroundImage:[UIImage imageNamed:@"bf_bj2.png"] forState:UIControlStateHighlighted];
        [self.view addSubview:vedioBtn];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.titleLabel.text = @"视频攀枝花";
    appDelegate.title = @"视频攀枝花";
    //[GMDCircleLoader hideFromView:self.view animated:YES];
}

- (void)createSegmentedControl
{
    self.seg = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:self.videoArray delegate:self] ;
    self.seg.frame = CGRectMake(0, NAVIGATIONHIGHT, self.view.frame.size.width, HYSegmentedControl_Height);
    [self.view addSubview:self.seg];
}

-(void)jumpPageForVideoPZH:(UIButton *)btn{
    [appDelegate playStreamFromURL:[NSURL URLWithString:self.urlString]];
}

-(void)GetSPPZH_ContentResult:(NSNotification *)note{
    self.urlString = [[note userInfo] objectForKey:@"1"];
    [GMDCircleLoader hideFromView:self.view animated:YES];
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
