//
//  UIAlertView+Blcok.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/5.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "UIAlertView+Blcok.h"
#import <objc/runtime.h>

static NSString * const UIAlertView_key_clicked = @"UIAlertView_key_clicked";

@implementation UIAlertView (Blcok)

#pragma mark - 带block的ActionSheet构造初始化方法
+ (instancetype)alertViewWithTitle:(NSString *)title
                 cancelButtonTitle:(NSString *)cancelButtonTitle
                           message:(NSString *)message
                 otherButtonTitles:(NSString *)otherButtonTitles
                             block:(AlertViewBlock)block
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:otherButtonTitles, nil];
    
    if (alertView) {
        alertView.message = message;
        alertView.delegate = alertView;
        objc_setAssociatedObject(alertView, (__bridge const void *)(UIAlertView_key_clicked), block, OBJC_ASSOCIATION_COPY);
    }
    return alertView;
}

#pragma mark - UIAlertViewDelegate 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AlertViewBlock block = objc_getAssociatedObject(self, (__bridge const void *)(UIAlertView_key_clicked));
    if (block) block(self, buttonIndex);
}
@end

