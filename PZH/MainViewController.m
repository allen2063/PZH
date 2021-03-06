//
//  MainViewController.m
//  PZH
//
//  Created by ZengYifei on 15/6/30.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (){
    AppDelegate * appDelegate;
}

@end

@implementation MainViewController
@synthesize intoPZHBtn,titleLabel,intoPZHViewController,scrollView;


#define SCROllVIEWHIGHT ((self.view.bounds.size.height == 480)?  UISCREENHEIGHT*0.44:UISCREENHEIGHT*0.47) //4&4s是480
#define MAINNEWSHIGHT (UISCREENHEIGHT*0.16)
#define MAINBTNHIGHT (UISCREENHEIGHT*0.12)
#define MAINBTNWIDTH (UISCREENWIDTH/2-7.5)
#define INTERVALX (UISCREENWIDTH/64)
#define INTERVALY (UISCREENHEIGHT/160)
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = UIColorFromRGBValue(0xececec);
        CGRect bounds = [[UIScreen mainScreen] bounds];
        self.view.frame = bounds;
        self.intoPZHViewController = [[IntoPZHViewController alloc]init];
        //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MenuContentResult:) name:@"GetMenuContentResult" object:nil];
        
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //appDelegate.title = @"攀枝花公众信息网";
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        
        //首页展示新闻
        self.mainNewsBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.mainNewsBtn.frame = CGRectMake(0,NAVIGATIONHIGHT+SCROllVIEWHIGHT,UISCREENWIDTH,MAINNEWSHIGHT);
        [self.mainNewsBtn addTarget:self action:@selector(jumpPageForMainView:) forControlEvents:UIControlEventTouchUpInside];
        self.mainNewsBtn.tag = 5;
        [self.mainNewsBtn setBackgroundImage:[UIImage imageNamed:@"xw_bj.png"] forState:UIControlStateNormal];
        [self.mainNewsBtn setBackgroundImage:[UIImage imageNamed:@"dj_bj.png"] forState:UIControlStateSelected];
        
        //UIImageView * mainNewsBackgroundImgVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xw_bj.png"]];
        //mainNewsBackgroundImgVIew.frame = self.mainNewsBtn.bounds;
        
        UIImageView * mainNewsImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ph.png"]];
        mainNewsImgView.frame = CGRectMake(INTERVALX*1, INTERVALY*2, UISCREENWIDTH/3-2*INTERVALX, MAINNEWSHIGHT-INTERVALY*4);
        
        UILabel * newsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainNewsImgView.frame.size.width+INTERVALX*2, INTERVALY*2, UISCREENWIDTH*2/3-INTERVALX, INTERVALY*6)];
        newsTitleLabel.text = @"习近平：坚定不移打赢禁毒战!!";
        newsTitleLabel.font = [UIFont systemFontOfSize:15];
        newsTitleLabel.textAlignment = NSTextAlignmentLeft;
        //titleLabel.backgroundColor = [UIColor yellowColor];
        
        UILabel * bodyLabel = [[UILabel alloc]initWithFrame:CGRectMake(mainNewsImgView.frame.size.width+INTERVALX*2, INTERVALY*10, UISCREENWIDTH*2/3-INTERVALX, MAINNEWSHIGHT-INTERVALY*12)];
        bodyLabel.text = @"习近平：坚定不移打赢禁毒战!习近平：坚定不移打赢禁毒战!习近平：坚定不移打赢禁毒战!习近平：坚定不移打赢禁毒战!习近平：坚定不移打赢禁毒战!习近平：坚定不移打赢禁毒战!习近平：坚定不移打赢禁毒战!习近平：坚定不移打赢禁毒战!";
//        bodyLabel.font = [UIFont systemFontOfSize:13];
//        bodyLabel.textAlignment = NSTextAlignmentLeft;
//        //bodyLabel.backgroundColor = [UIColor yellowColor];
//        bodyLabel.lineBreakMode = NSLineBreakByCharWrapping;
//        bodyLabel.numberOfLines = 0;
//        CGSize size1 = CGSizeMake(UISCREENWIDTH*2/3-INTERVALX, MAINNEWSHIGHT-INTERVALY*12);
//        UIFont *font1 = [UIFont fontWithName:@"Arial" size:13];
//        CGSize labelsize1 = [bodyLabel.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
//        bodyLabel.frame = CGRectMake(mainNewsImgView.frame.size.width+INTERVALX*2, INTERVALY*10, UISCREENWIDTH*2/3-INTERVALX, labelsize1.height);
//        bodyLabel.font =font1;
        
        [bodyLabel setBackgroundColor:[UIColor clearColor]];
        [bodyLabel setTextColor:UIColorFromRGBValue(0x676767)];
        [bodyLabel setNumberOfLines:0];
        bodyLabel.font = [UIFont systemFontOfSize:13];;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:bodyLabel.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [bodyLabel.text length])];
        bodyLabel.attributedText = attributedString;
        
        [self.mainNewsBtn addSubview:bodyLabel];
        [self.mainNewsBtn addSubview:newsTitleLabel];
        [self.mainNewsBtn addSubview:mainNewsImgView];
        [self.view addSubview:self.mainNewsBtn];
        
        //走进攀枝花
        self.intoPZHBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.intoPZHBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+SCROllVIEWHIGHT+MAINNEWSHIGHT+INTERVALY,MAINBTNWIDTH,MAINBTNHIGHT);
        [self.intoPZHBtn addTarget:self action:@selector(jumpPageForMainView:) forControlEvents:UIControlEventTouchUpInside];
        self.intoPZHBtn.tag = 1;
        [self.intoPZHBtn setBackgroundImage:[UIImage imageNamed:@"bdj_bj.png"] forState:UIControlStateNormal];
        [self.intoPZHBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];

        UILabel * intoPZHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, UISCREENWIDTH/4, UISCREENHEIGHT/15)];
        intoPZHLabel.center = CGPointMake(MAINBTNWIDTH/5*3, MAINBTNHIGHT/2);
        intoPZHLabel.text = @"走进攀枝花";
        intoPZHLabel.font = [UIFont systemFontOfSize:14];
        intoPZHLabel.textAlignment = NSTextAlignmentLeft;
        
        UIImageView * intoPZHImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"t1.png"]];
        intoPZHImgView.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        intoPZHImgView.center = CGPointMake(MAINBTNWIDTH/5, MAINBTNHIGHT/2);

        [self.intoPZHBtn addSubview:intoPZHLabel];
        [self.intoPZHBtn addSubview:intoPZHImgView];
        [self.view addSubview:self.intoPZHBtn];
        
        //政务公开
        self.openGovernmentAffairsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.openGovernmentAffairsBtn.frame = CGRectMake((INTERVALX+UISCREENWIDTH)/2,NAVIGATIONHIGHT+SCROllVIEWHIGHT+MAINNEWSHIGHT+INTERVALY,MAINBTNWIDTH,MAINBTNHIGHT);
        [self.openGovernmentAffairsBtn addTarget:self action:@selector(jumpPageForMainView:) forControlEvents:UIControlEventTouchUpInside];
        self.openGovernmentAffairsBtn.tag = 2;
        [self.openGovernmentAffairsBtn setBackgroundImage:[UIImage imageNamed:@"bdj_bj.png"] forState:UIControlStateNormal];
        [self.openGovernmentAffairsBtn setBackgroundImage:[UIImage imageNamed:@"dj_bj.png"] forState:UIControlStateHighlighted];
        
        UILabel * openGovernmentAffairsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, UISCREENWIDTH/4, UISCREENHEIGHT/15)];
        openGovernmentAffairsLabel.center = CGPointMake(MAINBTNWIDTH/5*3, MAINBTNHIGHT/2);
        openGovernmentAffairsLabel.text = @"政务公开";
        openGovernmentAffairsLabel.font = [UIFont systemFontOfSize:14];
        openGovernmentAffairsLabel.textAlignment = NSTextAlignmentLeft;
        
        UIImageView * openGovernmentAffairsImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"t2.png"]];
        openGovernmentAffairsImgView.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        openGovernmentAffairsImgView.center = CGPointMake(MAINBTNWIDTH/5, MAINBTNHIGHT/2);
        
        [self.openGovernmentAffairsBtn addSubview:openGovernmentAffairsLabel];
        [self.openGovernmentAffairsBtn addSubview:openGovernmentAffairsImgView];
        [self.view addSubview:self.openGovernmentAffairsBtn];
        
        //网上办事
        self.onlineBusinessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.onlineBusinessBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+SCROllVIEWHIGHT+MAINNEWSHIGHT+INTERVALY*2+MAINBTNHIGHT,MAINBTNWIDTH,MAINBTNHIGHT);
        [self.onlineBusinessBtn addTarget:self action:@selector(jumpPageForMainView:) forControlEvents:UIControlEventTouchUpInside];
        self.onlineBusinessBtn.tag = 3;
        [self.onlineBusinessBtn setBackgroundImage:[UIImage imageNamed:@"bdj_bj.png"] forState:UIControlStateNormal];
        [self.onlineBusinessBtn setBackgroundImage:[UIImage imageNamed:@"dj_bj.png"] forState:UIControlStateHighlighted];
        
        UILabel * onlineBusinessLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, UISCREENWIDTH/4, UISCREENHEIGHT/15)];
        onlineBusinessLabel.center = CGPointMake(MAINBTNWIDTH/5*3, MAINBTNHIGHT/2);
        onlineBusinessLabel.text = @"网上办事";
        onlineBusinessLabel.font = [UIFont systemFontOfSize:14];
        onlineBusinessLabel.textAlignment = NSTextAlignmentLeft;
        
        UIImageView * onlineBusinessImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"t3.png"]];
        onlineBusinessImgView.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        onlineBusinessImgView.center = CGPointMake(MAINBTNWIDTH/5, MAINBTNHIGHT/2);
        
        [self.onlineBusinessBtn addSubview:onlineBusinessLabel];
        [self.onlineBusinessBtn addSubview:onlineBusinessImgView];
        [self.view addSubview:self.onlineBusinessBtn];
        
        //公共服务
        self.publicServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.publicServiceBtn.frame = CGRectMake((INTERVALX+UISCREENWIDTH)/2,NAVIGATIONHIGHT+SCROllVIEWHIGHT+MAINNEWSHIGHT+INTERVALY*2+MAINBTNHIGHT,MAINBTNWIDTH,MAINBTNHIGHT);
        [self.publicServiceBtn addTarget:self action:@selector(jumpPageForMainView:) forControlEvents:UIControlEventTouchUpInside];
        self.publicServiceBtn.tag = 4;
        [self.publicServiceBtn setBackgroundImage:[UIImage imageNamed:@"bdj_bj.png"] forState:UIControlStateNormal];
        [self.publicServiceBtn setBackgroundImage:[UIImage imageNamed:@"dj_bj.png"] forState:UIControlStateHighlighted];
        
        UILabel * publicServiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, UISCREENWIDTH/4, UISCREENHEIGHT/15)];
        publicServiceLabel.center = CGPointMake(MAINBTNWIDTH/5*3, MAINBTNHIGHT/2);
        publicServiceLabel.text = @"网上办事";
        publicServiceLabel.font = [UIFont systemFontOfSize:14];
        publicServiceLabel.textAlignment = NSTextAlignmentLeft;
        
        UIImageView * publicServiceImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"t4.png"]];
        publicServiceImgView.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        publicServiceImgView.center = CGPointMake(MAINBTNWIDTH/5, MAINBTNHIGHT/2);
        
        [self.publicServiceBtn addSubview:publicServiceLabel];
        [self.publicServiceBtn addSubview:publicServiceImgView];
        [self.view addSubview:self.publicServiceBtn];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    
//    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 20)];
//    statusBarView.backgroundColor=[UIColor redColor];
//    [self.view addSubview:statusBarView];
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:242/255.0 green:67/255.0 blue:0/255.0 alpha:1]];

    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self createScrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    appDelegate.title = @"攀枝花公众信息网";
    self.titleLabel.text = appDelegate.title;
    [self.scrollView recountTheTimeIsPause:NO];   //避免页面跳转时scrollView错位
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.scrollView recountTheTimeIsPause:YES];   //避免页面跳转时scrollView错位
}

-(void)jumpPageForMainView:(UIButton *)btn{

    switch (btn.tag) {
        case 1:
            [self.navigationController pushViewController:self.intoPZHViewController animated:YES];
            //[appDelegate playStreamFromURL:[NSURL URLWithString:@"http://www.panzhihua.gov.cn/images/zjpzh/yxpzh/sppzh/xxp/2323.wmv"]];
            break;
//        case 2:
//            [self.navigationController pushViewController:videoForPZH animated:YES];
//            //[appDelegate playStreamFromURL:[NSURL URLWithString:@"http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4"]];
//            break;
//        case 3:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.cityOverview];
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            break;
//        case 4:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.naturalOverview];
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            break;
//        case 5:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyOverview];
//            [self.navigationController pushViewController:detailViewController animated:YES];
            //            [self.navigationController pushViewController:mainVc animated:YES];
            break;
        default:
            break;
    }
}


#pragma mark - 构建幻灯片滚动视图
- (void)createScrollView
{
    self.scrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, NAVIGATIONHIGHT, UISCREENWIDTH, SCROllVIEWHIGHT)];
    AdDataModel * dataModel = [AdDataModel adDataModelWithImageNameAndAdTitleArray];
    //如果滚动视图的父视图由导航控制器控制,必须要设置该属性(ps,猜测这是为了正常显示,导航控制器内部设置了UIEdgeInsetsMake(64, 0, 0, 0))
    self.scrollView.contentInset = UIEdgeInsetsMake(-NAVIGATIONHIGHT, 0, 0, 0);
    
    NSLog(@"%@",dataModel.adTitleArray);
    self.scrollView.imageNameArray = dataModel.imageNameArray;
    self.scrollView.PageControlShowStyle = UIPageControlShowStyleRight;
    self.scrollView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [self.scrollView setAdTitleArray:dataModel.adTitleArray withShowStyle:AdTitleShowStyleLeft];
    
    self.scrollView.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.view addSubview:self.scrollView];
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
