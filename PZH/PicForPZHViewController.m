//
//  PicForPZHViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "PicForPZHViewController.h"
#import "DetailWebViewController.h"
#import "GMDCircleLoader.h"
@interface PicForPZHViewController (){
    AppDelegate * appDelegate;
}

@end

@implementation PicForPZHViewController
@synthesize titleLabel,webView,seg,segArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GetYXPZH_ContentResult:) name:@"GetYXPZH_ContentResult" object:nil];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.segArray = [NSMutableArray arrayWithObjects:@"城市新貌",@"自然风光",@"美食天地",@"开发建设",@"旅游产品",@"节庆赛事",@"新福家园",@"阳光攀枝花", nil];
        [self createSegmentedControl];
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,NAVIGATIONHIGHT+HYSegmentedControl_Height, self.view.frame.size.width, self.view.frame.size.height-(NAVIGATIONHIGHT+HYSegmentedControl_Height))];
        self.webView.delegate=self;
        self.webView.scalesPageToFit =YES;
        self.webView.scrollView.bounces = NO;
        self.webView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:self.webView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.titleLabel.text = @"图看攀枝花";
    appDelegate.title = @"图看攀枝花";
}

- (void)createSegmentedControl
{
    self.seg = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:self.segArray delegate:self] ;
    self.seg.frame = CGRectMake(0, NAVIGATIONHIGHT, self.view.frame.size.width, HYSegmentedControl_Height);
    [self.view addSubview:self.seg];
}

-(void)GetYXPZH_ContentResult:(NSNotification *)note{
    NSString *htmlString = [[note userInfo] objectForKey:@"1"];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:htmlString]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [GMDCircleLoader hideFromView:self.view animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    [GMDCircleLoader setOnView:self.view withTitle:@"解析中..." animated:YES];
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"错误" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
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
