//
//  OnlineBusinessSearchViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/29.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "OnlineBusinessSearchViewController.h"

@interface OnlineBusinessSearchViewController (){
    AppDelegate * appDelegate;
    UITextField * acceptedNumberTextField;
    UITextField * IDNumberTextField;

}
@property (nonatomic,strong)HYSegmentedControl * seg;

@end

@implementation OnlineBusinessSearchViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        self.automaticallyAdjustsScrollViewInsets = NO;         //  解决视图偏移  默认YES  这样控制器可以自动调整  设置为NO后即可自己调整
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OnLineSelectResult:) name:@"OnLineSelectResult" object:nil];
        
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = self.titleLabel;
        self.titleLabel.text = appDelegate.title;
        self.segArray = [NSMutableArray arrayWithObjects:appDelegate.sonTitle, nil];
        [self createSegmentedControl];
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, UISCREENWIDTH, 30)];
        title.text = @"市政务服务中心最新办结未取件通知";
        title.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:title];
        
        UILabel * acceptedNumber = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/13, 160, UISCREENWIDTH/3, 30)];
        acceptedNumber.text = @"按受理号:";
        [self.view addSubview:acceptedNumber];
        
        UILabel * IDNumber = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH/13, 200, UISCREENWIDTH/3, 30)];
        IDNumber.text = @"按身份证号码:";
        [self.view addSubview:IDNumber];
        
        acceptedNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(UISCREENWIDTH/3+25, 160, UISCREENWIDTH/2, 30)];
        acceptedNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
        acceptedNumberTextField.placeholder = @"受理号";
        acceptedNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        acceptedNumberTextField.textAlignment = NSTextAlignmentLeft;
        acceptedNumberTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        acceptedNumberTextField.returnKeyType =UIReturnKeyDone;
        acceptedNumberTextField.keyboardAppearance=UIKeyboardAppearanceDefault;
        acceptedNumberTextField.delegate = self;
        [self.view addSubview:acceptedNumberTextField];
        
        IDNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(UISCREENWIDTH/3+25, 200, UISCREENWIDTH/2, 30)];
        IDNumberTextField.borderStyle = UITextBorderStyleRoundedRect;
        IDNumberTextField.placeholder = @"身份证号";
        IDNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        IDNumberTextField.textAlignment = NSTextAlignmentLeft;
        IDNumberTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        IDNumberTextField.returnKeyType =UIReturnKeyDone;
        IDNumberTextField.keyboardAppearance=UIKeyboardAppearanceDefault;
        IDNumberTextField.delegate = self;
        [self.view addSubview:IDNumberTextField];

        UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        searchBtn.frame = CGRectMake(0, 0, UISCREENWIDTH/3, 40);
        searchBtn.center = CGPointMake(UISCREENWIDTH/2, UISCREENHEIGHT/2+50);
        searchBtn.backgroundColor = UIColorFromRGBValue(0xf24300);
        //绘制圆角矩形按钮和边线
        [searchBtn.layer setMasksToBounds:YES];
        [searchBtn.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
        [searchBtn.layer setBorderWidth:1.0];   //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 242/255.0, 67/255.0, 0, 1 });
        [searchBtn.layer setBorderColor:colorref];//边框颜色
        [searchBtn setTitle:@"确定" forState:UIControlStateNormal] ;
        [searchBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        searchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:searchBtn];
        
        
        
    }
    return self;
}

- (void)search{
    if (![acceptedNumberTextField.text isEqual:@""]) {
        
    }
}

- (void)OnLineSelectResult:(NSNotification * )note{
#warning    等服务端改用webview显示在线办事查询结果
}

- (void)createSegmentedControl
{
    self.seg = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:self.segArray delegate:self] ;
    self.seg.frame = CGRectMake(0, NAVIGATIONHIGHT, self.view.frame.size.width, HYSegmentedControl_Height);
    [self.view addSubview:self.seg];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //没数据。。。
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
