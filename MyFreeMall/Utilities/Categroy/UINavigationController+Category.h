//
//  UINavigationController+Extension.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/2.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  ViewController *vc = [self.navigationController getSpecificViewController:[ViewController class]];
 */
@interface UINavigationController (Category)
/**
 *  找到指定的视图控制器
 *
 *  @param viewControllerType 控制器名称
 *
 *  @return 指定的视图控制器
 */
- (id)getSpecificViewController:(Class)viewControllerType;

@end
