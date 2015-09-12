//
//  CustomTableViewCell.m
//  PZH
//
//  Created by ZengYifei on 15/7/27.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
@synthesize timeLabel,titleLabel,accessoryTextLabel;
- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, 70);
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.frame.size.width-15, self.frame.size.height*2/3)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = UIColorFromRGBValue(0x333333);
        self.titleLabel.numberOfLines = 2;
        [self addSubview:self.titleLabel];

        self.accessoryTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, self.frame.size.height*2/3, self.frame.size.width/2+20, self.frame.size.height/3)];
        self.accessoryTextLabel.backgroundColor = [UIColor clearColor];
        self.accessoryTextLabel.font = [UIFont systemFontOfSize:14];
        self.accessoryTextLabel.textColor = UIColorFromRGBValue(0x9e9e9e);
        self.accessoryTextLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.accessoryTextLabel];

        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*2/3, self.frame.size.height*2/3, self.frame.size.width/3, self.frame.size.height/3)];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textColor = UIColorFromRGBValue(0x9e9e9e);
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timeLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetailTextLabelFrame:(CGRect )frame{
    self.detailTextLabel.frame = frame;
}

- (void)setDetaileTextFont:(UIFont *)font{
    self.detailTextLabel.font = font;
}

- (void)setCellHeight:(CGFloat )height{
    self.frame = CGRectMake(0, 0, 320, height);
}

//- (void)setTextFrame:(CGRect)frame{
//    self.textLabel
//}

@end
