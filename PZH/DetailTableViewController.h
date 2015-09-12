//
//  DetailTableViewController.h
//  PZH
//
//  Created by ZengYifei on 15/8/5.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)UITableView * tableViews;
@property (strong,nonatomic)NSMutableArray * dataList;
@property (strong,nonatomic)NSMutableArray * segArray;

@end
