//
//  DetailCellViewController.h
//  PZH
//
//  Created by ZengYifei on 15/8/4.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//CustomCellViewControllerAndEnterpriseAndGreenChannel

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, eRefreshType){
    eRefreshTypeDefine=0,
    eRefreshTypeProgress=1
};
@interface DetailCustomCellViewController : UIViewController

@property (nonatomic,assign)eRefreshType type;
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)NSMutableArray * segArray;
@property (strong,nonatomic)NSMutableArray * tempArray;
@end
