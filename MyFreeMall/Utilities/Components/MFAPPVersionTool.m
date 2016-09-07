//
//  MFAPPVersionTool.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/2.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFAPPVersionTool.h"

@implementation MFAPPVersionTool
// 获取保存的上一个版本信息
+ (NSString *)savedAppVersion {
    
    return [[NSUserDefaults standardUserDefaults] stringForKey:MFVersionKey];
}

// 保存新版本信息（偏好设置）
+ (void)saveNewAppVersion:(NSString *)version {
    
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:MFVersionKey];
}

/** appstore 获取版本 */
- (void)appleAppVersionUpdate{
    
    NSString *urlString     = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=1118625945"];
    NSURL *url              = [[NSURL alloc] initWithString:urlString];
    NSURLRequest *request   = [[NSURLRequest alloc] initWithURL:url];
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *appDictionary=[NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingMutableLeaves error:nil];
            if (appDictionary) {
                [self appVersionUpdate:appDictionary];
            }
        }
    }];
}
/**
 *  判断版本是否更新
 *
 *  @param appDictionary AppStore传回信息
 */
- (void)appVersionUpdate:(NSDictionary *)appDictionary
{
    NSArray *results                   = [appDictionary objectForKey:@"results"];
    NSDictionary *appInfo              = [results objectAtIndex:0];
    NSString *appversion               = [appInfo objectForKey:@"version"];
    NSString *APPVisionURL             = [appInfo objectForKey:@"trackViewUrl"];
    //本地
    NSDictionary *localeInfoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion           = [localeInfoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    if (appversion
        && ![appversion isEqualToString:@""]
        && currentVersion
        && ![currentVersion isEqualToString:@""]) {
        /** 有新版本 */
        if ([appversion compare:currentVersion] == NSOrderedDescending) {
            
            NSString *msg = [appInfo objectForKey:@"releaseNotes"];
            if ([msg isEqualToString:@""]) msg = @"发现新版本";
            /** 提示 */
            UIAlertView *alertView = [UIAlertView alertViewWithTitle:[NSString stringWithFormat:@"有新版本啦(%@)",appversion]
                                                   cancelButtonTitle:@"立即升级"
                                                             message:msg
                                                   otherButtonTitles:@"取消"
                                                               block:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                                   if (buttonIndex==0) {
                                                                       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APPVisionURL]];
                                                                   }
                                                               }];
            [alertView show];
            
        }else if ([appversion compare:currentVersion] == NSOrderedAscending){
            MFLog(@"服务器的版本比较小");
            MFLog(@"\nversionServer:%@\nversion:%@",appversion,currentVersion);
        }else{
            MFLog(@"it same");
        }
    }
}

@end
