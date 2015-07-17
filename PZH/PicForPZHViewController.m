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
        self.webView.delegate = self;
        self.webView.scrollView.delegate = self;
        self.webView.scalesPageToFit = YES;
        self.webView.backgroundColor = [UIColor yellowColor];
        self.webView.scrollView.bounces = YES;
        self.webView.scrollView.pagingEnabled = YES;
        self.webView.scrollView.frame = self.webView.bounds;
        
        //初始化refreshView，添加到webview 的 scrollView子视图中
        if (_refreshHeaderView == nil) {
            _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0-self.webView.scrollView.bounds.size.height, self.webView.scrollView.frame.size.width, self.webView.scrollView.bounds.size.height)];
            _refreshHeaderView.delegate = self;
            [self.webView.scrollView addSubview:_refreshHeaderView];
        }
        [_refreshHeaderView refreshLastUpdatedDate];
        
        //初始化refreshView，添加到webview 的 scrollView子视图中
        if (_refreshBottomView == nil) {
            _refreshBottomView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0,self.webView.scrollView.bounds.size.height, self.webView.scrollView.frame.size.width, self.webView.scrollView.bounds.size.height)];
            _refreshBottomView.delegate = self;
            [self.webView.scrollView addSubview:_refreshBottomView];
        }
        [_refreshBottomView refreshLastUpdatedDate];
        
        
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

#pragma mark - webview delegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    [GMDCircleLoader setOnView:self.view withTitle:@"解析中..." animated:YES];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.webView.scrollView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"错误" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
    
    NSLog(@"load page error:%@", [error description]);
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.webView.scrollView];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    //[self loadPage];
    [appDelegate.conAPI getPicForPZHAPIWithChannelName:@"图看攀枝花" andHannelNext:@"城市新貌" andPageSize:@"5" andCurPage:@"1"];
    _reloading = YES;

}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
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
