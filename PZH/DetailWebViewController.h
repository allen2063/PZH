//
//  DetailWebViewController.h
//  PZH
//
//  Created by ZengYifei on 15/7/6.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HYSegmentedControl.h"

@interface DetailWebViewController : UIViewController<UIWebViewDelegate>
@property (strong,nonatomic)UIWebView * webView;
@property (strong,nonatomic)HYSegmentedControl * seg;
@property (strong,nonatomic)NSMutableArray * segArray;
@property (strong,nonatomic)AppDelegate * appDelegate;
@property (strong,nonatomic)UILabel * titleLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithURL:(NSURL *)url andSegArray:(NSMutableArray *)segArray;

@end
