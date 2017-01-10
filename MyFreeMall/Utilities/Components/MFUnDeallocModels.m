//
//  MFUnDeallocModels.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/7.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFUnDeallocModels.h"

@implementation MFUnDeallocModels
singleM(MFUnDeallocModels)
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
        if ([[MFUnDeallocModels shareMFUnDeallocModels].unDealocModels isKindOfClass:[NSMutableArray class]]) {
            [[MFUnDeallocModels shareMFUnDeallocModels].unDealocModels addObject:controllerName];
        } else {
            [MFUnDeallocModels shareMFUnDeallocModels].unDealocModels = [NSMutableArray arrayWithArray:[MFUnDeallocModels shareMFUnDeallocModels].unDealocModels];
            [[MFUnDeallocModels shareMFUnDeallocModels].unDealocModels addObject:controllerName];
        }
    }
}

- (void)deallocControllerName:(NSString *)controllerName andFloor:(NSInteger)num
{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[MFUnDeallocModels shareMFUnDeallocModels].unDealocModels];
    for (NSString *ctlString in tempArray) {
        if ([ctlString isEqualToString:controllerName]) {
            NSInteger ctlIndex = [tempArray indexOfObjectIdenticalTo:ctlString];
            if ([[MFUnDeallocModels shareMFUnDeallocModels].unDealocModels isKindOfClass:[NSMutableArray class]]) {
                [[MFUnDeallocModels shareMFUnDeallocModels].unDealocModels removeObjectAtIndex:ctlIndex];
            } else {
                [MFUnDeallocModels shareMFUnDeallocModels].unDealocModels = [NSMutableArray arrayWithArray:[MFUnDeallocModels shareMFUnDeallocModels].unDealocModels];
                [[MFUnDeallocModels shareMFUnDeallocModels].unDealocModels removeObjectAtIndex:ctlIndex];
            }
            break;
        }
    }
    if ([MFUnDeallocModels shareMFUnDeallocModels].unDealocModels.count > 0) {
        if (num == 1) {
            //回到首层打印泄露
            MFLog(@"内存泄露对象: %@",[MFUnDeallocModels shareMFUnDeallocModels].unDealocModels);
        }
    }
}
@end
