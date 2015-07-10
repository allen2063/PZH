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
#import "AdScrollView.h"
#import "AdDataModel.h"
@interface MainViewController : UIViewController<UIWebViewDelegate>{
}
@property (strong,nonatomic)UIButton * intoPZHBtn;
@property (strong,nonatomic)UIButton * openGovernmentAffairsBtn;
@property (strong,nonatomic)UIButton * onlineBusinessBtn;
@property (strong,nonatomic)UIButton * publicServiceBtn;
@property (strong,nonatomic)UIButton * mainNewsBtn;
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)AdScrollView * scrollView;

@property (strong,nonatomic)IntoPZHViewController * intoPZHViewController;
@end
