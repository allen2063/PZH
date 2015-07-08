//
//  CustomScrollView.h
//  PZH
//
//  Created by ZengYifei on 15/7/7.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollView : UIView
@property (strong,nonatomic)UIScrollView * scr;
//初始化函数
- (id)initWithOriginY:(CGFloat)y Titles:(NSArray *)titles delegate:(id)delegate;
//提供方法改变 index
- (void)changeSegmentedControlWithIndex:(NSInteger)index;
@end
