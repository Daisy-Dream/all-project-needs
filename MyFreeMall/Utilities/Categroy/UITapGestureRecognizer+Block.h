//
//  UITapGestureRecognizer+Block.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/5.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapGestureRecognizer (Block)

typedef void (^TapGestureRecognizerBlock)(id sender);

- (void)handleWithBlock:(TapGestureRecognizerBlock)actionBlock;
@end
