//
//  UISwitch+Blcok.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/5.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISwitch (Blcok)
- (void)handleWithBlock:(MFButtonActionBlock)actionBlock controlEvent:(UIControlEvents)controlEvent;
@end
