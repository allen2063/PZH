//
//  OnlineBusinessSearchViewController.h
//  PZH
//
//  Created by ZengYifei on 15/7/29.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineBusinessSearchViewController : UIViewController<UITextFieldDelegate>
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)NSMutableArray * segArray;
@end