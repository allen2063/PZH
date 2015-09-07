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
#define INTERVALX UISCREENWIDTH/18
#define INTERVALY UISCREENHEIGHT/35
#define MAINBTNWIDTH UISCREENWIDTH*1/3
#define MAINBTNHEIGHT UISCREENWIDTH/4
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        UIScrollView * scrView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        scrView.contentSize =  CGSizeMake( UISCREENWIDTH, NAVIGATIONHIGHT+MAINBTNHEIGHT*5.5+INTERVALY*5);
        scrView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:scrView];
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        
        UIImageView * splitLineImgView1 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"xian.png"]];
        splitLineImgView1.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT+INTERVALY*1.5, UISCREENWIDTH, 1);
        [scrView addSubview:splitLineImgView1];
        UIImageView * splitLineImgView2 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"xian.png"]];
        splitLineImgView2.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT*3+INTERVALY*2.5, UISCREENWIDTH, 1);
        [scrView addSubview:splitLineImgView2];
        UIImageView * splitLineImgView3 = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"xian.png"]];
        splitLineImgView3.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT*4.5+INTERVALY*3.5, UISCREENWIDTH, 1);
        [scrView addSubview:splitLineImgView3];
        
        //办事公告
        self.announcementOfWorkArray = [[NSMutableArray alloc]initWithObjects:@"办事公告",@"在线办事查询",@"办件统计",@"热点办事事项", nil];
        UIButton * announcementOfWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        announcementOfWorkBtn.frame = CGRectMake(0,NAVIGATIONHIGHT,UISCREENWIDTH,MAINBTNHEIGHT+INTERVALY*1.5);
        [announcementOfWorkBtn addTarget:self action:@selector(jumpPageForOnlineBusiness:) forControlEvents:UIControlEventTouchUpInside];
        announcementOfWorkBtn.tag = 1;
        [announcementOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * announcementOfWorkLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        announcementOfWorkLabel1.text = @"办事公告   在线办事查询";
        announcementOfWorkLabel1.font = [UIFont systemFontOfSize:12];
        announcementOfWorkLabel1.textAlignment = NSTextAlignmentLeft;
        [announcementOfWorkBtn addSubview:announcementOfWorkLabel1];
        
        UILabel * announcementOfWorkLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY+announcementOfWorkLabel1.frame.size.height, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        announcementOfWorkLabel2.text = @"办件统计   热点办事事项";
        announcementOfWorkLabel2.font = [UIFont systemFontOfSize:12];
        announcementOfWorkLabel2.textAlignment = NSTextAlignmentLeft;
        [announcementOfWorkBtn addSubview:announcementOfWorkLabel2];
        
        UIImageView * announcementOfWorkImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bsgg.png"]];
        announcementOfWorkImgView.frame = CGRectMake(INTERVALX,INTERVALY,MAINBTNWIDTH,MAINBTNHEIGHT);
        UIImage * announcementOfWorkLabelImg = [UIImage imageNamed:@"bs.png"];
        UIImageView * announcementOfWorkLabelImgView = [[UIImageView alloc]initWithImage:announcementOfWorkLabelImg];
        announcementOfWorkLabelImgView.frame = CGRectMake(0, 0, announcementOfWorkLabelImg.size.width/3.3, announcementOfWorkLabelImg.size.height/3.3);
        announcementOfWorkLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [announcementOfWorkImgView addSubview:announcementOfWorkLabelImgView];
        [announcementOfWorkBtn addSubview:announcementOfWorkImgView];
        [scrView addSubview:announcementOfWorkBtn];
        
        //面向市民
        self.forTheCitizensArray = [[NSMutableArray alloc]initWithObjects:@"生育服务",@"儿童服务",@"证件办理",@"教育培训",@"交通车辆",@"娱乐购物", @"餐饮住宿",@"消费权益",@"法律司法",@"就业求职",@"土地住房",@"医疗保险",@"婚姻服务",@"公用事业",@"金融服务",@"社会保障",@"家庭社区",@"老年生活",@"社会求助",@"出行旅游",@"兵役服务",@"殡葬服务",@"便民服务",nil];
        UIButton * forTheCitizensBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forTheCitizensBtn.frame = CGRectMake(0,NAVIGATIONHIGHT+INTERVALY*1.5+MAINBTNHEIGHT,UISCREENWIDTH,MAINBTNHEIGHT*2+INTERVALY);
        [forTheCitizensBtn addTarget:self action:@selector(jumpPageForOnlineBusiness:) forControlEvents:UIControlEventTouchUpInside];
        forTheCitizensBtn.tag = 2;
        [forTheCitizensBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * forTheCitizensLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forTheCitizensLabel1.text = @"生育服务   儿童服务   证件办理";
        forTheCitizensLabel1.font = [UIFont systemFontOfSize:12];
        forTheCitizensLabel1.textAlignment = NSTextAlignmentLeft;
        [forTheCitizensBtn addSubview:forTheCitizensLabel1];
        UILabel * forTheCitizensLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forTheCitizensLabel1.frame.size.height, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forTheCitizensLabel2.text = @"教育培训   交通车辆   娱乐购物";
        forTheCitizensLabel2.font = [UIFont systemFontOfSize:12];
        forTheCitizensLabel2.textAlignment = NSTextAlignmentLeft;
        [forTheCitizensBtn addSubview:forTheCitizensLabel2];
        UILabel * forTheCitizensLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forTheCitizensLabel1.frame.size.height*2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forTheCitizensLabel3.text = @"餐饮住宿   消费权益   法律司法";
        forTheCitizensLabel3.font = [UIFont systemFontOfSize:12];
        forTheCitizensLabel3.textAlignment = NSTextAlignmentLeft;
        [forTheCitizensBtn addSubview:forTheCitizensLabel3];
        UILabel * forTheCitizensLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forTheCitizensLabel1.frame.size.height*3, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forTheCitizensLabel4.text = @"就业求职   土地住房   医疗保险";
        forTheCitizensLabel4.font = [UIFont systemFontOfSize:12];
        forTheCitizensLabel4.textAlignment = NSTextAlignmentLeft;
        [forTheCitizensBtn addSubview:forTheCitizensLabel4];
        UILabel * forTheCitizensLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forTheCitizensLabel1.frame.size.height*4, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forTheCitizensLabel5.text = @"婚姻服务   公共事业   金融服务";
        forTheCitizensLabel5.font = [UIFont systemFontOfSize:12];
        forTheCitizensLabel5.textAlignment = NSTextAlignmentLeft;
        [forTheCitizensBtn addSubview:forTheCitizensLabel5];
        UILabel * forTheCitizensLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forTheCitizensLabel1.frame.size.height*5, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forTheCitizensLabel6.text = @"社会保障   家庭社区   老年生活";
        forTheCitizensLabel6.font = [UIFont systemFontOfSize:12];
        forTheCitizensLabel6.textAlignment = NSTextAlignmentLeft;
        [forTheCitizensBtn addSubview:forTheCitizensLabel6];
        UILabel * forTheCitizensLabel7 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forTheCitizensLabel1.frame.size.height*6, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forTheCitizensLabel7.text = @"社会求助   出行旅游   兵役服务";
        forTheCitizensLabel7.font = [UIFont systemFontOfSize:12];
        forTheCitizensLabel7.textAlignment = NSTextAlignmentLeft;
        [forTheCitizensBtn addSubview:forTheCitizensLabel7];
        UILabel * forTheCitizensLabel8 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forTheCitizensLabel1.frame.size.height*7, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forTheCitizensLabel8.text = @"殡葬服务   便民服务";
        forTheCitizensLabel8.font = [UIFont systemFontOfSize:12];
        forTheCitizensLabel8.textAlignment = NSTextAlignmentLeft;
        [forTheCitizensBtn addSubview:forTheCitizensLabel8];
        
        UIImageView * forTheCitizensImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mxsm.png"]];
        forTheCitizensImgView.frame = CGRectMake(INTERVALX,(INTERVALY+MAINBTNHEIGHT)/2,MAINBTNWIDTH,MAINBTNHEIGHT);;
        UIImage * forTheCitizensLabelImg = [UIImage imageNamed:@"sm.png"];
        UIImageView * forTheCitizensLabelImgView = [[UIImageView alloc]initWithImage:forTheCitizensLabelImg];
        forTheCitizensLabelImgView.frame = CGRectMake(0, 0, forTheCitizensLabelImg.size.width/3.3, forTheCitizensLabelImg.size.height/3.3);
        forTheCitizensLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [forTheCitizensImgView addSubview:forTheCitizensLabelImgView];
        [forTheCitizensBtn addSubview:forTheCitizensImgView];
        [scrView addSubview:forTheCitizensBtn];
        
        //面向企业
        self.forEnterpriseArray = [[NSMutableArray alloc]initWithObjects:@"设立准营",@"人力资源",@"劳动保障",@"年检办理",@"环保绿化",@"工程建设",@"法律司法",@"对外贸易",@"财税事物",@"土地房产",@"质量监督",@"安全防护",@"教育管理",@"金融保险",@"新闻出版",@"知识产权",@"破产申办",@"综合其他", nil];
        UIButton * forEnterpriseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        forEnterpriseBtn.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT*3+INTERVALY*2.5,UISCREENWIDTH,MAINBTNHEIGHT*1.5+INTERVALY);
        [forEnterpriseBtn addTarget:self action:@selector(jumpPageForOnlineBusiness:) forControlEvents:UIControlEventTouchUpInside];
        forEnterpriseBtn.tag = 3;
        [forEnterpriseBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * forEnterpriseLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forEnterpriseLabel1.text = @"设立准营   人力资源    劳动保障";
        forEnterpriseLabel1.font = [UIFont systemFontOfSize:12];
        forEnterpriseLabel1.textAlignment = NSTextAlignmentLeft;
        forEnterpriseLabel1.backgroundColor = [UIColor clearColor];
        [forEnterpriseBtn addSubview:forEnterpriseLabel1];
        UILabel * forEnterpriseLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forEnterpriseLabel1.frame.size.height, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forEnterpriseLabel2.text = @"年检办理   环保绿化   工程建设";
        forEnterpriseLabel2.font = [UIFont systemFontOfSize:12];
        forEnterpriseLabel2.textAlignment = NSTextAlignmentLeft;
        [forEnterpriseBtn addSubview:forEnterpriseLabel2];
        UILabel * forEnterpriseLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forEnterpriseLabel1.frame.size.height*2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forEnterpriseLabel3.text = @"法律司法   对外贸易   财税事务";
        forEnterpriseLabel3.font = [UIFont systemFontOfSize:12];
        forEnterpriseLabel3.textAlignment = NSTextAlignmentLeft;
        [forEnterpriseBtn addSubview:forEnterpriseLabel3];
        UILabel * forEnterpriseLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forEnterpriseLabel1.frame.size.height*3, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forEnterpriseLabel4.text = @"土地房产   质量监督   安全防护";
        forEnterpriseLabel4.font = [UIFont systemFontOfSize:12];
        forEnterpriseLabel4.textAlignment = NSTextAlignmentLeft;
        [forEnterpriseBtn addSubview:forEnterpriseLabel4];
        UILabel * forEnterpriseLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forEnterpriseLabel1.frame.size.height*4, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forEnterpriseLabel5.text = @"教育管理   金融保险   新闻出版";
        forEnterpriseLabel5.font = [UIFont systemFontOfSize:12];
        forEnterpriseLabel5.textAlignment = NSTextAlignmentLeft;
        [forEnterpriseBtn addSubview:forEnterpriseLabel5];
        UILabel * forEnterpriseLabel6 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+forEnterpriseLabel1.frame.size.height*5, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        forEnterpriseLabel6.text = @"知识产权   破产申请   综合其他";
        forEnterpriseLabel6.font = [UIFont systemFontOfSize:12];
        forEnterpriseLabel6.textAlignment = NSTextAlignmentLeft;
        [forEnterpriseBtn addSubview:forEnterpriseLabel6];
        
        UIImageView * forEnterpriseImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mxqy.png"]];
        forEnterpriseImgView.frame = CGRectMake(INTERVALX,(MAINBTNHEIGHT*0.5 +INTERVALY)/2,MAINBTNWIDTH,MAINBTNHEIGHT);
        UIImage * forEnterpriseLabelImg = [UIImage imageNamed:@"qy.png"];
        UIImageView * forEnterpriseLabelImgView = [[UIImageView alloc]initWithImage:forEnterpriseLabelImg];
        forEnterpriseLabelImgView.frame = CGRectMake(0, 0, forEnterpriseLabelImg.size.width/3.3, forEnterpriseLabelImg.size.height/3.3);
        forEnterpriseLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [forEnterpriseImgView addSubview:forEnterpriseLabelImgView];
        [forEnterpriseBtn addSubview:forEnterpriseImgView];
        [scrView addSubview:forEnterpriseBtn];

        //绿色通道
        self.GreenChannelArray = [[NSMutableArray alloc]initWithObjects:@"农民",@"学生",@"儿童",@"妇女",@"残疾人",@"投资者", nil];
        UIButton * GreenChannelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        GreenChannelBtn.frame = CGRectMake(0,NAVIGATIONHIGHT+MAINBTNHEIGHT*4.5+INTERVALY*3.5,UISCREENWIDTH,MAINBTNHEIGHT+INTERVALY);
        [GreenChannelBtn addTarget:self action:@selector(jumpPageForOnlineBusiness:) forControlEvents:UIControlEventTouchUpInside];
        GreenChannelBtn.tag = 4;
        [GreenChannelBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * GreenChannelLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        GreenChannelLabel1.text = @"农民  学生 儿童  妇女  残疾人  ";
        GreenChannelLabel1.font = [UIFont systemFontOfSize:12];
        GreenChannelLabel1.textAlignment = NSTextAlignmentLeft;
        GreenChannelLabel1.backgroundColor = [UIColor clearColor];
        [GreenChannelBtn addSubview:GreenChannelLabel1];
        UILabel * GreenChannelLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH*3/7,INTERVALY/2+GreenChannelLabel1.frame.size.height, UISCREENWIDTH*4/7, MAINBTNHEIGHT/4)];
        GreenChannelLabel2.text = @"投资者";
        GreenChannelLabel2.font = [UIFont systemFontOfSize:12];
        GreenChannelLabel2.textAlignment = NSTextAlignmentLeft;
        GreenChannelLabel2.backgroundColor = [UIColor clearColor];
        [GreenChannelBtn addSubview:GreenChannelLabel2];
        
        UIImageView * GreenChannelImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lstd.png"]];
        GreenChannelImgView.frame = CGRectMake(INTERVALX,INTERVALY/2,MAINBTNWIDTH,MAINBTNHEIGHT);
        UIImage * GreenChannelLabelImg = [UIImage imageNamed:@"ls.png"];
        UIImageView * GreenChannelLabelImgView = [[UIImageView alloc]initWithImage:GreenChannelLabelImg];
        GreenChannelLabelImgView.frame = CGRectMake(0, 0, GreenChannelLabelImg.size.width/3.3, GreenChannelLabelImg.size.height/3.3);
        GreenChannelLabelImgView.center = CGPointMake(MAINBTNWIDTH*2/3,MAINBTNHEIGHT*3/4);
        
        [GreenChannelImgView addSubview:GreenChannelLabelImgView];
        [GreenChannelBtn addSubview:GreenChannelImgView];
        [scrView addSubview:GreenChannelBtn];
    }
    return self;
}

- (void)jumpPageForOnlineBusiness:(UIButton *)btn{
    AnnouncementOfWorkViewController * announcementOfWorkViewController = [[AnnouncementOfWorkViewController alloc]init];
    
    NSMutableArray * picArrForCitizens = [[NSMutableArray alloc]initWithObjects:@"syfw",@"etfw",@"zjblsm",@"jypx",@"jtcl",@"gwyl",@"cyzs",@"xfqy",@"flsfsm",@"jyqz",@"tdzf",@"ylbx",@"hyfw",@"ggsy",@"jrfw",@"shbz",@"jtsq",@"lnsh",@"shqz",@"cxly",@"byfw",@"bzfw",@"bmfw",nil];
    NSMutableArray * titleArrForCitizens = [[NSMutableArray alloc]initWithObjects:@"生育服务",@"儿童服务",@"证件办理",@"教育培训",@"交通车辆",@"娱乐购物", @"餐饮住宿",@"消费权益",@"法律司法",@"就业求职",@"土地住房",@"医疗保险",@"婚姻服务",@"公用事业",@"金融服务",@"社会保障",@"家庭社区",@"老年生活",@"社会求助",@"出行旅游",@"兵役服务",@"殡葬服务",@"便民服务",nil];
    
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
