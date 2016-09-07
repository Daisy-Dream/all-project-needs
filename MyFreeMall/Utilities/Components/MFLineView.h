//
//  MFLineView.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/6.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFLineView : UIImageView

/** 画水平线 */
- (id)initWithFrame:(CGRect)frame
              color:(UIColor*)color;

/**
 *  @brief 画线
 *
 *  @param frame      设置线的frame
 *  @param color      线的颜色
 *  @param isVertical 是否垂直
 */
- (id)initWithFrame:(CGRect)frame
              color:(UIColor*)color
           vertical:(BOOL)isVertical;

/**
 *  @brief  贴图显示一像素灰色线段，实际是两像素，一像素透明，一像素特定灰色
 *
 *  @param isVertical       是否是一像素竖线
 *  @param isFirstOpaque    是否第一像素不透明
 */
- (id)initGrayLineWithFrame:(CGRect)frame
                   vertical:(BOOL)isVertical
         isFirstPixelOpaque:(BOOL)isFirstOpaque;


/**
 *  @brief  贴图显示一像素指定颜色线段，实际是两像素，一像素透明，一像素指定颜色
 *
 *  @param isVertical       是否是一像素竖线
 *  @param isFirstOpaque    是否第一像素不透明
 *  @param color            一像素线颜色
 */
- (id)initWithFrame:(CGRect)frame
           vertical:(BOOL)isVertical
 isFirstPixelOpaque:(BOOL)isFirstOpaque
          lineColor:(UIColor *)color;

@end
