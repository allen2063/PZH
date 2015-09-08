//
//  MainViewController.m
//  PZH
//
//  Created by ZengYifei on 15/6/30.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "MainViewController.h"
#import "DetailWebViewController.h"
@interface MainViewController (){
    AppDelegate * appDelegate;
    BOOL topNewsIsLoaded;
}

@end

@implementation MainViewController
@synthesize intoPZHBtn,titleLabel,intoPZHViewController,scrollView,mainNewsBodyLabel,mainNewsImgView,mainNewsTitleLabel,openGovernmentAffairsViewController,openGovernmentAffairsBtn,onlineBusinessViewController,onlineBusinessBtn,publicServiceBtn,publicServiceViewController,topNewsBufferDic;


#define SCROllVIEWHIGHT ((self.view.bounds.size.height == 480)?  UISCREENHEIGHT*0.44:UISCREENHEIGHT*0.47) //4&4s是480
#define MAINNEWSHIGHT (UISCREENHEIGHT*0.16)
#define MAINBTNHIGHT (UISCREENHEIGHT*0.12)
#define MAINBTNWIDTH (UISCREENWIDTH/2-7.5)
#define INTERVALX (UISCREENWIDTH*2/25)
#define INTERVALY (INTERVALX/2)
#define FONT 14
#define TYPE1BTNWIDTH ((UISCREENWIDTH - INTERVALX*2.5)/2)
#define TYPE1BTNHEIGHT (UISCREENHEIGHT/7)
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = UIColorFromRGBValue(0xececec);
        CGRect bounds = [[UIScreen mainScreen] bounds];
        self.view.frame = bounds;
        
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        

        UIImageView * backgroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        backgroundImageView.image = [UIImage imageNamed:@"bj"];
        [self.view addSubview:backgroundImageView];
        
        UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH*3/5,UISCREENWIDTH*3/5/564*116 )];
        logoImageView.center = CGPointMake(self.view.center.x, NAVIGATIONHIGHT);
        logoImageView.image = [UIImage imageNamed:@"logo"];
        [self.view addSubview:logoImageView];
        
        //走进攀枝花
        self.intoPZHBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.intoPZHBtn.frame = CGRectMake(INTERVALX,UISCREENHEIGHT/3.8,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);
        [self.intoPZHBtn addTarget:self action:@selector(jumpPageForMainView:) forControlEvents:UIControlEventTouchUpInside];
        self.intoPZHBtn.tag = 1;
        [self.intoPZHBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [self.intoPZHBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];

        UILabel * intoPZHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        intoPZHLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        intoPZHLabel.text = @"走进攀枝花";
        intoPZHLabel.textColor = [UIColor whiteColor];
        intoPZHLabel.font = [UIFont systemFontOfSize:FONT];
        intoPZHLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * intoPZHImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zjpzh.png"]];
        intoPZHImgView.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        intoPZHImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - intoPZHLabel.frame.size.height/3);

        [self.intoPZHBtn addSubview:intoPZHLabel];
        [self.intoPZHBtn addSubview:intoPZHImgView];
        [self.view addSubview:self.intoPZHBtn];
        
        //政务公开
        self.openGovernmentAffairsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.openGovernmentAffairsBtn.frame = CGRectMake(INTERVALX*1.5 + TYPE1BTNWIDTH,UISCREENHEIGHT/3.8,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);
        [self.openGovernmentAffairsBtn addTarget:self action:@selector(jumpPageForMainView:) forControlEvents:UIControlEventTouchUpInside];
        self.openGovernmentAffairsBtn.tag = 2;
        [self.openGovernmentAffairsBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [self.openGovernmentAffairsBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * openGovernmentAffairsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        openGovernmentAffairsLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        openGovernmentAffairsLabel.text = @"政务公开";
        openGovernmentAffairsLabel.textColor = [UIColor whiteColor];
        openGovernmentAffairsLabel.font = [UIFont systemFontOfSize:FONT];
        openGovernmentAffairsLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * openGovernmentAffairsImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zwgk.png"]];
        openGovernmentAffairsImgView.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        openGovernmentAffairsImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - intoPZHLabel.frame.size.height/3);
        
        [self.openGovernmentAffairsBtn addSubview:openGovernmentAffairsLabel];
        [self.openGovernmentAffairsBtn addSubview:openGovernmentAffairsImgView];
        [self.view addSubview:self.openGovernmentAffairsBtn];
        
        //网上办事
        self.onlineBusinessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.onlineBusinessBtn.frame = CGRectMake(INTERVALX,UISCREENHEIGHT/3.8 + INTERVALY + TYPE1BTNHEIGHT,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);
        [self.onlineBusinessBtn addTarget:self action:@selector(jumpPageForMainView:) forControlEvents:UIControlEventTouchUpInside];
        self.onlineBusinessBtn.tag = 3;
        [self.onlineBusinessBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [self.onlineBusinessBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * onlineBusinessLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        onlineBusinessLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        onlineBusinessLabel.text = @"网上办事";
        onlineBusinessLabel.textColor = [UIColor whiteColor];
        onlineBusinessLabel.font = [UIFont systemFontOfSize:FONT];
        onlineBusinessLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * onlineBusinessImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wsbs.png"]];
        onlineBusinessImgView.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        onlineBusinessImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - intoPZHLabel.frame.size.height/3);
        
        [self.onlineBusinessBtn addSubview:onlineBusinessLabel];
        [self.onlineBusinessBtn addSubview:onlineBusinessImgView];
        [self.view addSubview:self.onlineBusinessBtn];
        
        //公共服务
        self.publicServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.publicServiceBtn.frame = CGRectMake(INTERVALX*1.5 + TYPE1BTNWIDTH,UISCREENHEIGHT/3.8 + INTERVALY + TYPE1BTNHEIGHT,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);
        [self.publicServiceBtn addTarget:self action:@selector(jumpPageForMainView:) forControlEvents:UIControlEventTouchUpInside];
        self.publicServiceBtn.tag = 4;
        [self.publicServiceBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [self.publicServiceBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * publicServiceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        publicServiceLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        publicServiceLabel.text = @"公共服务";
        publicServiceLabel.textColor = [UIColor whiteColor];
        publicServiceLabel.font = [UIFont systemFontOfSize:FONT];
        publicServiceLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * publicServiceImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ggfw.png"]];
        publicServiceImgView.frame = CGRectMake(0,0, UISCREENHEIGHT/15, UISCREENHEIGHT/15);
        publicServiceImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - intoPZHLabel.frame.size.height/3);
        
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
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    appDelegate.title = @"攀枝花公众信息网";
    self.titleLabel.text = appDelegate.title;
    //隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
}

- (void)jumpPageForMainView:(UIButton *)btn{
    self.intoPZHViewController = [[IntoPZHViewController alloc]init];
    self.openGovernmentAffairsViewController = [[OpenGovernmentAffairsViewController alloc]init];
    self.onlineBusinessViewController = [[OnlineBusinessViewController alloc]init];
    self.publicServiceViewController = [PublicServiceViewController alloc];
    UINavigationController * navCon = [UINavigationController alloc];

    NSMutableArray * picArrForPulicService = [[NSMutableArray alloc]initWithObjects:@"jy",@"sb",@"jy",@"yl",@"zf",@"jt",@"hysy",@"ggsy",@"zjbl.png",@"qykb",@"jyns",@"zzrd",nil];
    NSMutableArray * titleArrForPulicService = [[NSMutableArray alloc]initWithObjects:@"教育",@"社保",@"就业",@"医疗",@"住房",@"交通", @"婚育收养",@"公用事业",@"证件办理",@"企业开办",@"经营纳税",@"资质认定",nil];
    switch (btn.tag) {
        case 1:
            appDelegate.parentTitle = @"走进攀枝花";
            navCon = [navCon initWithRootViewController:self.intoPZHViewController];
            [self presentViewController:navCon animated:YES completion:nil];
//            [self.navigationController pushViewController:self.intoPZHViewController animated:YES];
            break;
        case 2:
            appDelegate.parentTitle = @"政务公开";
            navCon = [navCon initWithRootViewController:self.openGovernmentAffairsViewController];
            [self presentViewController:navCon animated:YES completion:nil];
//            [self.navigationController pushViewController:self.openGovernmentAffairsViewController animated:YES];
            break;
        case 3:
            appDelegate.parentTitle = @"网上办事";
            navCon = [navCon initWithRootViewController:self.onlineBusinessViewController];
            [self presentViewController:navCon animated:YES completion:nil];
//            [self.navigationController pushViewController:self.onlineBusinessViewController animated:YES];
            break;
        case 4:
            appDelegate.parentTitle = @"公共服务";
            self.publicServiceViewController = [self.publicServiceViewController initWithNibName:nil bundle:nil WithPicArray:picArrForPulicService andTitleArray:titleArrForPulicService];
            navCon = [navCon initWithRootViewController:self.publicServiceViewController];
            [self presentViewController:navCon animated:YES completion:nil];
//            [self.navigationController pushViewController:self.publicServiceViewController animated:YES];
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
