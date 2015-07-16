//
//  PicForPZHViewController.h
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
@interface PicForPZHViewController : UIViewController<UIWebViewDelegate>
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)HYSegmentedControl * seg;
@property (strong,nonatomic)NSMutableArray * segArray;
@property (strong,nonatomic)UIWebView * webView;

@end
