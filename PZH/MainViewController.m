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
        //self.webView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:self.webView];
        self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.intoPZH = [[IntoPZHViewController alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MenuContentResult:) name:@"GetMenuContentResult" object:nil];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.testBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.testBtn.frame = CGRectMake(0,0,70,40);
    [self.testBtn setTitle:@"test now!" forState:UIControlStateNormal];
    [self.testBtn addTarget:self action:@selector(testNetWork:) forControlEvents:UIControlEventTouchUpInside];
    self.testBtn.tag = 1;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.testBtn];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.intoPZHBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.intoPZHBtn.frame = CGRectMake(0,0,75,40);
    [self.intoPZHBtn setTitle:@"走进攀枝花" forState:UIControlStateNormal];
    [self.intoPZHBtn addTarget:self action:@selector(testNetWork:) forControlEvents:UIControlEventTouchUpInside];
    self.intoPZHBtn.tag = 2;
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.intoPZHBtn];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    NSLog(@"web:%f view:%f",self.webView.frame.size.height,self.view.frame.size.height);
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
