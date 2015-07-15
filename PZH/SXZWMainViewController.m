//
//  SXZWMainViewController.m
//  CustomSegControlView
//
//  Created by sxzw on 14-6-12.
//  Copyright (c) 2014年 sxzw. All rights reserved.
//

#import "SXZWMainViewController.h"
#import "HYSegmentedControl.h"
#import "CustomScrollView.h"
@interface SXZWMainViewController ()//<HYSegmentedControlDelegate>
@property (strong, nonatomic)UITextField *tf;
@property (strong, nonatomic)HYSegmentedControl *segmentedControl;
@end

@implementation SXZWMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.navigationController.hidesBarsOnTap=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.view.frame = CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64);
    self.view.backgroundColor = [UIColor grayColor];
    [self createSegmentedControl];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(.0f, 144.0f, 320.0f, 35.0f)];
    lbl.text = @"当前选择的下标";
    //[self.view addSubview:lbl];
    self.tf = [[UITextField alloc] initWithFrame:CGRectMake(.0f, 174.0f, 320.0f, 30.0f)];
    self.tf.backgroundColor = [UIColor whiteColor];
    self.tf.borderStyle = UITextBorderStyleRoundedRect;
    self.tf.keyboardType = UIKeyboardTypeNumberPad;
    self.tf.text = @"0";
    //[self.view addSubview:self.tf];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(130.0f, 174.0f, 60.0f, 80.0f);
    [btn setTitle:@"切换" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeIndex) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self.tf becomeFirstResponder];
    
}

//
//  切换
//
- (void)changeIndex
{
    NSInteger index = [self.tf.text integerValue];
    [self.segmentedControl changeSegmentedControlWithIndex:index];
}

//
//  init SegmentedControl
//
- (void)createSegmentedControl
{
    self.segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"上线时间", @"人气排行", @"为您推荐", @"猜您喜欢", @"最多评价", @"上线时间", @"人气排行", @"为您推荐", @"猜您喜欢", @"最多评价"] delegate:self] ;
    self.segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    self.segmentedControl.center = CGPointMake(self.view.frame.size.width/2, 164+15);
    [self.view addSubview:_segmentedControl];
}

//
//  HYSegmentedControlDelegate method
//
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
    self.tf.text = [NSString stringWithFormat:@"%d",index];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
