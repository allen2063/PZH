//
//  DetailWebViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/6.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "DetailWebViewController.h"
#import "GMDCircleLoader.h"
@interface DetailWebViewController (){
    BOOL isOutsideLink;
}

@end

@implementation DetailWebViewController
@synthesize webView,seg,segArray,appDelegate,titleLabel;
#define OVERHEADINFORMATIONCELLLABELHEIGHT 15
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
        isOutsideLink = NO;
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
        //自适应大小
        self.webView.scalesPageToFit =YES;
        self.webView.scrollView.bounces = NO;
        [self.view addSubview:self.webView];
        
        self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MenuContentResults:) name:@"GetWebResult" object:nil];//走进攀枝花
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fault) name:@"fault" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PassageContentResult:) name:@"PassageContentResult" object:nil];//带标签的文章
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PassageContentResult:) name:@"LoadTopNewsContentResult" object:nil];//头条新闻
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PassageContentResult:) name:@"GetMXQY_ContentResult" object:nil];//常见问题、相关政策
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PassageContentResult:) name:@"GetRDBS_URLResult" object:nil];//热点办事
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PassageContentResult:) name:@"GetBSGG_ListResult" object:nil];//热点办事
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PassageContentResult:) name:@"OnLineSelectResult" object:nil];//在线办事查询详情GetBuMenDSY_ContentResult
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(PassageContentResult:) name:@"GetBuMenDSY_ContentResult" object:nil];//部门动态新接口
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
    if (![appDelegate.parentTitle isEqualToString:@"走进攀枝花"]) {
        [self addLabelForType:2];
    }
//    NSString * htmlString =@"http://www.panzhihua.gov.cn/images/wsbs/bgxz/2012/1/18/bd6ec976-c5bc-4983-b2c3-c20894f29fa1.doc";
//    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:htmlString]];
    //self.title = [self.segArray objectAtIndex:0];
    //[GMDCircleLoader setOnView:self.view withTitle:@"加载中..." animated:YES];
    
}

- (void)fault{
    [GMDCircleLoader hideFromView:self.view animated:YES];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"访问出错" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    
}

- (void)MenuContentResults:(NSNotification *)note{
    NSString *info = [[note userInfo] objectForKey:@"info"];
    [self.webView loadHTMLString:info baseURL:[NSURL URLWithString:info]];
}

- (void)PassageContentResult:(NSNotification *)note{
    NSString *info = [[note userInfo] objectForKey:@"info"];
    NSMutableArray * arr = (NSMutableArray *)[info componentsSeparatedByString:@";."];
    NSString *htmlString;
    if (arr.count ==3) {
        UILabel * aLabel = (UILabel *)[self.overheadInformationSumImgView viewWithTag:7];           //  tag7是发布时间
        aLabel.text = [arr objectAtIndex:0];
        aLabel = (UILabel *)[self.overheadInformationSumImgView viewWithTag:8];                     //  tag8是来源
        aLabel.text = [arr objectAtIndex:1];
        htmlString = [arr objectAtIndex:2];
        
//        if ([appDelegate.sonTitle isEqualToString:@"表格下载"]) {                                   //表格下载时展示下载链接
//            NSMutableArray * arr = (NSMutableArray *)[htmlString componentsSeparatedByString:@"href=\""];
//            arr = (NSMutableArray *)[[arr objectAtIndex:1] componentsSeparatedByString:@"\">"];
//            htmlString = [arr objectAtIndex:0];
//        }
        
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:htmlString]];
    }else if(arr.count == 7){
        [self addLabelForType:6];
        UILabel * aLabel = (UILabel *)[self.overheadInformationSumImgView viewWithTag:1];           //  tag7是发布时间
        aLabel.text = [arr objectAtIndex:0];
        aLabel = (UILabel *)[self.overheadInformationSumImgView viewWithTag:2];                     //  tag8是来源
        aLabel.text = [arr objectAtIndex:1];
        aLabel = (UILabel *)[self.overheadInformationSumImgView viewWithTag:3];                     //  tag8是来源
        aLabel.text = [arr objectAtIndex:2];
        aLabel = (UILabel *)[self.overheadInformationSumImgView viewWithTag:4];                     //  tag8是来源
        aLabel.text = [arr objectAtIndex:3];
        aLabel = (UILabel *)[self.overheadInformationSumImgView viewWithTag:5];                     //  tag8是来源
        aLabel.text = [arr objectAtIndex:4];
        aLabel = (UILabel *)[self.overheadInformationSumImgView viewWithTag:6];                     //  tag8是来源
        aLabel.text = [arr objectAtIndex:5];
        htmlString = [arr objectAtIndex:6];
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:htmlString]];
    }
    else if(arr.count == 1){   //  办事公告
        htmlString = [arr objectAtIndex:0];
        if ([[htmlString substringToIndex:4]isEqualToString:@"http"]) {                             //  政府会议是外链   现对外链判断  如果是外链重新加载
            isOutsideLink = YES;
            NSURL *url = [[NSURL alloc] initWithString:htmlString];
            [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
            self.webView.scalesPageToFit =YES;
            [self.overheadInformationSumImgView removeFromSuperview];
            self.webView.frame = CGRectMake(0,NAVIGATIONHIGHT+HYSegmentedControl_Height, self.view.frame.size.width, self.view.frame.size.height-(NAVIGATIONHIGHT+HYSegmentedControl_Height));
        }
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:htmlString]];
        self.webView.scalesPageToFit =YES;
        [self.overheadInformationSumImgView removeFromSuperview];
        self.webView.frame = CGRectMake(0,NAVIGATIONHIGHT+HYSegmentedControl_Height, self.view.frame.size.width, self.view.frame.size.height-(NAVIGATIONHIGHT+HYSegmentedControl_Height));
    }
    
    
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
    if (!isOutsideLink) {
        [alterview show];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addLabelForType:(int)type{
    //政务公开等详情图上的标签
    self.overheadInformationSumImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]];
    [self.overheadInformationSumImgView removeFromSuperview];
    [self.view addSubview:self.overheadInformationSumImgView];
    if(type == 6){
        self.overheadInformationSumImgView.frame = CGRectMake(0,NAVIGATIONHIGHT + HYSegmentedControl_Height, UISCREENWIDTH, OVERHEADINFORMATIONCELLLABELHEIGHT*5);
        
        UILabel *  overheadInformationCellNameLabel1= [[UILabel alloc]initWithFrame:CGRectMake(10,OVERHEADINFORMATIONCELLLABELHEIGHT/2, 45, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellNameLabel1.text = @"索引号:";
        overheadInformationCellNameLabel1.font = [UIFont systemFontOfSize:12];
        overheadInformationCellNameLabel1.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellNameLabel1];
        
        UILabel *  overheadInformationCellNameLabel2= [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2 + 10, OVERHEADINFORMATIONCELLLABELHEIGHT/2 , 60, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellNameLabel2.text = @"发布日期:";
        overheadInformationCellNameLabel2.font = [UIFont systemFontOfSize:12];
        overheadInformationCellNameLabel2.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellNameLabel2];
        
        UILabel *  overheadInformationCellNameLabel3= [[UILabel alloc]initWithFrame:CGRectMake(10,OVERHEADINFORMATIONCELLLABELHEIGHT*1.5, 60, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellNameLabel3.text = @"主题分类:";
        overheadInformationCellNameLabel3.font = [UIFont systemFontOfSize:12];
        overheadInformationCellNameLabel3.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellNameLabel3];
        
        UILabel *  overheadInformationCellNameLabel4= [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2+10, 1.5*OVERHEADINFORMATIONCELLLABELHEIGHT , 30, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellNameLabel4.text = @"文号:";
        overheadInformationCellNameLabel4.font = [UIFont systemFontOfSize:12];
        overheadInformationCellNameLabel4.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellNameLabel4];
        
        UILabel *  overheadInformationCellNameLabel5= [[UILabel alloc]initWithFrame:CGRectMake(10,OVERHEADINFORMATIONCELLLABELHEIGHT*2.5, 60, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellNameLabel5.text = @"发布机构:";
        overheadInformationCellNameLabel5.font = [UIFont systemFontOfSize:12];
        overheadInformationCellNameLabel5.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellNameLabel5];
        
        UILabel *  overheadInformationCellNameLabel6= [[UILabel alloc]initWithFrame:CGRectMake(10,OVERHEADINFORMATIONCELLLABELHEIGHT*3.5, 45, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellNameLabel6.text = @"关键词:";
        overheadInformationCellNameLabel6.font = [UIFont systemFontOfSize:12];
        overheadInformationCellNameLabel6.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellNameLabel6];
        
        UILabel *  overheadInformationCellValueLabel1= [[UILabel alloc]initWithFrame:CGRectMake(55,OVERHEADINFORMATIONCELLLABELHEIGHT/2,UISCREENWIDTH/2 - 60, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellValueLabel1.tag = 1;
        overheadInformationCellValueLabel1.font = [UIFont systemFontOfSize:12];
        overheadInformationCellValueLabel1.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellValueLabel1];
        
        UILabel *  overheadInformationCellValueLabel2= [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2+70, OVERHEADINFORMATIONCELLLABELHEIGHT/2 ,UISCREENWIDTH/2 - 75, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellValueLabel2.tag = 2;
        overheadInformationCellValueLabel2.font = [UIFont systemFontOfSize:12];
        overheadInformationCellValueLabel2.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellValueLabel2];
        
        UILabel *  overheadInformationCellValueLabel3= [[UILabel alloc]initWithFrame:CGRectMake(70,OVERHEADINFORMATIONCELLLABELHEIGHT*1.5,UISCREENWIDTH/2 - 75, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellValueLabel3.tag = 3;
        overheadInformationCellValueLabel3.font = [UIFont systemFontOfSize:12];
        overheadInformationCellValueLabel3.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellValueLabel3];
        
        UILabel *  overheadInformationCellValueLabel4= [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2+40, 1.5*OVERHEADINFORMATIONCELLLABELHEIGHT ,UISCREENWIDTH/2 - 45, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellValueLabel4.tag = 4;
        overheadInformationCellValueLabel4.font = [UIFont systemFontOfSize:12];
        overheadInformationCellValueLabel4.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellValueLabel4];
        
        UILabel *  overheadInformationCellValueLabel5= [[UILabel alloc]initWithFrame:CGRectMake(70,OVERHEADINFORMATIONCELLLABELHEIGHT*2.5,UISCREENWIDTH/2 - 75, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellValueLabel5.tag = 5;
        overheadInformationCellValueLabel5.font = [UIFont systemFontOfSize:12];
        overheadInformationCellValueLabel5.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellValueLabel5];
        
        UILabel *  overheadInformationCellValueLabel6= [[UILabel alloc]initWithFrame:CGRectMake(55,OVERHEADINFORMATIONCELLLABELHEIGHT*3.5,UISCREENWIDTH/2 - 60, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellValueLabel6.tag = 6;
        overheadInformationCellValueLabel6.font = [UIFont systemFontOfSize:12];
        overheadInformationCellValueLabel6.textAlignment = NSTextAlignmentLeft;
        [self.overheadInformationSumImgView addSubview:overheadInformationCellValueLabel6];
    }
    else if (type == 2){
        self.overheadInformationSumImgView.frame = CGRectMake(0,NAVIGATIONHIGHT + HYSegmentedControl_Height, UISCREENWIDTH, OVERHEADINFORMATIONCELLLABELHEIGHT*2);
        UILabel *  overheadInformationCellNameLabel1= [[UILabel alloc]initWithFrame:CGRectMake(10,OVERHEADINFORMATIONCELLLABELHEIGHT/2, 60, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellNameLabel1.text = @"发布日期:";
        overheadInformationCellNameLabel1.font = [UIFont systemFontOfSize:12];
        overheadInformationCellNameLabel1.textAlignment = NSTextAlignmentLeft;
        overheadInformationCellNameLabel1.backgroundColor = [UIColor clearColor];
        [self.overheadInformationSumImgView addSubview:overheadInformationCellNameLabel1];
        
        UILabel *  overheadInformationCellNameLabel2= [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2 + 10, OVERHEADINFORMATIONCELLLABELHEIGHT/2 , 30, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellNameLabel2.text = @"来源:";
        overheadInformationCellNameLabel2.font = [UIFont systemFontOfSize:12];
        overheadInformationCellNameLabel2.textAlignment = NSTextAlignmentLeft;
        overheadInformationCellNameLabel2.backgroundColor = [UIColor clearColor];
        [self.overheadInformationSumImgView addSubview:overheadInformationCellNameLabel2];
        
        UILabel *  overheadInformationCellValueLabel1= [[UILabel alloc]initWithFrame:CGRectMake(70,OVERHEADINFORMATIONCELLLABELHEIGHT/2,UISCREENWIDTH/2 - 75, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellValueLabel1.tag = 7;
        overheadInformationCellValueLabel1.font = [UIFont systemFontOfSize:12];
        overheadInformationCellValueLabel1.textAlignment = NSTextAlignmentLeft;
        overheadInformationCellValueLabel1.backgroundColor = [UIColor clearColor];
        [self.overheadInformationSumImgView addSubview:overheadInformationCellValueLabel1];
        
        UILabel *  overheadInformationCellValueLabel2= [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/2+40, OVERHEADINFORMATIONCELLLABELHEIGHT/2 ,UISCREENWIDTH/2 - 45, OVERHEADINFORMATIONCELLLABELHEIGHT)];
        overheadInformationCellValueLabel2.tag = 8;
        overheadInformationCellValueLabel2.font = [UIFont systemFontOfSize:12];
        overheadInformationCellValueLabel2.textAlignment = NSTextAlignmentLeft;
        overheadInformationCellValueLabel2.backgroundColor = [UIColor clearColor];
        [self.overheadInformationSumImgView addSubview:overheadInformationCellValueLabel2];
    }
    self.webView.frame = CGRectMake(0,NAVIGATIONHIGHT+HYSegmentedControl_Height+self.overheadInformationSumImgView.frame.size.height, UISCREENWIDTH, UISCREENHEIGHT-(NAVIGATIONHIGHT+HYSegmentedControl_Height+self.overheadInformationSumImgView.frame.size.height));

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
