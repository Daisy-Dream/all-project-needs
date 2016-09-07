//
//  AppDelegate.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/1.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "AppDelegate.h"
#import "MFTabBarController.h"
#import "MFAPPVersionTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /** 设置窗口 */
    [self setUpWindow];
    /** 检测版本更新 */
    [[[MFAPPVersionTool alloc] init] appleAppVersionUpdate];
#ifdef DEBUG
    /** 捕捉异常 */
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
#else
    
#endif
    return YES;
}

/** 设置窗口 */
- (void)setUpWindow{
    
    self.window                    = [[UIWindow alloc] init];
    self.window.frame              = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [[MFTabBarController alloc] init];
    [self.window makeKeyAndVisible];
}

#pragma mark - 异常捕捉
/** 设置一个C函数，用来接收崩溃信息，发送至指定邮箱 */
void UncaughtExceptionHandler(NSException *exception){

    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name   = [exception name];
    NSString *urlStr = [NSString stringWithFormat:@"mailto://boundlessocean@icloud.com?&body=感谢您的配合!\n"
                        "错误详情:\n%@\n--------------------------\n%@\n--------------------------\n%@",
                        name,
                        reason,
                        [symbols componentsJoinedByString:@"\n"]];
    NSURL *url       = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
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
