//
//  MainViewController.h
//  PZH
//
//  Created by ZengYifei on 15/6/30.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "IntoPZHViewController.h"
@interface MainViewController : UIViewController<UIWebViewDelegate>
@property (strong,nonatomic)UIButton * testBtn;
@property (strong,nonatomic)UIButton * intoPZHBtn;
@property (strong,nonatomic)AppDelegate * appDelegate;
@property (strong,nonatomic)UIWebView * webView;

@property (strong,nonatomic)IntoPZHViewController * intoPZH;
@end
