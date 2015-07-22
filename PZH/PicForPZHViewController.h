//
//  PicForPZHViewController.h
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicForPZHViewController : UIViewController<UIWebViewDelegate,UIScrollViewDelegate>{
    
}
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)NSMutableArray * segArray;
@property (strong,nonatomic)NSMutableArray * tempArray;
@property (strong,nonatomic)NSString * currentSegTitle;

@end
