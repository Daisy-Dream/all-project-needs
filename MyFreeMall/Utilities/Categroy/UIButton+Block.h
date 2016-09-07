//
//  UIButton+Block.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/5.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MFButtonActionBlock)(id sender);

@interface UIButton (Block)

/**
 *  处理事件
 *
 *  @param actionBlock  事件回调
 *  @param controlEvent 事件类型
 */
- (void)handleWithBlock:(MFButtonActionBlock)actionBlock controlEvent:(UIControlEvents)controlEvent;

/**
 *  扩大 UIButton 的点击范围
 *  上下左右需要延伸的范围
 *
 *  @param top    <#top description#>
 *  @param right  <#right description#>
 *  @param bottom <#bottom description#>
 *  @param left   <#left description#>
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;
@end
