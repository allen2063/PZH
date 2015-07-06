//
//  VideoForPZHViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "VideoForPZHViewController.h"
#import "AppDelegate.h"
@interface VideoForPZHViewController ()

@end

@implementation VideoForPZHViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"视频攀枝花";
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
    
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}

-(void)jumpPage:(UIButton *)btn{    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate playStreamFromURL:[NSURL URLWithString:@"http://www.panzhihua.gov.cn/images/zjpzh/yxpzh/sppzh/xxp/2323.wmv"]];
    
//    VideoPlayerViewController * videoPlayer = [[VideoPlayerViewController alloc]init];
//    UINavigationController *presNavigation = [[UINavigationController alloc] initWithRootViewController: videoPlayer];
//    [self.navigationController presentViewController:presNavigation animated:YES completion:nil];
//    //[self.navigationController pushViewController:videoPlayer animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton * vedioBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    vedioBtn.backgroundColor = [UIColor lightGrayColor];
    vedioBtn.frame = CGRectMake(40,300,240,120);
    [vedioBtn setTitle:@"视频攀枝花" forState:UIControlStateNormal];
    [vedioBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vedioBtn];
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
