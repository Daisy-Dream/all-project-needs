//
//  MFTabBarController.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/2.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFTabBarController.h"
#import "MFNavigationController.h"
#import "MFHomeViewController.h"
#import "MFMineViewController.h"
@implementation MFTabBarController
/**
 *  初始化
 */
+ (void)initialize {
    NSMutableDictionary *normalAttrs              = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName]              = [UIFont systemFontOfSize:11];
    normalAttrs[NSForegroundColorAttributeName]   = MFTabBarNormalColor;

    NSMutableDictionary *selectedAttrs            = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName]            = normalAttrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = MFThemeColor;

    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildViewController:[[MFHomeViewController alloc] init]
                             title:@"首页"
                             image:@"icon_home"
                     selectedImage:@"icon_home_selected"];
    
    [self setupChildViewController:[[MFMineViewController alloc] init]
                             title:@"个人中心"
                             image:@"icon_mine"
                     selectedImage:@"icon_mine_selected"];
    
}

/**
 *  添加子控制器
 *
 *  @param childController 需要添加的子控制器
 *  @param title           标题
 *  @param image           图标
 *  @param selectedImage   选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childController
                           title:(NSString *)title
                           image:(NSString *)image
                   selectedImage:(NSString *)selectedImage {
    
    childController.title          = title;
    [childController.tabBarItem setImage:[UIImage imageNamed:image]];
    [childController.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    MFNavigationController *navCon = [[MFNavigationController alloc] initWithRootViewController:childController];
    navCon.title                   = title;
    
    [self addChildViewController:navCon];
}

@end
