//
//  AppDelegate.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "EasyShowOptions.h"

#import "EasyShowTextGlobalConfig.h"
#import "EasyShowLodingGlobalConfig.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  
    EasyShowOptions *options = [EasyShowOptions sharedEasyShowOptions];
    options.textSuperViewReceiveEvent = YES ;
    options.textAnimationType = TextAnimationTypeBounce ;
    options.textBackGroundColor = [UIColor whiteColor];
    options.textTitleColor = [UIColor blackColor];
    options.textShadowColor =[UIColor redColor];
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:7];
    for (int i = 0; i < 9 ; i++) {
        NSString *tempString = [NSString stringWithFormat:@"icon_hud_%zd",i+1];
        [tempArray addObject:[UIImage imageNamed:tempString]];
    }
    options.lodingPlayImagesArray = [NSArray arrayWithArray:tempArray ];
    options.lodingSuperViewReceiveEvent = YES ;
    
    
    
    
    EasyShowTextGlobalConfig *config = [EasyShowTextGlobalConfig shared];
    config.bgColor = [UIColor whiteColor];
    config.textShowTimeBlock = ^float(NSString *text) {
        
        CGFloat tempShowTime = 0 ;
        tempShowTime = 1 + text.length*0.15 ;
        if (tempShowTime > TextShowMaxTime) {
            tempShowTime = TextShowMaxTime ;
        }
        if (tempShowTime < 2) {
            tempShowTime = 2 ;
        }
        return tempShowTime ;
    };
    
    
//    EasyShowLodingGlobalConfig *lodingConfig = [EasyShowLodingGlobalConfig sharedEasyShowLodingGlobalConfig];
//    lodingConfig.lodingSuperViewReceiveEvent = YES ;
    
    
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    self.window.rootViewController = nav ;
    
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
