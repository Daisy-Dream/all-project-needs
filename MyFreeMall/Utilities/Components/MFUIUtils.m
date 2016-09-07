//
//  MFUIUtils.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/6.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFUIUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>

/**
 *  圆角蒙版Image 缓存
 */
@interface roundMarkCacheKey : NSObject
@property (nonatomic, assign)CGSize size;
@property (nonatomic, assign)CGFloat radius;
@property (nonatomic, strong)UIColor *color;
@property (nonatomic, strong)UIImage *image;
@end
@implementation roundMarkCacheKey
@end

/**
 *  用于拉伸的UIImage图 缓存
 */
@interface lineImageCacheKey : NSObject
@property (nonatomic, assign)BOOL isVertical;
@property (nonatomic, assign)BOOL isFirstPixelOpaque;
@property (nonatomic, strong)UIColor *highlightColor;
@property (nonatomic, strong)UIImage *image;
@end
@implementation lineImageCacheKey
@end

@implementation MFUIUtils


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
{
    static NSMutableArray *cacheArray = nil;
    
    UIImage *retImage = nil;
    lineImageCacheKey *cacheKey = nil;
    
    if(cacheArray) cacheArray = [NSMutableArray new];
    
    for(lineImageCacheKey *tmp in cacheArray)
    {
        if((tmp.isVertical == isVertical) &&
           (tmp.highlightColor == highlightColor) &&
           (tmp.isFirstPixelOpaque == isFirstOpaque))
        {
            cacheKey = tmp;
            break;
        }
    }
    
    if(!cacheKey)
    {
        CGSize vSize = isVertical?(CGSize){2, 1}:(CGSize){1, 2};
        
        UIGraphicsBeginImageContext(vSize);
        
        //创建路径并获取句柄
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGFloat leftMargin = isVertical&&!isFirstOpaque ? 1:0;
        CGFloat topMargin = !isVertical&&!isFirstOpaque ? 1:0;
        
        //指定矩形
        CGRect rectangle = (CGRect){leftMargin,topMargin, 1, 1};
        
        //将矩形添加到路径中
        CGPathAddRect(path,NULL, rectangle);
        
        //获取上下文
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        
        //将路径添加到上下文
        CGContextAddPath(currentContext,path);
        
        //设置矩形填充色
        [highlightColor setFill];
        
        //矩形边框颜色
        [[UIColor clearColor] setStroke];
        
        //绘制
        CGContextDrawPath(currentContext,kCGPathFillStroke);
        
        CGPathRelease(path);
        
        retImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        cacheKey = [lineImageCacheKey new];
        cacheKey.isVertical = isVertical;
        cacheKey.isFirstPixelOpaque = isFirstOpaque;
        cacheKey.highlightColor = highlightColor;
        cacheKey.image = retImage;
        
        [cacheArray addObject:cacheKey];
    }
    else
    {
        retImage = cacheKey.image;
    }
    
    return retImage;
}



+ (CAShapeLayer *)makeShapelayerWithRoundingCorners:(UIRectCorner)corners
                                            forView:(UIView*)view
                                   withCornerRadius:(CGFloat)radius
{
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                      byRoundingCorners:corners
                                                            cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *corBoundmaskLayer = [CAShapeLayer layer];
    corBoundmaskLayer.frame         = view.bounds;
    corBoundmaskLayer.path          = bezierPath.CGPath;
    
    return corBoundmaskLayer;
}



+ (void)setRoundingCorners:(UIView *)view withCornerRadius:(CGFloat)radius
{
    CAShapeLayer *maskLayer = [MFUIUtils makeShapelayerWithRoundingCorners:UIRectCornerAllCorners
                                                                    forView:view
                                                           withCornerRadius:radius];
    
    view.layer.mask = maskLayer;
}


+ (void)setTopRoundingCorners:(UIView *)view withCornerRadius:(CGFloat)radius
{
    CAShapeLayer *maskLayer = [MFUIUtils makeShapelayerWithRoundingCorners:(UIRectCornerTopLeft|
                                                                             UIRectCornerTopRight)
                                                                    forView:view
                                                           withCornerRadius:radius];
    view.layer.mask = maskLayer;
}

+ (void)setBottomRoundingCorners:(UIView *)view withCornerRadius:(CGFloat)radius
{
    CAShapeLayer *maskLayer = [MFUIUtils makeShapelayerWithRoundingCorners:(UIRectCornerBottomLeft|
                                                                             UIRectCornerBottomRight)
                                                                    forView:view
                                                           withCornerRadius:radius];
    view.layer.mask = maskLayer;
}

+ (void)setLeftRoundingCorners:(UIView *)view withCornerRadius:(CGFloat)radius
{
    CAShapeLayer *maskLayer = [MFUIUtils makeShapelayerWithRoundingCorners:(UIRectCornerTopLeft|
                                                                             UIRectCornerBottomLeft)
                                                                    forView:view
                                                           withCornerRadius:radius];
    
    view.layer.mask = maskLayer;
}

+ (void)setRightRoundingCorners:(UIView *)view withCornerRadius:(CGFloat)radius
{
    CAShapeLayer *maskLayer = [MFUIUtils makeShapelayerWithRoundingCorners:(UIRectCornerTopRight  |
                                                                             UIRectCornerBottomRight)
                                                                    forView:view
                                                           withCornerRadius:radius];
    view.layer.mask = maskLayer;
}



@end
