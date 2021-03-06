//
//  DetailWebViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/6.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "DetailWebViewController.h"
#import "GMDCircleLoader.h"
@interface DetailWebViewController ()

@end

@implementation DetailWebViewController
@synthesize webView,seg,segArray,appDelegate,titleLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithURL:(NSURL *)url andSegArray:(NSMutableArray *)segArrays
{
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
        
        self.segArray = segArrays;//[[NSMutableArray alloc]initWithArray:segArrays];
        //[self.segArray addObjectsFromArray:[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil]];
//        self.seg = [[UISegmentedControl alloc]initWithItems:self.segArray];
//        self.seg.frame = CGRectZero;
//        self.seg.translatesAutoresizingMaskIntoConstraints = NO;
//        self.seg.selectedSegmentIndex = 0;//设置默认选择项索引
//        self.seg.segmentedControlStyle=UISegmentedControlStyleBar;
//        [self.view addSubview:self.seg];
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        [self createSegmentedControl];
        
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,NAVIGATIONHIGHT+HYSegmentedControl_Height, self.view.frame.size.width, self.view.frame.size.height-(NAVIGATIONHIGHT+HYSegmentedControl_Height))];
        self.webView.delegate=self;
        //self.webView.scalesPageToFit =YES;
        self.webView.scrollView.bounces = NO;
        [self.view addSubview:self.webView];
        
        self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MenuContentResults:) name:@"GetMenuContentResult" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fault) name:@"fault" object:nil];

        }
    return self;
}

- (void)createSegmentedControl
{
    self.seg = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:self.segArray delegate:self] ;
    self.seg.frame = CGRectMake(0, NAVIGATIONHIGHT, self.view.frame.size.width, HYSegmentedControl_Height);
    [self.view addSubview:self.seg];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.titleLabel.text = appDelegate.title;
    //self.title = [self.segArray objectAtIndex:0];
    //[GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];

//    NSLayoutConstraint *constraintTopForSeg = [
//                                      NSLayoutConstraint
//                                      constraintWithItem:self.seg
//                                      attribute:NSLayoutAttributeTop
//                                      relatedBy:NSLayoutRelationEqual
//                                      toItem:self.view
//                                      attribute:NSLayoutAttributeTop
//                                      multiplier:1.0f
//                                      constant:64
//                                      ];
//    
//    NSLayoutConstraint *constraintWidthForSeg = [
//                                            NSLayoutConstraint
//                                            constraintWithItem:self.seg
//                                            attribute:NSLayoutAttributeWidth
//                                            relatedBy:NSLayoutRelationEqual
//                                            toItem:self.view
//                                            attribute:NSLayoutAttributeWidth
//                                            multiplier:1.0f
//                                            constant:00.0f
//                                            ];
//    
//    NSLayoutConstraint *constraintHighForSeg = [
//                                          NSLayoutConstraint
//                                          constraintWithItem:self.seg
//                                          attribute:NSLayoutAttributeHeight
//                                          relatedBy:NSLayoutRelationEqual
//                                          toItem:self.view
//                                          attribute:NSLayoutAttributeHeight
//                                          multiplier:0.06
//                                          constant:00.0f
//                                          ];
//    
//    NSLayoutConstraint *constraintXForSeg = [
//                                                NSLayoutConstraint
//                                                constraintWithItem:self.seg
//                                                attribute:NSLayoutAttributeCenterX
//                                                relatedBy:NSLayoutRelationEqual
//                                                toItem:self.view
//                                                attribute:NSLayoutAttributeCenterX
//                                                multiplier:1
//                                                constant:00.0f
//                                                ];
//    [self.view addConstraint:constraintTopForSeg];
//    [self.view addConstraint:constraintWidthForSeg];
//    [self.view addConstraint:constraintHighForSeg];
//    [self.view addConstraint:constraintXForSeg];
    
//    NSLayoutConstraint *constraintBottomForWeb = [
//                                               NSLayoutConstraint
//                                               constraintWithItem:self.webView
//                                               attribute:NSLayoutAttributeBottom
//                                               relatedBy:NSLayoutRelationEqual
//                                               toItem:self.view
//                                               attribute:NSLayoutAttributeBottom
//                                               multiplier:1.0f
//                                               constant:0
//                                               ];
//    
//    NSLayoutConstraint *constraintTopForWeb = [
//                                                  NSLayoutConstraint
//                                                  constraintWithItem:self.webView
//                                                  attribute:NSLayoutAttributeTop
//                                                  relatedBy:NSLayoutRelationEqual
//                                                  toItem:self.view
//                                                  attribute:NSLayoutAttributeBottom
//                                                  multiplier:1.0f
//                                                  constant:120
//                                                  ];
//    
//    NSLayoutConstraint *constraintWidthForWeb = [
//                                                 NSLayoutConstraint
//                                                 constraintWithItem:self.webView
//                                                 attribute:NSLayoutAttributeWidth
//                                                 relatedBy:NSLayoutRelationEqual
//                                                 toItem:self.view
//                                                 attribute:NSLayoutAttributeWidth
//                                                 multiplier:1.0f
//                                                 constant:00.0f
//                                                 ];
//    
//    [self.view addConstraint:constraintTopForWeb];
//    [self.view addConstraint:constraintWidthForWeb];
//    [self.view addConstraint:constraintBottomForWeb];
    
    //NSLog(@"%@,%@,%@",NSStringFromCGSize(self.seg.intrinsicContentSize),self.seg.hasAmbiguousLayout?@"YES":@"NO",NSStringFromCGSize(self.webView.intrinsicContentSize));
}

- (void)fault{
    [GMDCircleLoader hideFromView:self.view animated:YES];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"访问出错" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    
}

- (void)MenuContentResults:(NSNotification *)note{
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
