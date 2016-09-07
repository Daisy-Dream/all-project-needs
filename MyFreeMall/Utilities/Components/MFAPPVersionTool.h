//
//  MFAPPVersionTool.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/2.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFAPPVersionTool : NSObject

/** 之前保存的版本 */
+ (NSString *)savedAppVersion;

/** 保存新版本 */
+ (void)saveNewAppVersion:(NSString *)version;

/** 检测版本更新 */
- (void)appleAppVersionUpdate;
@end
