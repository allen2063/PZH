//
//  MainViewController.m
//  PZH
//
//  Created by ZengYifei on 15/6/30.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize testBtn,intoPZHBtn;
@synthesize appDelegate,webView,intoPZH;

#define UISCREENHEIGHT  self.view.bounds.size.height
#define UISCREENWIDTH  self.view.bounds.size.width
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)?YES:NO

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor yellowColor];
        CGRect bounds = [[UIScreen mainScreen] bounds];
        self.view.frame = bounds;
        self.title = @"攀枝花公众信息网";
        
        //self.view.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
        self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.webView.delegate=self;
        self.webView.scalesPageToFit =YES;
        self.webView.scrollView.bounces = NO;
        //self.webView.backgroundColor = [UIColor yellowColor];
        //[self.view addSubview:self.webView];
        self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.intoPZH = [[IntoPZHViewController alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MenuContentResult:) name:@"GetMenuContentResult" object:nil];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createScrollView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.testBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.testBtn.frame = CGRectMake(0,0,70,40);
    [self.testBtn setTitle:@"test now!" forState:UIControlStateNormal];
    [self.testBtn addTarget:self action:@selector(testNetWork:) forControlEvents:UIControlEventTouchUpInside];
    self.testBtn.tag = 1;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.testBtn];
    //self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.intoPZHBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.intoPZHBtn.frame = CGRectMake(0,0,75,40);
    [self.intoPZHBtn setTitle:@"走进攀枝花" forState:UIControlStateNormal];
    [self.intoPZHBtn addTarget:self action:@selector(testNetWork:) forControlEvents:UIControlEventTouchUpInside];
    self.intoPZHBtn.tag = 2;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.intoPZHBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    NSLog(@"web:%f view:%f",self.webView.frame.size.height,self.view.frame.size.height);
}

#pragma mark - 构建广告滚动视图
- (void)createScrollView
{
    AdScrollView * scrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, 360)];
    AdDataModel * dataModel = [AdDataModel adDataModelWithImageNameAndAdTitleArray];
    //如果滚动视图的父视图由导航控制器控制,必须要设置该属性(ps,猜测这是为了正常显示,导航控制器内部设置了UIEdgeInsetsMake(64, 0, 0, 0))
    scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    NSLog(@"%@",dataModel.adTitleArray);
    scrollView.imageNameArray = dataModel.imageNameArray;
    scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [scrollView setAdTitleArray:dataModel.adTitleArray withShowStyle:AdTitleShowStyleLeft];
    
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:scrollView];
}

-(void)MenuContentResult:(NSNotification *)note{
    NSString *htmlString = [[note userInfo] objectForKey:@"1"];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:htmlString]];
}

-(void)testNetWork:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
            [self.appDelegate.conAPI test];
            break;
        case 2:
            [self.navigationController pushViewController:self.intoPZH animated:YES];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
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
