//
//  CustomBtnTableViewCell.m
//  PZH
//
//  Created by ZengYifei on 15/8/4.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "CustomBtnTableViewCell.h"

@implementation CustomBtnTableViewCell
@synthesize guideBtn,commonProblemsBtn,policiesAndRegulationsBtn,formDownloadBtn,consultingAndComplaint,titleLabel;
#define BTNWIDTH ((self.frame.size.width-45)/3)
#define BTNHEIGHT ((self.frame.size.height-15)/3)

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(18, 5, self.frame.size.width, BTNHEIGHT)];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.text = @"计划生育技术服务机构职业审批";
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        //办事指南
        self.guideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.guideBtn.backgroundColor = [UIColor clearColor];
        self.guideBtn.frame = CGRectMake(15, self.frame.size.height/3, BTNWIDTH, BTNHEIGHT);
        [self.guideBtn setTitle:@"办事指南" forState:UIControlStateNormal];
        [self.guideBtn setTitleColor:UIColorFromRGBValue(0x676767)forState:UIControlStateNormal];
        [self.guideBtn setBackgroundImage:[UIImage imageNamed:@"bjan" ] forState:UIControlStateNormal];
        self.guideBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.guideBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.guideBtn];
        //常见问题
        self.commonProblemsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commonProblemsBtn.backgroundColor = [UIColor clearColor];
        self.commonProblemsBtn.frame = CGRectMake(15+5+BTNWIDTH, self.frame.size.height/3, BTNWIDTH, BTNHEIGHT);
        [self.commonProblemsBtn setTitle:@"常见问题" forState:UIControlStateNormal];
        [self.commonProblemsBtn setTitleColor:UIColorFromRGBValue(0x676767)forState:UIControlStateNormal];
        [self.commonProblemsBtn setBackgroundImage:[UIImage imageNamed:@"bjan" ] forState:UIControlStateNormal];
        self.commonProblemsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.commonProblemsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.commonProblemsBtn];
        //表格下载
        self.formDownloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.formDownloadBtn.backgroundColor = [UIColor clearColor];
        self.formDownloadBtn.frame = CGRectMake(15+10+BTNWIDTH*2, self.frame.size.height/3, BTNWIDTH, BTNHEIGHT);
        [self.formDownloadBtn setTitle:@"表格下载" forState:UIControlStateNormal];
        [self.formDownloadBtn setTitleColor:UIColorFromRGBValue(0x676767)forState:UIControlStateNormal];
        [self.formDownloadBtn setBackgroundImage:[UIImage imageNamed:@"bjan" ] forState:UIControlStateNormal];
        self.formDownloadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.formDownloadBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.formDownloadBtn];
        //投诉咨询
        self.consultingAndComplaint = [UIButton buttonWithType:UIButtonTypeCustom];
        self.consultingAndComplaint.backgroundColor = [UIColor clearColor];
        self.consultingAndComplaint.frame = CGRectMake(15, self.frame.size.height*2/3, BTNWIDTH, BTNHEIGHT);
        [self.consultingAndComplaint setTitle:@"投诉咨询" forState:UIControlStateNormal];
        [self.consultingAndComplaint setTitleColor:UIColorFromRGBValue(0x676767)forState:UIControlStateNormal];
        [self.consultingAndComplaint setBackgroundImage:[UIImage imageNamed:@"bjan" ] forState:UIControlStateNormal];
        self.consultingAndComplaint.titleLabel.font = [UIFont systemFontOfSize:14];
        self.consultingAndComplaint.titleLabel.textAlignment = NSTextAlignmentCenter;
        
//        [self.consultingAndComplaint.layer setMasksToBounds:YES];
//        [self.consultingAndComplaint.layer setCornerRadius:10.0]; //设置矩形四个圆角半径
//        [self.consultingAndComplaint.layer setBorderWidth:1.0];   //边框宽度
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 242/255.0, 67/255.0, 0, 1 });
//        [self.consultingAndComplaint.layer setBorderColor:colorref];//边框颜色
        
        [self addSubview:self.consultingAndComplaint];
        //相关政策法规
        self.policiesAndRegulationsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.policiesAndRegulationsBtn.backgroundColor = [UIColor clearColor];
        self.policiesAndRegulationsBtn.frame = CGRectMake(15+5+BTNWIDTH, self.frame.size.height*2/3, BTNWIDTH, BTNHEIGHT);
        [self.policiesAndRegulationsBtn setTitle:@"相关政策法规" forState:UIControlStateNormal];
        [self.policiesAndRegulationsBtn setTitleColor:UIColorFromRGBValue(0x676767)forState:UIControlStateNormal];
        [self.policiesAndRegulationsBtn setBackgroundImage:[UIImage imageNamed:@"bjan" ] forState:UIControlStateNormal];
        self.policiesAndRegulationsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.policiesAndRegulationsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.policiesAndRegulationsBtn];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
