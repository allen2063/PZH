//
//  PubiicServiceScrollviewViewController.h
//  PZH
//
//  Created by ZengYifei on 15/8/6.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, eRefreshType){
    eRefreshTypeDefine=0,
    eRefreshTypeProgress=1
};
@interface PubiicServiceTableViewViewController : UIViewController
@property (nonatomic,assign)eRefreshType type;
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)NSMutableArray * segArray;
@property (strong,nonatomic)NSMutableArray * tempArray;
@end
