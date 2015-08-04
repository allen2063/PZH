//
//  announcementOfWorkViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/29.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "AnnouncementOfWorkViewController.h"
#import "AppDelegate.h"
@interface AnnouncementOfWorkViewController (){
    AppDelegate * appDelegate;
}

@end

@implementation AnnouncementOfWorkViewController
@synthesize titleLabel;
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
        
        //办事公告
        UIButton * announceOfWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        announceOfWorkBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY,BLOCKWIDTH,BLOCKHEIGHT);
        [announceOfWorkBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        announceOfWorkBtn.tag = 1;
        [announceOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [announceOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * announceOfWorkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        announceOfWorkLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        announceOfWorkLabel.text = @"办事公告";
        announceOfWorkLabel.font = [UIFont systemFontOfSize:14];
        announceOfWorkLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * announceOfWorkImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bsggicon.png"]];
        announceOfWorkImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        announceOfWorkImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [announceOfWorkBtn addSubview:announceOfWorkLabel];
        [announceOfWorkBtn addSubview:announceOfWorkImgView];
        [self.view addSubview:announceOfWorkBtn];
        
        //在线办事查询
        UIButton * onlineBusinessSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        onlineBusinessSearchBtn.frame = CGRectMake(INTERVALX*2+BLOCKWIDTH,NAVIGATIONHIGHT+INTERVALY,BLOCKWIDTH,BLOCKHEIGHT);
        [onlineBusinessSearchBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        onlineBusinessSearchBtn.tag = 2;
        [onlineBusinessSearchBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [onlineBusinessSearchBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * onlineBusinessSearchLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        onlineBusinessSearchLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        onlineBusinessSearchLabel.text = @"在线办事查询";
        onlineBusinessSearchLabel.font = [UIFont systemFontOfSize:14];
        onlineBusinessSearchLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * onlineBusinessSearchImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zxbscx.png"]];
        onlineBusinessSearchImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        onlineBusinessSearchImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [onlineBusinessSearchBtn addSubview:onlineBusinessSearchLabel];
        [onlineBusinessSearchBtn addSubview:onlineBusinessSearchImgView];
        [self.view addSubview:onlineBusinessSearchBtn];
        
        //办事统计
        UIButton * statisticsOfWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statisticsOfWorkBtn.frame = CGRectMake(INTERVALX*3+BLOCKWIDTH*2,NAVIGATIONHIGHT+INTERVALY,BLOCKWIDTH,BLOCKHEIGHT);
        [statisticsOfWorkBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        statisticsOfWorkBtn.tag = 3;
        [statisticsOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [statisticsOfWorkBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * statisticsOfWorkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        statisticsOfWorkLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        statisticsOfWorkLabel.text = @"办事统计";
        statisticsOfWorkLabel.font = [UIFont systemFontOfSize:14];
        statisticsOfWorkLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * statisticsOfWorkImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bjtj.png"]];
        statisticsOfWorkImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        statisticsOfWorkImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [statisticsOfWorkBtn addSubview:statisticsOfWorkLabel];
        [statisticsOfWorkBtn addSubview:statisticsOfWorkImgView];
        [self.view addSubview:statisticsOfWorkBtn];
        
        //热点办事事项
        UIButton * hotWorkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        hotWorkBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*2+BLOCKHEIGHT,BLOCKWIDTH,BLOCKHEIGHT);
        [hotWorkBtn addTarget:self action:@selector(jumpPageForEconomy:) forControlEvents:UIControlEventTouchUpInside];
        hotWorkBtn.tag = 4;
        [hotWorkBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [hotWorkBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * hotWorkLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        hotWorkLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        hotWorkLabel.text = @"热点办事";
        hotWorkLabel.font = [UIFont systemFontOfSize:14];
        hotWorkLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * hotWorkImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rdbssx.png"]];
        hotWorkImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        hotWorkImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [hotWorkBtn addSubview:hotWorkLabel];
        [hotWorkBtn addSubview:hotWorkImgView];
        [self.view addSubview:hotWorkBtn];
    }
    return self;
}

-(void)jumpPageForEconomy:(UIButton *)btn{
    //DetailWebViewController * detailViewController = [DetailWebViewController alloc];
//    switch (btn.tag) {
//        case 1:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"经济综述";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//        case 2:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"农业";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//        case 3:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"工业";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//        case 4:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"建筑业";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//        case 5:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"房地产业";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//        case 6:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"运输邮电";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//        case 7:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"财政税收";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//        case 8:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"固定资产投资";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//        case 9:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"金融保险业";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//        case 10:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"收入与消费";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//        case 11:
//            detailViewController = [detailViewController initWithNibName:nil bundle:nil WithURL:nil andSegArray:self.economyArray];
//            appDelegate.title = @"旅游";
//            [self.navigationController pushViewController:detailViewController animated:YES];
//            [appDelegate.conAPI getMenuContentAPIWithChannelName:@"2015年" andChannelNext:appDelegate.title];
//            break;
//            
//        default:
//            break;
//    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //没数据。。。。
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.titleLabel.text = @"办事公告";
    appDelegate.title = @"办事公告";
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
