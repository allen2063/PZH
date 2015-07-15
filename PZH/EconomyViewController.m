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
#define INTERVALX (UISCREENWIDTH/40)
#define INTERVALY (UISCREENHEIGHT/50)
#define BLOCKWIDTH ((UISCREENWIDTH-INTERVALX*4)/3)
#define BLOCKHEIGHT ((UISCREENHEIGHT-NAVIGATIONHIGHT-INTERVALY*5)/5)
#define ICONWIDTH (UISCREENWIDTH/3-INTEVALX*4)
#define ICONHEIGHT ((UISCREENHEIGHT-NAVIGATIONHIGHT)/5-INTEVALY)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
        self.economyArray = [[NSMutableArray alloc]initWithObjects:@"2015年",@"2014年",@"2013年",@"2012年",@"2011年",@"2010年",@"2009年",@"2008年",@"2007年",@"2006年",@"2005年", nil];
        //经济综述
        UIButton * economySumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        economySumBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY,BLOCKWIDTH,BLOCKHEIGHT);
        [economySumBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        economySumBtn.tag = 1;
        [economySumBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [economySumBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * economySumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        economySumLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        economySumLabel.text = @"经济综述";
        economySumLabel.font = [UIFont systemFontOfSize:14];
        economySumLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * economySumImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_1.png"]];
        economySumImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        economySumImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [economySumBtn addSubview:economySumLabel];
        [economySumBtn addSubview:economySumImgView];
        [self.view addSubview:economySumBtn];
        
        //农业
        UIButton * agricultureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        agricultureBtn.frame = CGRectMake(INTERVALX*2+BLOCKWIDTH,NAVIGATIONHIGHT+INTERVALY,BLOCKWIDTH,BLOCKHEIGHT);
        [agricultureBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        agricultureBtn.tag = 2;
        [agricultureBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [agricultureBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * agricultureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        agricultureLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        agricultureLabel.text = @"农业";
        agricultureLabel.font = [UIFont systemFontOfSize:14];
        agricultureLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * agricultureImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_2.png"]];
        agricultureImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        agricultureImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [agricultureBtn addSubview:agricultureLabel];
        [agricultureBtn addSubview:agricultureImgView];
        [self.view addSubview:agricultureBtn];
        
        //工业
        UIButton * industryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        industryBtn.frame = CGRectMake(INTERVALX*3+BLOCKWIDTH*2,NAVIGATIONHIGHT+INTERVALY,BLOCKWIDTH,BLOCKHEIGHT);
        [industryBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        industryBtn.tag = 3;
        [industryBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [industryBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * industryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        industryLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        industryLabel.text = @"工业";
        industryLabel.font = [UIFont systemFontOfSize:14];
        industryLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * industryImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_3.png"]];
        industryImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        industryImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [industryBtn addSubview:industryLabel];
        [industryBtn addSubview:industryImgView];
        [self.view addSubview:industryBtn];
        
        //建筑业
        UIButton * architectureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        architectureBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*2+BLOCKHEIGHT,BLOCKWIDTH,BLOCKHEIGHT);
        [architectureBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        architectureBtn.tag = 4;
        [architectureBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [architectureBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * architectureLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        architectureLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        architectureLabel.text = @"建筑业";
        architectureLabel.font = [UIFont systemFontOfSize:14];
        architectureLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * architectureLabelImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_4.png"]];
        architectureLabelImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        architectureLabelImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [architectureBtn addSubview:architectureLabel];
        [architectureBtn addSubview:architectureLabelImgView];
        [self.view addSubview:architectureBtn];
        
        //房地产业
        UIButton * estateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        estateBtn.frame = CGRectMake(INTERVALX*2+BLOCKWIDTH,NAVIGATIONHIGHT+INTERVALY*2+BLOCKHEIGHT,BLOCKWIDTH,BLOCKHEIGHT);
        [estateBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        estateBtn.tag = 5;
        [estateBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [estateBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * estateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        estateLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        estateLabel.text = @"房地产业";
        estateLabel.font = [UIFont systemFontOfSize:14];
        estateLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * estateImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_5.png"]];
        estateImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        estateImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [estateBtn addSubview:estateLabel];
        [estateBtn addSubview:estateImgView];
        [self.view addSubview:estateBtn];
        
        //运输邮电
        UIButton * translationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        translationBtn.frame = CGRectMake(INTERVALX*3+BLOCKWIDTH*2,NAVIGATIONHIGHT+INTERVALY*2+BLOCKHEIGHT,BLOCKWIDTH,BLOCKHEIGHT);
        [translationBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        translationBtn.tag = 6;
        [translationBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [translationBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * translationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        translationLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        translationLabel.text = @"运输邮电";
        translationLabel.font = [UIFont systemFontOfSize:14];
        translationLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * translationImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_6.png"]];
        translationImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        translationImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [translationBtn addSubview:translationLabel];
        [translationBtn addSubview:translationImgView];
        [self.view addSubview:translationBtn];
        
        //财政税收
        UIButton * taxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        taxBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*3+BLOCKHEIGHT*2,BLOCKWIDTH,BLOCKHEIGHT);
        [taxBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        taxBtn.tag = 7;
        [taxBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [taxBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * taxLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        taxLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        taxLabel.text = @"财政税收";
        taxLabel.font = [UIFont systemFontOfSize:14];
        taxLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * taxImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_7.png"]];
        taxImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        taxImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [taxBtn addSubview:taxLabel];
        [taxBtn addSubview:taxImgView];
        [self.view addSubview:taxBtn];
        
        //固定资产投资
        UIButton * investmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        investmentBtn.frame = CGRectMake(INTERVALX*2+BLOCKWIDTH,NAVIGATIONHIGHT+INTERVALY*3+BLOCKHEIGHT*2,BLOCKWIDTH,BLOCKHEIGHT);
        [investmentBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        investmentBtn.tag = 8;
        [investmentBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [investmentBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * investmentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        investmentLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        investmentLabel.text = @"固定资产投资";
        investmentLabel.font = [UIFont systemFontOfSize:14];
        investmentLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * investmentImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_8.png"]];
        investmentImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        investmentImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [investmentBtn addSubview:investmentLabel];
        [investmentBtn addSubview:investmentImgView];
        [self.view addSubview:investmentBtn];
        
        //金融保险业
        UIButton * financeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        financeBtn.frame = CGRectMake(INTERVALX*3+BLOCKWIDTH*2,NAVIGATIONHIGHT+INTERVALY*3+BLOCKHEIGHT*2,BLOCKWIDTH,BLOCKHEIGHT);
        [financeBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        financeBtn.tag = 9;
        [financeBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [financeBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * financeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        financeLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        financeLabel.text = @"金融保险业";
        financeLabel.font = [UIFont systemFontOfSize:14];
        financeLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * financeImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_9.png"]];
        financeImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        financeImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [financeBtn addSubview:financeLabel];
        [financeBtn addSubview:financeImgView];
        [self.view addSubview:financeBtn];
        
        //收入与消费
        UIButton * incomAndConsumptionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        incomAndConsumptionBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*4+BLOCKHEIGHT*3,BLOCKWIDTH,BLOCKHEIGHT);
        [incomAndConsumptionBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        incomAndConsumptionBtn.tag = 10;
        [incomAndConsumptionBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [incomAndConsumptionBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * incomAndConsumptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        incomAndConsumptionLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        incomAndConsumptionLabel.text = @"收入与消费";
        incomAndConsumptionLabel.font = [UIFont systemFontOfSize:14];
        incomAndConsumptionLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * incomAndConsumptionImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_10.png"]];
        incomAndConsumptionImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        incomAndConsumptionImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [incomAndConsumptionBtn addSubview:incomAndConsumptionLabel];
        [incomAndConsumptionBtn addSubview:incomAndConsumptionImgView];
        [self.view addSubview:incomAndConsumptionBtn];
        
        //旅游
        UIButton * travelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        travelBtn.frame = CGRectMake(INTERVALX*2+BLOCKWIDTH,NAVIGATIONHIGHT+INTERVALY*4+BLOCKHEIGHT*3,BLOCKWIDTH,BLOCKHEIGHT);
        [travelBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        travelBtn.tag = 11;
        [travelBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [travelBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * travelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        travelLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        travelLabel.text = @"旅游";
        travelLabel.font = [UIFont systemFontOfSize:14];
        travelLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * travelImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tb_11.png"]];
        travelImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        travelImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
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
