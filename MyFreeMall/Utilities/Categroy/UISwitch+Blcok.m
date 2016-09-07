//
//  UISwitch+Blcok.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/5.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "UISwitch+Blcok.h"
#import <objc/runtime.h>

static char kActionKey;

@implementation UISwitch (Block)
- (void)handleWithBlock:(MFButtonActionBlock)actionBlock controlEvent:(UIControlEvents)controlEvent{
    
    objc_setAssociatedObject(self, &kActionKey, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:controlEvent];
    
}

- (void)callActionBlock:(id)sender{
    
    MFButtonActionBlock block = (MFButtonActionBlock)objc_getAssociatedObject(self, &kActionKey);
    if (block) {
        block(self);
    }
}

@end
