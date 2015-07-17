//
//  PicForPZHViewController.h
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYSegmentedControl.h"
#import "EGORefreshTableHeaderView.h"

@interface PicForPZHViewController : UIViewController<UIWebViewDelegate,UIScrollViewDelegate,EGORefreshTableHeaderDelegate>{
    //下拉视图
    EGORefreshTableHeaderView * _refreshHeaderView;
    EGORefreshTableHeaderView * _refreshBottomView;

    //刷新标识，是否正在刷新过程中
    BOOL _reloading;
}
@property (strong,nonatomic)UILabel * titleLabel;
@property (strong,nonatomic)HYSegmentedControl * seg;
@property (strong,nonatomic)NSMutableArray * segArray;
@property (strong,nonatomic)UIWebView * webView;

@end
