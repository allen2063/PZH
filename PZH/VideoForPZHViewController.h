//
//  VideoForPZHViewController.h
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
@interface VideoForPZHViewController : UIViewController
@property (strong,nonatomic)NSMutableArray * videoArray;
@property (strong,nonatomic)HYSegmentedControl * seg;
@property (strong,nonatomic)UILabel * titleLabel;

@end

