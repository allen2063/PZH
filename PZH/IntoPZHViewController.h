//
//  IntoPZHViewController.h
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntoPZHViewController : UIViewController{
}
@property (strong,nonatomic)UIButton * picForPZHBtn;
@property (strong,nonatomic)UIButton * videoForPZHBtn;
@property (strong,nonatomic)NSMutableArray * cityOverview;
@property (strong,nonatomic)NSMutableArray * naturalOverview;
@property (strong,nonatomic)NSMutableArray * economyOverview;
@property (strong,nonatomic)UILabel * titleLabel;
@end
