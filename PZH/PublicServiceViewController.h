//
//  PublicServiceViewController.h
//  PZH
//
//  Created by ZengYifei on 15/8/6.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicServiceViewController : UIViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil WithPicArray:(NSMutableArray *)picArray andTitleArray:(NSMutableArray *)titleArray;
@property (strong,nonatomic)UILabel * titleLabel;
@end
