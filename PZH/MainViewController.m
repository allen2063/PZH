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

#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
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
        self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];//[UIColor yellowColor];//
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
        [self.mainNewsBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        self.mainNewsBtn.tag = 5;
        self.mainNewsBtn.backgroundColor = [UIColor whiteColor];
        
        UIImageView * mainNewsBackgroundImgVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xw_bj.png"]];
        mainNewsBackgroundImgVIew.frame = self.mainNewsBtn.bounds;
        
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
        [bodyLabel setTextColor:[UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1]];
        [bodyLabel setNumberOfLines:0];
        bodyLabel.font = [UIFont systemFontOfSize:13];;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:bodyLabel.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [bodyLabel.text length])];
        bodyLabel.attributedText = attributedString;
        
        [mainNewsBackgroundImgVIew addSubview:bodyLabel];
        [mainNewsBackgroundImgVIew addSubview:newsTitleLabel];
        [mainNewsBackgroundImgVIew addSubview:mainNewsImgView];
        [self.mainNewsBtn addSubview:mainNewsBackgroundImgVIew];
        [self.view addSubview:self.mainNewsBtn];
        
        //走进攀枝花
        self.intoPZHBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.intoPZHBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+SCROllVIEWHIGHT+MAINNEWSHIGHT+INTERVALY,MAINBTNWIDTH,MAINBTNHIGHT);
        [self.intoPZHBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        self.intoPZHBtn.tag = 1;
        self.intoPZHBtn.backgroundColor = [UIColor whiteColor];
        
        UILabel * intoPZHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, UISCREENWIDTH/4, UISCREENHEIGHT/15)];
        intoPZHLabel.center = CGPointMake(MAINBTNWIDTH/5*3, MAINBTNHIGHT/2);
        intoPZHLabel.text = @"走进攀枝花";
        intoPZHLabel.font = [UIFont systemFontOfSize:14];
        intoPZHLabel.textAlignment = NSTextAlignmentLeft;
        
        UIImageView * intoPZHImgVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"t1.png"]];
        intoPZHImgVIew.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        intoPZHImgVIew.center = CGPointMake(MAINBTNWIDTH/5, MAINBTNHIGHT/2);

        [self.intoPZHBtn addSubview:intoPZHLabel];
        [self.intoPZHBtn addSubview:intoPZHImgVIew];
        [self.view addSubview:self.intoPZHBtn];
        
        //政务公开
        self.openGovernmentAffairsBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.openGovernmentAffairsBtn.frame = CGRectMake((INTERVALX+UISCREENWIDTH)/2,NAVIGATIONHIGHT+SCROllVIEWHIGHT+MAINNEWSHIGHT+INTERVALY,MAINBTNWIDTH,MAINBTNHIGHT);
        [self.openGovernmentAffairsBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        self.openGovernmentAffairsBtn.tag = 2;
        self.openGovernmentAffairsBtn.backgroundColor = [UIColor whiteColor];
        
        UILabel * openGovernmentAffairsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, UISCREENWIDTH/4, UISCREENHEIGHT/15)];
        openGovernmentAffairsLabel.center = CGPointMake(MAINBTNWIDTH/5*3, MAINBTNHIGHT/2);
        openGovernmentAffairsLabel.text = @"政务公开";
        openGovernmentAffairsLabel.font = [UIFont systemFontOfSize:14];
        openGovernmentAffairsLabel.textAlignment = NSTextAlignmentLeft;
        
        UIImageView * openGovernmentAffairsImgVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"t2.png"]];
        openGovernmentAffairsImgVIew.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        openGovernmentAffairsImgVIew.center = CGPointMake(MAINBTNWIDTH/5, MAINBTNHIGHT/2);
        
        [self.openGovernmentAffairsBtn addSubview:openGovernmentAffairsLabel];
        [self.openGovernmentAffairsBtn addSubview:openGovernmentAffairsImgVIew];
        [self.view addSubview:self.openGovernmentAffairsBtn];
        
        //网上办事
        self.onlineBusinessBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.onlineBusinessBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+SCROllVIEWHIGHT+MAINNEWSHIGHT+INTERVALY*2+MAINBTNHIGHT,MAINBTNWIDTH,MAINBTNHIGHT);
        [self.onlineBusinessBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        self.onlineBusinessBtn.tag = 3;
        self.onlineBusinessBtn.backgroundColor = [UIColor whiteColor];
        
        UILabel * onlineBusinessLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, UISCREENWIDTH/4, UISCREENHEIGHT/15)];
        onlineBusinessLabel.center = CGPointMake(MAINBTNWIDTH/5*3, MAINBTNHIGHT/2);
        onlineBusinessLabel.text = @"网上办事";
        onlineBusinessLabel.font = [UIFont systemFontOfSize:14];
        onlineBusinessLabel.textAlignment = NSTextAlignmentLeft;
        
        UIImageView * onlineBusinessImgVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"t3.png"]];
        onlineBusinessImgVIew.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        onlineBusinessImgVIew.center = CGPointMake(MAINBTNWIDTH/5, MAINBTNHIGHT/2);
        
        [self.onlineBusinessBtn addSubview:onlineBusinessLabel];
        [self.onlineBusinessBtn addSubview:onlineBusinessImgVIew];
        [self.view addSubview:self.onlineBusinessBtn];
        
        //公共服务
        self.publicServiceBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.publicServiceBtn.frame = CGRectMake((INTERVALX+UISCREENWIDTH)/2,NAVIGATIONHIGHT+SCROllVIEWHIGHT+MAINNEWSHIGHT+INTERVALY*2+MAINBTNHIGHT,MAINBTNWIDTH,MAINBTNHIGHT);
        [self.publicServiceBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        self.publicServiceBtn.tag = 4;
        self.publicServiceBtn.backgroundColor = [UIColor whiteColor];
        
        UILabel * publicServiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, UISCREENWIDTH/4, UISCREENHEIGHT/15)];
        publicServiceLabel.center = CGPointMake(MAINBTNWIDTH/5*3, MAINBTNHIGHT/2);
        publicServiceLabel.text = @"网上办事";
        publicServiceLabel.font = [UIFont systemFontOfSize:14];
        publicServiceLabel.textAlignment = NSTextAlignmentLeft;
        
        UIImageView * publicServiceImgVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"t4.png"]];
        publicServiceImgVIew.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        publicServiceImgVIew.center = CGPointMake(MAINBTNWIDTH/5, MAINBTNHIGHT/2);
        
        [self.publicServiceBtn addSubview:publicServiceLabel];
        [self.publicServiceBtn addSubview:publicServiceImgVIew];
        [self.view addSubview:self.publicServiceBtn];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    [self.scrollView recountTheTime];   //避免页面跳转时scrollView错位
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.scrollView recountTheTime];   //避免页面跳转时scrollView错位
}

-(void)jumpPage:(UIButton *)btn{

    switch (btn.tag) {
        case 1:
            appDelegate.title = @"走进攀枝花";
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
