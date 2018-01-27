//
//  AppDelegate.m
//  Novel
//
//  Created by th on 2017/1/31.
//  Copyright © 2017年 th. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationViewController.h"
#import "XXMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _statusBarHeight = STATUS_BAR_HEIGHT;
    
    // 设置状态栏样式
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    application.statusBarHidden = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    //创建导航控制器
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:[[XXMainViewController alloc] init]];
    
    nav.fd_fullscreenPopGestureRecognizer.enabled = YES;
    
    //设置窗口的根控制器
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    [self setupRequest];
    
    [kTool networkStatusWithBlock:^(HttpStatusType status) {
        
    }];
    
    return YES;
}

- (void)setupRequest {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = SERVERCE_HOST;
    config.cdnUrl = chapter_URL;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    ReadingManager *manager = [ReadingManager shareReadingManager];
    
    if (manager.isSave) {
        [SQLiteTool updateWithTableName: manager.bookId dict:@{@"chapter": @(manager.chapter), @"page": @(manager.page), @"status": @"0"}];
    }
    NSLog(@"----退出程序");
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return self.window.rootViewController.supportedInterfaceOrientations;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
