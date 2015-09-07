//
//  FirstTableVIewViewController.h
//  PZH
//
//  Created by ZengYifei on 15/8/6.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableVIewViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)UITableView * tableViews;
@property (strong,nonatomic)NSMutableArray * dataList;
@property (strong,nonatomic)NSMutableArray * heardDataList;

@property (strong,nonatomic)NSMutableArray * segArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil AndTagNumber:(NSInteger)tag AndSegArray:(NSMutableArray *)segArrays;
@end
