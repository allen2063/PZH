//
//  EconomyViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/14.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "EconomyViewController.h"
#import "AppDelegate.h"
#import "DetailWebViewController.h"
@interface EconomyViewController (){
    AppDelegate * appDelegate;
}
@end

@implementation EconomyViewController
@synthesize titleLabel,economyArray;
#define INTERVALX (UISCREENWIDTH*1/25)
#define INTERVALY (INTERVALX*2/3)
#define FONT 14
#define TYPE3BTNWIDTH ((UISCREENWIDTH - INTERVALX*4)/3)
#define TYPE3BTNHEIGHT (UISCREENHEIGHT/6.5)
#define TYPE1BTNWIDTH ((UISCREENWIDTH - INTERVALX*2.5)/2)
#define TYPE1BTNHEIGHT (UISCREENHEIGHT/6.5)
#define ICONWIDTH (TYPE3BTNWIDTH/2)


//#define ICONWIDTH (UISCREENWIDTH/3-INTEVALX*4)
//#define ICONHEIGHT ((UISCREENHEIGHT-NAVIGATIONHIGHT)/5-INTEVALY)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
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
        self.economyArray = [[NSMutableArray alloc]initWithObjects:@"2015年",@"2014年",@"2013年",@"2012年",@"2011年",@"2010年",@"2009年",@"2008年",@"2007年",@"2006年",@"2005年", nil];
        //经济综述
        UIButton * economySumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        economySumBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY,TYPE3BTNWIDTH,TYPE3BTNHEIGHT);
        [economySumBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        economySumBtn.tag = 1;
        [economySumBtn setBackgroundImage:[UIImage imageNamed:@"tb_3"] forState:UIControlStateNormal];
        [economySumBtn setBackgroundImage:[UIImage imageNamed:@"tb_3dj.png"] forState:UIControlStateHighlighted];
        
        UILabel * economySumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE3BTNWIDTH, TYPE3BTNHEIGHT/4)];
        economySumLabel.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*6/7);
        economySumLabel.text = @"经济综述";
        economySumLabel.textColor = [UIColor whiteColor];
        economySumLabel.font = [UIFont boldSystemFontOfSize:FONT];
        economySumLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * economySumImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jjzs"]];
        economySumImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        economySumImgView.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*3/7);
        
        [economySumBtn addSubview:economySumLabel];
        [economySumBtn addSubview:economySumImgView];
        [self.view addSubview:economySumBtn];
        
        //农业
        UIButton * agricultureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agricultureBtn.frame = CGRectMake(INTERVALX*2+TYPE3BTNWIDTH,NAVIGATIONHIGHT+INTERVALY,TYPE3BTNWIDTH,TYPE3BTNHEIGHT);
        [agricultureBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        agricultureBtn.tag = 2;
        [agricultureBtn setBackgroundImage:[UIImage imageNamed:@"tb_3"] forState:UIControlStateNormal];
        [agricultureBtn setBackgroundImage:[UIImage imageNamed:@"tb_3dj"] forState:UIControlStateHighlighted];
        
        UILabel * agricultureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE3BTNWIDTH, TYPE3BTNHEIGHT/4)];
        agricultureLabel.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*6/7);
        agricultureLabel.text = @"农业";
        agricultureLabel.textColor = [UIColor whiteColor];
        agricultureLabel.font = [UIFont boldSystemFontOfSize:FONT];
        agricultureLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * agricultureImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ny"]];
        agricultureImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        agricultureImgView.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*3/7);
        
        [agricultureBtn addSubview:agricultureLabel];
        [agricultureBtn addSubview:agricultureImgView];
        [self.view addSubview:agricultureBtn];
        
        //工业
        UIButton * industryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        industryBtn.frame = CGRectMake(INTERVALX*3+TYPE3BTNWIDTH*2,NAVIGATIONHIGHT+INTERVALY,TYPE3BTNWIDTH,TYPE3BTNHEIGHT);
        [industryBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        industryBtn.tag = 3;
        [industryBtn setBackgroundImage:[UIImage imageNamed:@"tb_3"] forState:UIControlStateNormal];
        [industryBtn setBackgroundImage:[UIImage imageNamed:@"tb_3dj"] forState:UIControlStateHighlighted];
        
        UILabel * industryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE3BTNWIDTH, TYPE3BTNHEIGHT/4)];
        industryLabel.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*6/7);
        industryLabel.text = @"工业";
        industryLabel.textColor = [UIColor whiteColor];
        industryLabel.font = [UIFont boldSystemFontOfSize:FONT];
        industryLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * industryImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gy"]];
        industryImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        industryImgView.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*3/7);
        
        [industryBtn addSubview:industryLabel];
        [industryBtn addSubview:industryImgView];
        [self.view addSubview:industryBtn];
        
        //建筑业
        UIButton * architectureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        architectureBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*2+TYPE3BTNHEIGHT,TYPE3BTNWIDTH,TYPE3BTNHEIGHT);
        [architectureBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        architectureBtn.tag = 4;
        [architectureBtn setBackgroundImage:[UIImage imageNamed:@"tb_3"] forState:UIControlStateNormal];
        [architectureBtn setBackgroundImage:[UIImage imageNamed:@"tb_3dj"] forState:UIControlStateHighlighted];
        
        UILabel * architectureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE3BTNWIDTH, TYPE3BTNHEIGHT/4)];
        architectureLabel.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*6/7);
        architectureLabel.text = @"建筑业";
        architectureLabel.textColor = [UIColor whiteColor];
        architectureLabel.font = [UIFont boldSystemFontOfSize:FONT];
        architectureLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * architectureLabelImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jzy"]];
        architectureLabelImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        architectureLabelImgView.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*3/7);
        
        [architectureBtn addSubview:architectureLabel];
        [architectureBtn addSubview:architectureLabelImgView];
        [self.view addSubview:architectureBtn];
        
        //房地产业
        UIButton * estateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        estateBtn.frame = CGRectMake(INTERVALX*2+TYPE3BTNWIDTH,NAVIGATIONHIGHT+INTERVALY*2+TYPE3BTNHEIGHT,TYPE3BTNWIDTH,TYPE3BTNHEIGHT);
        [estateBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        estateBtn.tag = 5;
        [estateBtn setBackgroundImage:[UIImage imageNamed:@"tb_3"] forState:UIControlStateNormal];
        [estateBtn setBackgroundImage:[UIImage imageNamed:@"tb_3dj"] forState:UIControlStateHighlighted];
        
        UILabel * estateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE3BTNWIDTH, TYPE3BTNHEIGHT/4)];
        estateLabel.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*6/7);
        estateLabel.text = @"房地产业";
        estateLabel.textColor = [UIColor whiteColor];
        estateLabel.font = [UIFont boldSystemFontOfSize:FONT];
        estateLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * estateImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fdcy"]];
        estateImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        estateImgView.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*3/7);
        
        [estateBtn addSubview:estateLabel];
        [estateBtn addSubview:estateImgView];
        [self.view addSubview:estateBtn];
        
        //运输邮电
        UIButton * translationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        translationBtn.frame = CGRectMake(INTERVALX*3+TYPE3BTNWIDTH*2,NAVIGATIONHIGHT+INTERVALY*2+TYPE3BTNHEIGHT,TYPE3BTNWIDTH,TYPE3BTNHEIGHT);
        [translationBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        translationBtn.tag = 6;
        [translationBtn setBackgroundImage:[UIImage imageNamed:@"tb_3"] forState:UIControlStateNormal];
        [translationBtn setBackgroundImage:[UIImage imageNamed:@"tb_3dj"] forState:UIControlStateHighlighted];
        
        UILabel * translationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE3BTNWIDTH, TYPE3BTNHEIGHT/4)];
        translationLabel.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*6/7);
        translationLabel.text = @"运输邮电";
        translationLabel.textColor = [UIColor whiteColor];
        translationLabel.font = [UIFont boldSystemFontOfSize:FONT];
        translationLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * translationImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ysyd"]];
        translationImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        translationImgView.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*3/7);
        
        [translationBtn addSubview:translationLabel];
        [translationBtn addSubview:translationImgView];
        [self.view addSubview:translationBtn];
        
        //财政税收
        UIButton * taxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        taxBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*3+TYPE3BTNHEIGHT*2,TYPE3BTNWIDTH,TYPE3BTNHEIGHT);
        [taxBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        taxBtn.tag = 7;
        [taxBtn setBackgroundImage:[UIImage imageNamed:@"tb_3"] forState:UIControlStateNormal];
        [taxBtn setBackgroundImage:[UIImage imageNamed:@"tb_3dj"] forState:UIControlStateHighlighted];
        
        UILabel * taxLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE3BTNWIDTH, TYPE3BTNHEIGHT/4)];
        taxLabel.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*6/7);
        taxLabel.text = @"财政税收";
        taxLabel.textColor = [UIColor whiteColor];
        taxLabel.font = [UIFont boldSystemFontOfSize:FONT];
        taxLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * taxImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"czss"]];
        taxImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        taxImgView.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*3/7);
        
        [taxBtn addSubview:taxLabel];
        [taxBtn addSubview:taxImgView];
        [self.view addSubview:taxBtn];
        
        //固定资产投资
        UIButton * investmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        investmentBtn.frame = CGRectMake(INTERVALX*2+TYPE3BTNWIDTH,NAVIGATIONHIGHT+INTERVALY*3+TYPE3BTNHEIGHT*2,TYPE3BTNWIDTH,TYPE3BTNHEIGHT);
        [investmentBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        investmentBtn.tag = 8;
        [investmentBtn setBackgroundImage:[UIImage imageNamed:@"tb_3"] forState:UIControlStateNormal];
        [investmentBtn setBackgroundImage:[UIImage imageNamed:@"tb_3dj"] forState:UIControlStateHighlighted];
        
        UILabel * investmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE3BTNWIDTH, TYPE3BTNHEIGHT/4)];
        investmentLabel.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*6/7);
        investmentLabel.text = @"固定资产投资";
        investmentLabel.textColor = [UIColor whiteColor];
        investmentLabel.font = [UIFont boldSystemFontOfSize:FONT];
        investmentLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * investmentImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gdzctz.png"]];
        investmentImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        investmentImgView.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*3/7);
        
        [investmentBtn addSubview:investmentLabel];
        [investmentBtn addSubview:investmentImgView];
        [self.view addSubview:investmentBtn];
        
        //金融保险业
        UIButton * financeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        financeBtn.frame = CGRectMake(INTERVALX*3+TYPE3BTNWIDTH*2,NAVIGATIONHIGHT+INTERVALY*3+TYPE3BTNHEIGHT*2,TYPE3BTNWIDTH,TYPE3BTNHEIGHT);
        [financeBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        financeBtn.tag = 9;
        [financeBtn setBackgroundImage:[UIImage imageNamed:@"tb_3"] forState:UIControlStateNormal];
        [financeBtn setBackgroundImage:[UIImage imageNamed:@"tb_3dj"] forState:UIControlStateHighlighted];
        
        UILabel * financeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE3BTNWIDTH, TYPE3BTNHEIGHT/4)];
        financeLabel.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*6/7);
        financeLabel.text = @"金融保险业";
        financeLabel.textColor = [UIColor whiteColor];
        financeLabel.font = [UIFont boldSystemFontOfSize:FONT];
        financeLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * financeImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jrbxy.png"]];
        financeImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        financeImgView.center = CGPointMake(TYPE3BTNWIDTH/2, TYPE3BTNHEIGHT*3/7);
        
        [financeBtn addSubview:financeLabel];
        [financeBtn addSubview:financeImgView];
        [self.view addSubview:financeBtn];
        
        //收入与消费
        UIButton * incomAndConsumptionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        incomAndConsumptionBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*4+TYPE3BTNHEIGHT*3,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);
        [incomAndConsumptionBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        incomAndConsumptionBtn.tag = 10;
        [incomAndConsumptionBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [incomAndConsumptionBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * incomAndConsumptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/4)];
        incomAndConsumptionLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        incomAndConsumptionLabel.text = @"收入与消费";
        incomAndConsumptionLabel.textColor = [UIColor whiteColor];
        incomAndConsumptionLabel.font = [UIFont boldSystemFontOfSize:FONT];
        incomAndConsumptionLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * incomAndConsumptionImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sryxf.png"]];
        incomAndConsumptionImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        incomAndConsumptionImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*3/7);
        
        [incomAndConsumptionBtn addSubview:incomAndConsumptionLabel];
        [incomAndConsumptionBtn addSubview:incomAndConsumptionImgView];
        [self.view addSubview:incomAndConsumptionBtn];
        
        //旅游
        UIButton * travelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        travelBtn.frame = CGRectMake(INTERVALX*2+TYPE1BTNWIDTH,NAVIGATIONHIGHT+INTERVALY*4+TYPE3BTNHEIGHT*3,TYPE1BTNWIDTH,TYPE1BTNHEIGHT);;
        [travelBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        travelBtn.tag = 11;
        [travelBtn setBackgroundImage:[UIImage imageNamed:@"tb_1"] forState:UIControlStateNormal];
        [travelBtn setBackgroundImage:[UIImage imageNamed:@"tb_1dj"] forState:UIControlStateHighlighted];
        
        UILabel * travelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, TYPE1BTNWIDTH, TYPE1BTNHEIGHT/4)];
        travelLabel.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*6/7);
        travelLabel.text = @"旅游";
        travelLabel.textColor = [UIColor whiteColor];
        travelLabel.font = [UIFont boldSystemFontOfSize:FONT];
        travelLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * travelImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ly.png"]];
        travelImgView.frame = CGRectMake(0,0, ICONWIDTH, ICONWIDTH);
        travelImgView.center = CGPointMake(TYPE1BTNWIDTH/2, TYPE1BTNHEIGHT*3/7);
        
        [travelBtn addSubview:travelLabel];
        [travelBtn addSubview:travelImgView];
        [self.view addSubview:travelBtn];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.titleLabel.text = @"国民经济";
    appDelegate.title = @"国民经济";
}

-(void)jumpPageForEconomy:(UIButton *)btn{
    DetailWebViewController * detailViewController = [DetailWebViewController alloc];
    switch (btn.tag) {
        case 1:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"经济综述";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
        case 2:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"农业";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
        case 3:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"工业";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
        case 4:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"建筑业";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
        case 5:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"房地产业";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
        case 6:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"运输邮电";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
        case 7:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"财政税收";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
        case 8:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"固定资产投资";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
        case 9:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"金融保险业";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
        case 10:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"收入与消费";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
        case 11:
            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
            appDelegate.title = @"旅游";
            [self.navigationController pushViewController:detailViewController animated:YES];
            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
            break;
            
        default:
            break;
    }
    
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
