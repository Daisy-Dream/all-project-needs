//
//  NSArray+safe.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/1.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "NSArray+safe.h"

@implementation NSArray (safe)
/**
 *  安全读取数组数据
 *
 *  @param index 索引
 *
 *  @return 数据
 */
- (id)safeObjectAtIndex:(NSUInteger)index
{
    if ( index >= self.count )
        return nil;
    
    return [self objectAtIndex:index];
}
@end
