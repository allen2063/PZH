//
//  AppDelegate.h
//  PZH
//
//  Created by ZengYifei on 15/6/30.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionAPI.h"
#import "VDLViewController.h"
#import "VDLPlaybackViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ConnectionAPI * conAPI;
@property (strong, nonatomic) VDLViewController * videoPlayer;
@property (strong, nonatomic) VDLPlaybackViewController * superVideoPlayer;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * parentTitle;
@property (strong, nonatomic) NSString * sonTitle;
@property (strong, nonatomic) NSString * grandsonTitle;
@property BOOL writePicFinished;


@property (nonatomic) NSInteger touchedSegBtnTag;
@property (nonatomic) int currentPageNumber;
- (void)playStreamFromURL:(NSURL *)url;
@end

