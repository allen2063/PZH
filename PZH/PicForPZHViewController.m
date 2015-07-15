//
//  PicForPZHViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "PicForPZHViewController.h"
#import "DetailWebViewController.h"
@interface PicForPZHViewController ()

@end

@implementation PicForPZHViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"图看攀枝花";
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        UIButton * testBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        testBtn.frame = CGRectMake(100,100,70,40);
        [testBtn setTitle:@"test autoLayout!" forState:UIControlStateNormal];
        [testBtn addTarget:self action:@selector(jumpPageForPicForPZH) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:testBtn];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)jumpPageForPicForPZH{
    NSMutableArray * arr = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",nil];
    DetailWebViewController * testWeb = [[DetailWebViewController alloc]initWithNibName:nil bundle:nil WithURL:nil andSegArray:arr];
    //[testWeb.segArray addObjectsFromArray:[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil]];
    [self.navigationController pushViewController:testWeb animated:YES];
    //    VideoPlayerViewController * videoPlayer = [[VideoPlayerViewController alloc]init];
    //    UINavigationController *presNavigation = [[UINavigationController alloc] initWithRootViewController: videoPlayer];
    //    [self.navigationController presentViewController:presNavigation animated:YES completion:nil];
    //    //[self.navigationController pushViewController:videoPlayer animated:YES];
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
