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
@synthesize webView,seg,segArray,appDelegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithURL:(NSURL *)url andSegArray:(NSMutableArray *)segArrays
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        self.segArray = [[NSMutableArray alloc]initWithArray:segArrays];
        //[self.segArray addObjectsFromArray:[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil]];
        self.seg = [[UISegmentedControl alloc]initWithItems:self.segArray];
        self.seg.frame = CGRectZero;
        self.seg.translatesAutoresizingMaskIntoConstraints = NO;
        self.seg.selectedSegmentIndex = 0;//设置默认选择项索引
        self.seg.segmentedControlStyle=UISegmentedControlStyleBar;
        [self.view addSubview:self.seg];
        
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,95, self.view.frame.size.width, self.view.frame.size.height-95)];
        //self.webView.translatesAutoresizingMaskIntoConstraints = NO;
        self.webView.delegate=self;
        self.webView.scalesPageToFit =YES;
        self.webView.scrollView.bounces = NO;
        [self.view addSubview:self.webView];
        
        self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MenuContentResults:) name:@"GetMenuContentResult" object:nil];
        
        }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.title = [self.segArray objectAtIndex:0];
    [GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];

    NSLayoutConstraint *constraintTopForSeg = [
                                      NSLayoutConstraint
                                      constraintWithItem:self.seg
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.view
                                      attribute:NSLayoutAttributeTop
                                      multiplier:1.0f
                                      constant:64
                                      ];
    
    NSLayoutConstraint *constraintWidthForSeg = [
                                            NSLayoutConstraint
                                            constraintWithItem:self.seg
                                            attribute:NSLayoutAttributeWidth
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.view
                                            attribute:NSLayoutAttributeWidth
                                            multiplier:1.0f
                                            constant:00.0f
                                            ];
    
    NSLayoutConstraint *constraintHighForSeg = [
                                          NSLayoutConstraint
                                          constraintWithItem:self.seg
                                          attribute:NSLayoutAttributeHeight
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.view
                                          attribute:NSLayoutAttributeHeight
                                          multiplier:0.06
                                          constant:00.0f
                                          ];
    
    NSLayoutConstraint *constraintXForSeg = [
                                                NSLayoutConstraint
                                                constraintWithItem:self.seg
                                                attribute:NSLayoutAttributeCenterX
                                                relatedBy:NSLayoutRelationEqual
                                                toItem:self.view
                                                attribute:NSLayoutAttributeCenterX
                                                multiplier:1
                                                constant:00.0f
                                                ];
    [self.view addConstraint:constraintTopForSeg];
    [self.view addConstraint:constraintWidthForSeg];
    [self.view addConstraint:constraintHighForSeg];
    [self.view addConstraint:constraintXForSeg];
    
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
    
    NSLog(@"%@,%@,%@",NSStringFromCGSize(self.seg.intrinsicContentSize),self.seg.hasAmbiguousLayout?@"YES":@"NO",NSStringFromCGSize(self.webView.intrinsicContentSize));
    
    [self.appDelegate.conAPI test];

    
}

-(void)MenuContentResults:(NSNotification *)note{
    NSString *htmlString = [[note userInfo] objectForKey:@"1"];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:htmlString]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [GMDCircleLoader hideFromView:self.view animated:YES];
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
