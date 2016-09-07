//
//  MFUnDeallocModels.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/7.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFUnDeallocModels.h"

@implementation MFUnDeallocModels
MF_DEF_SINGLETION(MFUnDeallocModels)

- (NSMutableArray *)unDealocModels
{
    if (!_unDealocModels) {
        _unDealocModels = [[NSMutableArray alloc]init];
    }
    return _unDealocModels;
}

- (void)addContrllerName:(NSString *)controllerName andFloor:(NSInteger)num
{
    if (num > 1) {
        //首页不加入
        if ([[MFUnDeallocModels sharedInstance].unDealocModels isKindOfClass:[NSMutableArray class]]) {
            [[MFUnDeallocModels sharedInstance].unDealocModels addObject:controllerName];
        } else {
            [MFUnDeallocModels sharedInstance].unDealocModels = [NSMutableArray arrayWithArray:[MFUnDeallocModels sharedInstance].unDealocModels];
            [[MFUnDeallocModels sharedInstance].unDealocModels addObject:controllerName];
        }
    }
}

- (void)deallocControllerName:(NSString *)controllerName andFloor:(NSInteger)num
{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[MFUnDeallocModels sharedInstance].unDealocModels];
    for (NSString *ctlString in tempArray) {
        if ([ctlString isEqualToString:controllerName]) {
            NSInteger ctlIndex = [tempArray indexOfObjectIdenticalTo:ctlString];
            if ([[MFUnDeallocModels sharedInstance].unDealocModels isKindOfClass:[NSMutableArray class]]) {
                [[MFUnDeallocModels sharedInstance].unDealocModels removeObjectAtIndex:ctlIndex];
            } else {
                [MFUnDeallocModels sharedInstance].unDealocModels = [NSMutableArray arrayWithArray:[MFUnDeallocModels sharedInstance].unDealocModels];
                [[MFUnDeallocModels sharedInstance].unDealocModels removeObjectAtIndex:ctlIndex];
            }
            break;
        }
    }
    if ([MFUnDeallocModels sharedInstance].unDealocModels.count > 0) {
        if (num == 1) {
            //回到首层打印泄露
            MFLog(@"内存泄露对象: %@",[MFUnDeallocModels sharedInstance].unDealocModels);
        }
    }
}
@end
