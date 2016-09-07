//
//  MFUIUtils.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/6.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFUIUtils : NSObject


/**
 *  生成用于拉伸的UIImage图 (2x1 Or 1*2)像素永久保存内存
 *
 *  @param isVertical      是否垂直拉伸
 *  @param isFirstOpaque   是否第一像素不透明
 *  @param highlightColor  显示的颜色
 *	@param isHighlightLeft 颜色是否显示在左边(横向拉伸时，是否现在在上面)
 *
 *  @return image
 */
+ (UIImage *)getLineImageWithIsVertical:(BOOL)isVertical
                     isFirstPixelOpaque:(BOOL)isFirstOpaque
                         highlightColor:(UIColor *)highlightColor;


/**
 *  @brief  设置 View 圆角
 *
 *  @param view   要设置的View
 *  @param radius 圆角半径
 */
+ (void)setRoundingCorners:(UIView *)view withCornerRadius:(CGFloat)radius;


/**
 *  @brief  设置 View 两上角为圆角
 *
 *  @param view   要设置的View
 *  @param radius 圆角半径
 */
+ (void)setTopRoundingCorners:(UIView *)view withCornerRadius:(CGFloat)radius;

/**
 *  @brief  设置 View 两下角为圆角
 *
 *  @param view   要设置的View
 *  @param radius 圆角半径
 */
+ (void)setBottomRoundingCorners:(UIView *)view withCornerRadius:(CGFloat)radius;

/**
 *  @brief  设置 View 左边两角为圆角
 *
 *  @param view   要设置的View
 *  @param radius 圆角半径
 */
+ (void)setLeftRoundingCorners:(UIView *)view withCornerRadius:(CGFloat)radius;

/**
 *  @brief  设置 View 右边边两角为圆角
 *
 *  @param view   要设置的View
 *  @param radius 圆角半径
 */
+ (void)setRightRoundingCorners:(UIView *)view withCornerRadius:(CGFloat)radius;


@end
