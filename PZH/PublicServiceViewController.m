//
//  PublicServiceViewController.m
//  PZH
//
//  Created by ZengYifei on 15/8/6.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "PublicServiceViewController.h"
#import "FirstTableVIewViewController.h"
@interface PublicServiceViewController (){
    AppDelegate * appDelegate;
    NSArray * titleNameArray;
}


@end

@implementation PublicServiceViewController
@synthesize titleLabel;
#define INTERVALX (UISCREENWIDTH/40)
#define INTERVALY (UISCREENHEIGHT/50)
#define BLOCKWIDTH ((UISCREENWIDTH-INTERVALX*4)/3)
#define BLOCKHEIGHT ((UISCREENHEIGHT-NAVIGATIONHIGHT-INTERVALY*5)/5)
#define ICONWIDTH (UISCREENWIDTH/3-INTEVALX*4)
#define ICONHEIGHT ((UISCREENHEIGHT-NAVIGATIONHIGHT)/5-INTEVALY)
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithPicArray:(NSMutableArray *)picArray andTitleArray:(NSMutableArray *)titleArray
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
        
        titleNameArray = titleArray;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.titleLabel.text = appDelegate.title;
        
        [self buildThePageWithPicArray:picArray andTitleArray:titleArray];
    }
    return self;
}
- (void)buildThePageWithPicArray:(NSMutableArray *)picArray andTitleArray:(NSMutableArray *)titleArray{
    
    int rowInPage = (int)picArray.count / 3;                    //  每行3个图标   一共多少行
    int leftInPage = picArray.count % 3;                    //最后剩几个
    self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
    UIScrollView * scrView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrView.contentSize =  CGSizeMake( UISCREENWIDTH, NAVIGATIONHIGHT+BLOCKHEIGHT*(rowInPage+ (leftInPage == 0 ? 0 : 1))+INTERVALY*(rowInPage+ (leftInPage == 0 ? 0 : 1)+1));
    scrView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrView];
    for (int i = 0; i < rowInPage; i++) {
        //第一项图标
        UIButton * firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        firstBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*(i+1)+BLOCKHEIGHT*i,BLOCKWIDTH,BLOCKHEIGHT);
        [firstBtn addTarget:self action:@selector(jumpPageForPublcService:) forControlEvents:UIControlEventTouchUpInside];
        firstBtn.tag = i*3+1;
        [firstBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [firstBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        firstLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        firstLabel.text = [titleArray objectAtIndex:i*3];
        firstLabel.font = [UIFont systemFontOfSize:14];
        firstLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * firstImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[picArray objectAtIndex:i*3]]];
        firstImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        firstImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [firstBtn addSubview:firstLabel];
        [firstBtn addSubview:firstImgView];
        [scrView addSubview:firstBtn];
        
        //第二项图标
        UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        secondBtn.frame = CGRectMake(INTERVALX*2+BLOCKWIDTH,NAVIGATIONHIGHT+INTERVALY*(i+1)+BLOCKHEIGHT*i,BLOCKWIDTH,BLOCKHEIGHT);
        [secondBtn addTarget:self action:@selector(jumpPageForPublcService:) forControlEvents:UIControlEventTouchUpInside];
        secondBtn.tag = i*3+2;
        [secondBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [secondBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        secondLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        secondLabel.text = [titleArray objectAtIndex:i*3+1];
        secondLabel.font = [UIFont systemFontOfSize:14];
        secondLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * secondImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[picArray objectAtIndex:i*3+1]]];
        secondImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        secondImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [secondBtn addSubview:secondLabel];
        [secondBtn addSubview:secondImgView];
        [scrView addSubview:secondBtn];
        
        //第三项图标
        UIButton * thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(INTERVALX*3+BLOCKWIDTH*2,NAVIGATIONHIGHT+INTERVALY*(i+1)+BLOCKHEIGHT*i,BLOCKWIDTH,BLOCKHEIGHT);
        [thirdBtn addTarget:self action:@selector(jumpPageForPublcService:) forControlEvents:UIControlEventTouchUpInside];
        thirdBtn.tag = i*3+3;
        [thirdBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
        [thirdBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
        
        UILabel * thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
        thirdLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
        thirdLabel.text = [titleArray objectAtIndex:i*3+2];
        thirdLabel.font = [UIFont systemFontOfSize:14];
        thirdLabel.textAlignment = NSTextAlignmentCenter;
        
        UIImageView * thirdImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[picArray objectAtIndex:i*3+2]]];
        thirdImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
        thirdImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
        
        [thirdBtn addSubview:thirdLabel];
        [thirdBtn addSubview:thirdImgView];
        [scrView addSubview:thirdBtn];
    }
    switch (leftInPage) {
        case 1:
        {
            UIButton * firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            firstBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*(rowInPage+1)+BLOCKHEIGHT*rowInPage,BLOCKWIDTH,BLOCKHEIGHT);
            [firstBtn addTarget:self action:@selector(jumpPageForPublcService:) forControlEvents:UIControlEventTouchUpInside];
            firstBtn.tag = rowInPage + 1;
            [firstBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
            [firstBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
            
            UILabel * firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
            firstLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
            firstLabel.text = [titleArray objectAtIndex:rowInPage*3+1];
            firstLabel.font = [UIFont systemFontOfSize:14];
            firstLabel.textAlignment = NSTextAlignmentCenter;
            
            UIImageView * firstImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[picArray objectAtIndex:rowInPage*3+1]]];
            firstImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
            firstImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
            
            [firstBtn addSubview:firstLabel];
            [firstBtn addSubview:firstImgView];
            [scrView addSubview:firstBtn];
        }
            break;
        case 2:
        {
            UIButton * firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            firstBtn.frame = CGRectMake(INTERVALX,NAVIGATIONHIGHT+INTERVALY*(rowInPage+1)+BLOCKHEIGHT*rowInPage,BLOCKWIDTH,BLOCKHEIGHT);
            [firstBtn addTarget:self action:@selector(jumpPageForPublcService:) forControlEvents:UIControlEventTouchUpInside];
            firstBtn.tag = rowInPage + 1;
            [firstBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
            [firstBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
            
            UILabel * firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
            firstLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
            firstLabel.text = [titleArray objectAtIndex:rowInPage*3];
            firstLabel.font = [UIFont systemFontOfSize:14];
            firstLabel.textAlignment = NSTextAlignmentCenter;
            
            UIImageView * firstImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[picArray objectAtIndex:rowInPage*3]]];
            firstImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
            firstImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
            
            [firstBtn addSubview:firstLabel];
            [firstBtn addSubview:firstImgView];
            [scrView addSubview:firstBtn];
            
            UIButton * secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            secondBtn.frame = CGRectMake(INTERVALX*2+BLOCKWIDTH,NAVIGATIONHIGHT+INTERVALY*(rowInPage+1)+BLOCKHEIGHT*rowInPage,BLOCKWIDTH,BLOCKHEIGHT);
            [secondBtn addTarget:self action:@selector(jumpPageForPublcService:) forControlEvents:UIControlEventTouchUpInside];
            secondBtn.tag = rowInPage + 2;
            [secondBtn setBackgroundImage:[UIImage imageNamed:@"iconBackground.png"] forState:UIControlStateNormal];
            [secondBtn setBackgroundImage:[UIImage imageNamed:@"dj_1.png"] forState:UIControlStateHighlighted];
            
            UILabel * secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, BLOCKWIDTH, BLOCKHEIGHT/4)];
            secondLabel.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*4/5);
            secondLabel.text = [titleArray objectAtIndex:rowInPage*3+1];
            secondLabel.font = [UIFont systemFontOfSize:14];
            secondLabel.textAlignment = NSTextAlignmentCenter;
            
            UIImageView * secondImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[picArray objectAtIndex:rowInPage*3+1]]];
            secondImgView.frame = CGRectMake(0,0, BLOCKWIDTH/2, BLOCKHEIGHT/2);
            secondImgView.center = CGPointMake(BLOCKWIDTH/2, BLOCKHEIGHT*3/7);
            
            [secondBtn addSubview:secondLabel];
            [secondBtn addSubview:secondImgView];
            [scrView addSubview:secondBtn];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)jumpPageForPublcService:(UIButton *)btn{
    appDelegate.title = [titleNameArray objectAtIndex:(btn.tag-1)];
    NSMutableArray * titleArray = [NSMutableArray arrayWithObjects:appDelegate.title, nil];
    FirstTableVIewViewController * firstTableVIewViewController = [[FirstTableVIewViewController alloc]initWithNibName:nil bundle:nil AndTagNumber:(btn.tag-1) AndSegArray:titleArray];
    [self.navigationController pushViewController:firstTableVIewViewController animated:YES];

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
    self.titleLabel.text = @"公共服务";
    appDelegate.title = @"公共服务";
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
