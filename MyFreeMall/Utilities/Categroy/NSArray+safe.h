//
//  NSArray+safe.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/1.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (safe)
/**
 *  安全读取数组数据
 *
 *  @param index 索引
 *
 *  @return 数据
 */
- (id)safeObjectAtIndex:(NSUInteger)index;
@end
