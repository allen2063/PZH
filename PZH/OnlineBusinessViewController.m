//
//  OnlineBusinessViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/29.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "OnlineBusinessViewController.h"
#import "AppDelegate.h"
#import "AnnouncementOfWorkViewController.h"
#import "ForCitizensAndEnterpriseAndGreenChannelViewController.h"
@interface OnlineBusinessViewController (){
    AppDelegate * appDelegate;
}

@end

@implementation OnlineBusinessViewController
@synthesize GreenChannelArray,forEnterpriseArray,forTheCitizensArray,announcementOfWorkArray,titleLabel;
#define INTERVALX (UISCREENWIDTH*2/25)
#define INTERVALY (INTERVALX*2/3.)
#define FONT 14
#define TYPE1BTNWIDTH ((UISCREENWIDTH - INTERVALX*2.5)/2)
#define TYPE1BTNHEIGHT (UISCREENHEIGHT/7)
#define TYPE2BTNWIDTH (UISCREENWIDTH - INTERVALX*2)
#define TYPE2BTNHEIGHT TYPE1BTNHEIGHT

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIImageView * backgroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        backgroundImageView.image = [UIImage imageNamed:@"bjgy"];
        [self.view addSubview:backgroundImageView];
        
        UIImageView * logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH*4/9,UISCREENWIDTH*4/9/400*60 )];
        logoImageView.center = CGPointMake(self.view.center.x, UISCREENHEIGHT - NAVIGATIONHIGHT*2/3);
        logoImageView.image = [UIImage imageNamed:@"bg_wenzi"];
        [self.view addSubview:logoImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        
        //办事公告
        self.announcementOfWorkArray = [[NSMutableArray alloc]initWithObjects:@"办事公告",@"在线办事查询",@"办件统计",@"热点办事事项", nil];
        
        UIButton * announcementOfWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        announcementOfWorkBtn.frame = CGRectMake(INTERVALX,INTERVALY + NAVIGATIONHIGHT,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);;
        [announcementOfWorkBtn addTarget:self action:@selector(jumpPageForOnlineBusiness:) forControlEvents:UIControlEventTouchUpInside];
        announcementOfWorkBtn.tag = 1;
        [announcementOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [announcementOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * announcementOfWorkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        announcementOfWorkLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        announcementOfWorkLabel.text = @"办事公告";
        announcementOfWorkLabel.textColor = [UIColor whiteColor];
        announcementOfWorkLabel.font = [UIFont boldSystemFontOfSize:FONT];
        announcementOfWorkLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * announcementOfWorkImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bsgg"]];
        announcementOfWorkImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        announcementOfWorkImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - announcementOfWorkLabel.frame.size.height/3);
        
        [announcementOfWorkBtn addSubview:announcementOfWorkLabel];
        [announcementOfWorkBtn addSubview:announcementOfWorkImgView];
        [self.view addSubview:announcementOfWorkBtn];
        
        //面向市民
        self.forTheCitizensArray = [[NSMutableArray alloc]initWithObjects:@"生育服务",@"儿童服务",@"证件办理",@"教育培训",@"交通车辆",@"娱乐购物", @"餐饮住宿",@"消费权益",@"法律司法",@"就业求职",@"土地住房",@"医疗保险",@"婚姻服务",@"公用事业",@"金融服务",@"社会保障",@"家庭社区",@"老年生活",@"社会求助",@"出行旅游",@"兵役服务",@"殡葬服务",@"便民服务",nil];
        
        UIButton * forTheCitizensBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forTheCitizensBtn.frame = CGRectMake(INTERVALX*1.5 + TYPE1BTNWIDTH,INTERVALY + NAVIGATIONHIGHT,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);
        [forTheCitizensBtn addTarget:self action:@selector(jumpPageForOnlineBusiness:) forControlEvents:UIControlEventTouchUpInside];
        forTheCitizensBtn.tag = 2;
        
        [forTheCitizensBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [forTheCitizensBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * forTheCitizensLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/3)];
        forTheCitizensLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        forTheCitizensLabel.text = @"面向市民";
        forTheCitizensLabel.textColor = [UIColor whiteColor];
        forTheCitizensLabel.font = [UIFont boldSystemFontOfSize:FONT];
        forTheCitizensLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * forTheCitizensImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mxsm"]];
        forTheCitizensImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        forTheCitizensImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT/2 - forTheCitizensLabel.frame.size.height/3);
        
        [forTheCitizensBtn addSubview:forTheCitizensLabel];
        [forTheCitizensBtn addSubview:forTheCitizensImgView];
        [self.view addSubview:forTheCitizensBtn];
        
        //面向企业
        self.forEnterpriseArray = [[NSMutableArray alloc]initWithObjects:@"设立准营",@"人力资源",@"劳动保障",@"年检办理",@"环保绿化",@"工程建设",@"法律司法",@"对外贸易",@"财税事物",@"土地房产",@"质量监督",@"安全防护",@"教育管理",@"金融保险",@"新闻出版",@"知识产权",@"破产申办",@"综合其他", nil];
        
        UIButton * forEnterpriseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forEnterpriseBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*2+TYPE2BTNHEIGHT,TYPE2BTNWIDTH,TYPE2BTNHEIGHT);
        [forEnterpriseBtn addTarget:self action:@selector(jumpPageForOnlineBusiness:) forControlEvents:UIControlEventTouchUpInside];
        forEnterpriseBtn.tag = 3;
        [forEnterpriseBtn setBackgroundImage:[UIImage imageNamed:@"tb_2"] forState:UIControlStateNormal];
        [forEnterpriseBtn setBackgroundImage:[UIImage imageNamed:@"tb_2dj"] forState:UIControlStateHighlighted];
        
        UILabel * forEnterpriseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE2BTNWIDTH, TYPE2BTNHEIGHT/3)];
        forEnterpriseLabel.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT*6/7);
        forEnterpriseLabel.text = @"面向企业";
        forEnterpriseLabel.textColor = [UIColor whiteColor];
        forEnterpriseLabel.font = [UIFont boldSystemFontOfSize:FONT];
        forEnterpriseLabel.textAlignment = NSTextAlignmentCenter;
        forEnterpriseLabel.backgroundColor = [UIColor clearColor];
        [forEnterpriseBtn addSubview:forEnterpriseLabel];
        
        UIImageView * forEnterpriseImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mxqiy"]];
        forEnterpriseImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        forEnterpriseImgView.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT/2 - forEnterpriseLabel.frame.size.height/3-2);
        
        [forEnterpriseBtn addSubview:forEnterpriseLabel];
        [forEnterpriseBtn addSubview:forEnterpriseImgView];
        [self.view addSubview:forEnterpriseBtn];

        //绿色通道
        self.GreenChannelArray = [[NSMutableArray alloc]initWithObjects:@"农民",@"学生",@"儿童",@"妇女",@"残疾人",@"投资者", nil];
        
        UIButton * GreenChannelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        GreenChannelBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*3+TYPE2BTNHEIGHT*2,TYPE2BTNWIDTH,TYPE2BTNHEIGHT);
        [GreenChannelBtn addTarget:self action:@selector(jumpPageForOnlineBusiness:) forControlEvents:UIControlEventTouchUpInside];
        GreenChannelBtn.tag = 4;
        [GreenChannelBtn setBackgroundImage:[UIImage imageNamed:@"tb_2"] forState:UIControlStateNormal];
        [GreenChannelBtn setBackgroundImage:[UIImage imageNamed:@"tb_2dj"] forState:UIControlStateHighlighted];
        
        UILabel * GreenChannelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE2BTNWIDTH, TYPE2BTNHEIGHT/3)];
        GreenChannelLabel.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT*6/7);
        GreenChannelLabel.text = @"绿色通道";
        GreenChannelLabel.textColor = [UIColor whiteColor];
        GreenChannelLabel.font = [UIFont boldSystemFontOfSize:FONT];
        GreenChannelLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * GreenChannelImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lstd"]];
        GreenChannelImgView.frame = CGRectMake(0,0, TYPE1BTNHEIGHT*2/3, TYPE1BTNHEIGHT*2/3);
        GreenChannelImgView.center = CGPointMake(TYPE2BTNWIDTH/2, TYPE2BTNHEIGHT/2 - GreenChannelLabel.frame.size.height/3);
        
        [GreenChannelBtn addSubview:GreenChannelLabel];
        [GreenChannelBtn addSubview:GreenChannelImgView];
        [self.view addSubview:GreenChannelBtn];
    }
    return self;
}

- (void)jumpPageForOnlineBusiness:(UIButton *)btn{
    AnnouncementOfWorkViewController * announcementOfWorkViewController = [[AnnouncementOfWorkViewController alloc]init];
    
    NSMutableArray * picArrForCitizens = [[NSMutableArray alloc]initWithObjects:@"syfw",@"ertfuwu",@"zjbl",@"jypx",@"jtcl",@"gwyl",@"cyzs",@"xfqy",@"flsfa",@"jyqz",@"tdzfa",@"ylbj",@"hyfw",@"gysy",@"jrfw",@"shbz",@"jtsq",@"lnsh",@"shqz",@"cxly",@"byfw",@"bzfw",@"bmfw",nil];
    NSMutableArray * titleArrForCitizens = [[NSMutableArray alloc]initWithObjects:@"生育服务",@"儿童服务",@"证件办理",@"教育培训",@"交通车辆",@"娱乐购物", @"餐饮住宿",@"消费权益",@"法律司法",@"就业求职",@"土地住房",@"医疗保健",@"婚姻服务",@"公用事业",@"金融服务",@"社会保障",@"家庭社区",@"老年生活",@"社会求助",@"出行旅游",@"兵役服务",@"殡葬服务",@"便民服务",nil];
    
    NSMutableArray * picArrForEnterprise = [[NSMutableArray alloc]initWithObjects:@"slzy",@"rlzy",@"ldbz",@"njbl",@"hblh",@"gcjs",@"flsf",@"dwmy",@"cssw",@"tdfc",@"zljd",@"aqfh",@"jygl",@"jrbx",@"xwcb",@"zscq",@"pcsb",@"zhqt",nil];
    NSMutableArray * titleArrForEnterprise = [[NSMutableArray alloc]initWithObjects:@"设立准营",@"人力资源",@"劳动保障",@"年检办理",@"环保绿化",@"工程建设", @"法律司法",@"对外贸易",@"财税事物",@"土地房产",@"质量监督",@"安全防护",@"教育管理",@"金融保险",@"新闻出版",@"知识产权",@"破产申办",@"综合其他",nil];
    NSMutableArray * picArrForGreenChannel = [[NSMutableArray alloc]initWithObjects:@"nm",@"xs",@"et",@"fn",@"cjr",@"tzz",nil];
    NSMutableArray * titleArrForGreenChannel = [[NSMutableArray alloc]initWithObjects:@"农民",@"学生",@"儿童",@"妇女",@"残疾人",@"投资者", nil];
    ForCitizensAndEnterpriseAndGreenChannelViewController * forTheCitizensViewController = [ForCitizensAndEnterpriseAndGreenChannelViewController alloc];
    switch (btn.tag) {
        case 1:
            appDelegate.title = @"公告公示";
            [self.navigationController pushViewController:announcementOfWorkViewController animated:YES];
            break;
        case 2:
            appDelegate.title = @"面向市民";
            forTheCitizensViewController = [forTheCitizensViewController initWithNibName:nil bundle:nil WithPicArray:picArrForCitizens andTitleArray:titleArrForCitizens];
            [self.navigationController pushViewController:forTheCitizensViewController animated:YES];
            break;
        case 3:
            appDelegate.title = @"面向企业";
            forTheCitizensViewController = [forTheCitizensViewController initWithNibName:nil bundle:nil WithPicArray:picArrForEnterprise andTitleArray:titleArrForEnterprise];
            [self.navigationController pushViewController:forTheCitizensViewController animated:YES];
            break;
        case 4:
            appDelegate.title = @"绿色通道";
            forTheCitizensViewController = [forTheCitizensViewController initWithNibName:nil bundle:nil WithPicArray:picArrForGreenChannel andTitleArray:titleArrForGreenChannel];
            [self.navigationController pushViewController:forTheCitizensViewController animated:YES];
            break;
//        case 5:
//            appDelegate.title = @"区县快讯";
//            newsViewController = [newsViewController init];
//            [self.navigationController pushViewController:newsViewController animated:YES];
            break;
            
            break;
        default:
            break;
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14, 23)];
    backImageView.image = [UIImage imageNamed:@"fh"];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 14, 24);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn addSubview:backImageView];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = backItem;
    backItem.customView = backBtn;
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.titleLabel.text = @"网上办事";
    appDelegate.title = @"网上办事";
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
