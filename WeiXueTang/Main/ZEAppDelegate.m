//
//  AppDelegate.m
//  NewCentury
//
//  Created by Stenson on 16/1/19.
//  Copyright © 2016年  Zenith Electronic Technology Co., Ltd. All rights reserved.
//

#import "ZEAppDelegate.h"
#import "ZEMainViewController.h"
//#import ""
#import "AFNetworkReachabilityManager.h"

@interface ZEAppDelegate ()

@end

@implementation ZEAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    application.applicationSupportsShakeToEdit = YES;

    
    ZEMainViewController * mainVC = [[ZEMainViewController alloc]init];
    mainVC.tabBarItem.image = [UIImage imageNamed:@"tab_homepage_normal"];
    mainVC.tabBarItem.title = @"首页";
    UINavigationController * mainNav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    
    ZEMainViewController * downloadVC = [[ZEMainViewController alloc]init];
    downloadVC.tabBarItem.image = [UIImage imageNamed:@"tab_homepage_normal"];
    downloadVC.tabBarItem.title = @"下载";
    UINavigationController * downloadNav = [[UINavigationController alloc]initWithRootViewController:downloadVC];
    
    ZEMainViewController * settingVC = [[ZEMainViewController alloc]init];
    settingVC.tabBarItem.image = [UIImage imageNamed:@"tab_setting_normal"];
    settingVC.tabBarItem.title = @"设置";
    UINavigationController * settingNav = [[UINavigationController alloc]initWithRootViewController:settingVC];
    
    UITabBarController * tabBarVC = [[UITabBarController alloc]init];
    tabBarVC.viewControllers = @[mainNav,downloadNav,settingNav];
    
//    NSDictionary * userDataDic = [ZESetLocalData getUserData];
//    if (userDataDic.allKeys > 0) {
        self.window.rootViewController = tabBarVC;
//        return YES;
//    }
//    ZELoginViewController * loginVC = [[ZELoginViewController alloc]init];
//    self.window.rootViewController = tabBarVC;
//    self.window.rootViewController = loginVC;
    
    NSLog(@"%@",Zenith_Server);
    NSLog(@"%@",NSHomeDirectory());

    [self _checkNet];
    
    return YES;
}

- (void) _checkNet{
    //开启网络状态监控
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if(status==AFNetworkReachabilityStatusReachableViaWiFi){
            NSLog(@"当前是wifi");
        }
        if(status==AFNetworkReachabilityStatusReachableViaWWAN){
            NSLog(@"当前是3G");
        }
        if(status==AFNetworkReachabilityStatusNotReachable){
            NSLog(@"当前是没有网络");
        }
        if(status==AFNetworkReachabilityStatusUnknown){
            NSLog(@"当前是未知网络");
        }
    }];
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
