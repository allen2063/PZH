//
//  CustomTableViewCell.h
//  PZH
//
//  Created by ZengYifei on 15/7/27.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) UILabel * accessoryTextLabel;
@property(nonatomic,strong) UILabel * timeLabel;
- (void)setDetailTextLabelFrame:(CGRect )frame;
- (void)setDetaileTextFont:(UIFont *)font;
@end
