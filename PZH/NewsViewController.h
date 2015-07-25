//
//  NewsViewController.h
//  PZH
//
//  Created by ZengYifei on 15/7/25.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, eRefreshType){
    eRefreshTypeDefine=0,
    eRefreshTypeProgress=1
};
@interface NewsViewController : UIViewController
@property (nonatomic,assign)eRefreshType type;
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)NSMutableArray * segArray;
@property (strong,nonatomic)NSMutableArray * tempArray;
@property (strong,nonatomic)NSString * currentSegTitle;
@end
