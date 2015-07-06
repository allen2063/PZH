//
//  IntoPZHViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "IntoPZHViewController.h"
#import "PicForPZHViewController.h"
#import "VideoForPZHViewController.h"
#import "AppDelegate.h"
@interface IntoPZHViewController ()

@end

@implementation IntoPZHViewController
@synthesize videoForPZHBtn,picForPZHBtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"走进攀枝花";
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        
        self.picForPZHBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.picForPZHBtn.backgroundColor = [UIColor lightGrayColor];
        self.picForPZHBtn.frame = CGRectMake(40,400,120,60);
        [self.picForPZHBtn setTitle:@"图看攀枝花" forState:UIControlStateNormal];
        [self.picForPZHBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        self.picForPZHBtn.tag = 1;
        
        self.videoForPZHBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.videoForPZHBtn.backgroundColor = [UIColor lightGrayColor];
        self.videoForPZHBtn.frame = CGRectMake(180,400,120,60);
        [self.videoForPZHBtn setTitle:@"视频攀枝花" forState:UIControlStateNormal];
        [self.videoForPZHBtn addTarget:self action:@selector(jumpPage:) forControlEvents:UIControlEventTouchUpInside];
        self.videoForPZHBtn.tag = 2;
        
        [self.view addSubview:self.picForPZHBtn];
        [self.view addSubview:self.videoForPZHBtn];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)jumpPage:(UIButton *)btn{
    PicForPZHViewController * picForPZH = [[PicForPZHViewController alloc]init];
    VideoForPZHViewController * videoForPZH = [[VideoForPZHViewController alloc]init];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    switch (btn.tag) {
        case 1:
            [self.navigationController pushViewController:picForPZH animated:YES];
            //[appDelegate playStreamFromURL:[NSURL URLWithString:@"http://www.panzhihua.gov.cn/images/zjpzh/yxpzh/sppzh/xxp/2323.wmv"]];
            
                        break;
        case 2:
            [self.navigationController pushViewController:videoForPZH animated:YES];
            //[appDelegate playStreamFromURL:[NSURL URLWithString:@"http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4"]];
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
