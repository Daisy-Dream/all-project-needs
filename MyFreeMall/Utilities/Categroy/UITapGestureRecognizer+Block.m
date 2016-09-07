//
//  UITapGestureRecognizer+Block.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/5.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "UITapGestureRecognizer+Block.h"
#import <objc/runtime.h>
@implementation UITapGestureRecognizer (Block)

static char kTapGestureRecognizerKey;

- (void)handleWithBlock:(TapGestureRecognizerBlock)actionBlock{
    objc_setAssociatedObject(self, &kTapGestureRecognizerKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callTapGestureRecognizerBlock:)];
    
}

- (void)callTapGestureRecognizerBlock:(id)sender{
    
    TapGestureRecognizerBlock blcok = (TapGestureRecognizerBlock)objc_getAssociatedObject(self, &kTapGestureRecognizerKey);
    if (blcok) {
        blcok(self);
    }
}
@end
