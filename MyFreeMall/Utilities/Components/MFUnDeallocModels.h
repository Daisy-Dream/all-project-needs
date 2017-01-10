//
//  MFUnDeallocModels.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/7.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFUnDeallocModels : NSObject
singleH(MFUnDeallocModels)

@property (strong, nonatomic) NSMutableArray *unDealocModels;

/** 添加视图名 */
- (void)addContrllerName:(NSString *)controllerName
                andFloor:(NSInteger)num;

/** 移除视图名 */
- (void)deallocControllerName:(NSString *)controllerName
                     andFloor:(NSInteger)num;   

@end
