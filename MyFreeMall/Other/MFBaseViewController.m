//
//  MFBaseViewController.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/2.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFBaseViewController.h"
#import "MFUnDeallocModels.h"
@interface MFBaseViewController()

@end
@implementation MFBaseViewController

- (instancetype)init{

    if (self = [super init]) {
        _canDragBack = YES;
    }
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    /** 初始化数据 */
    [self initData];
#ifdef DEBUG
    /** 统计每个初始化对象 */
    [self dealWithControllersWithIsDealloc:NO];
#endif
}

- (void)dealloc{
#ifdef DEBUG
    /** 统计未销毁对象 不适用首页出发的视图都不释放情况 */
    [self dealWithControllersWithIsDealloc:YES];
#endif
}

/** 未销毁页面统计 */
- (void)dealWithControllersWithIsDealloc:(BOOL)isDealloc{
    NSString *str = NSStringFromClass(self.class);
    NSInteger floor = self.navigationController.viewControllers.count;  //视图层
    if (!isDealloc) {
        //添加对象
        if (str.length > 0) {
            [[MFUnDeallocModels shareMFUnDeallocModels] addContrllerName:str andFloor:floor];
        }
    } else {
        //销毁对象
        if (str.length > 0) {
            [[MFUnDeallocModels shareMFUnDeallocModels] deallocControllerName:str andFloor:floor];
        }
    }
}

/** 初始化数据 */
- (void)initData{
    _canDragBack = YES;
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
@end
