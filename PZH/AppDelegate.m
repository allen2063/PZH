//
//  AppDelegate.m
//  PZH
//
//  Created by ZengYifei on 15/6/30.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize videoPlayer,title;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:242/255.0 green:67/255.0 blue:0/255.0 alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];    //导航栏按钮颜色

    self.title = [[NSString alloc]init];
    //self.titleLabel.text = @"攀枝花公众信息网";
    MainViewController * mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
    self.conAPI = [[ConnectionAPI alloc]init];
    self.videoPlayer = [[VDLViewController alloc] init];
    UINavigationController * navCon = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    self.window.rootViewController = navCon;
    //mainViewController.navigationItem.titleView = titleLabel;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)playStreamFromURL:(NSURL *)url
{
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:self.videoPlayer];
    navCon.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.window.rootViewController presentViewController:navCon animated:YES completion:nil];
    
    [self.videoPlayer playMediaFromURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
