//
//  UIGestureRecognizer+Block.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/5.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureRecognizerBlock)(id sender);

@interface UIGestureRecognizer (Block)

- (void)handleRecognizerBlock:(GestureRecognizerBlock)actionBlock;
@end
