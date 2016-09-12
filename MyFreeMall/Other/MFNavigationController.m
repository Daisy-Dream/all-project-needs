//
//  MFNavigationController.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/2.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFNavigationController.h"
#import "MFBaseViewController.h"

@interface MFNavigationController ()<UIGestureRecognizerDelegate>
/** 是否支持侧滑返回 */
@property(nonatomic, assign)BOOL canDragBack;
@end

@implementation MFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    [self dealWithDargBack];
}

/** 处理侧滑返回 */
- (void)dealWithDargBack{
    
    _canDragBack                = YES;
    id target                   = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target
                                                                          action:@selector(handleNavigationTransition:)];
    pan.delegate                = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}

/** 推控制器 */
- (void)pushViewController:(MFBaseViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        // 替换back按钮
        UIBarButtonItem *backBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"icon_back"
                                                                         imageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)
                                                                                  target:self
                                                                                  action:@selector(back)];
        
        viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed         = YES;
        _canDragBack                                    = viewController.canDragBack;
    }
    [super pushViewController:viewController animated:animated];
}

/** 返回 */
- (void)back {
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // 判断 gestureRecognizer 方向 translatedPoint.x < 0 向右 > 0 向左
    CGPoint translatedPoint = [gestureRecognizer translationInView:self.view];
    
    if (_canDragBack && translatedPoint.x > 0 && self.viewControllers.count > 1 ) {
        return YES;
    }else{
        return NO;
    }
}

@end
