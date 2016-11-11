//
//  MFMacros.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/1.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#ifndef MFMacros_h
#define MFMacros_h



#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)
#define ViewWY(view)   (view.y + view.height)
#define ViewHX(view)   (view.x + view.width)
//----------------------ABOUT SCREEN & SIZE 屏幕&尺寸 ----------------------------

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6/6s 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6/6s Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)




//----------------------ABOUT SYSTYM & VERSION 系统与版本 ----------------------------
//Get the OS version.       判断操作系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//judge the simulator or hardware device        判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

/** 是否为iOS8 */
#define iOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)

/** 是否为iOS9 */
#define iOS9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)


//----------------------ABOUT PRINTING LOG 打印日志 ----------------------------
//Using MFLog to print while in debug model.        调试状态下打印日志

// ...表示宏定义的可变参数
// __VA_ARGS__:表示函数里的可变参数
#ifdef DEBUG  //调试阶段
#define MFLog(...) NSLog(__VA_ARGS__)
#else //发布时
#define MFLog(...)
#endif



//----------------------ABOUT COLOR 颜色相关 ----------------------------

/** RGB */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
/** RGBA */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
/** RGB 颜色转换（16进制->10进制）*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/** 随机颜色 */
#define randomColor [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0]
/** 分割线 */
#define LineColor               RGBCOLOR(188, 186, 193)
/** TabBar颜色 －> 待定 */
#define MFTabBarNormalColor RGBCOLOR(170, 170, 170)
/** TabBar选中颜色 －> 待定 */
#define MFThemeColor RGBCOLOR(249, 103, 80)


//----------------------SYSTEM FONT 系统字体 ----------------------------

#define FONT(a)          [UIFont systemFontOfSize:(a)]

//----------------------ABOUT IMAGE 图片 ----------------------------

/*
 * LOAD LOCAL IMAGE FILE   读取本地图片    imgView.image = IMAGE(@"Default.png");
 */
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

/** DEFINE IMAGE      定义UIImage对象 */
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//BETTER USER THE FIRST WAY, IT PERFORM WELL. 优先使用前一种宏定义,性能高于后面.




//----------------------DATA STORED 数据存储 ----------------------------

/** the saving objects      存储对象 */
#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/** get the saved objects   获得存储的对象 */
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/** delete objects          删除对象 */
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}


//----------------------SOMETHING ELSE 其他 ----------------------------

#define WS(weakSelf)    __weak __typeof(&*self) weakSelf = self;

#define KEYWINDOW       [UIApplication sharedApplication].keyWindow

#define DOC_PATH        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/** 快速显示提示框 */
#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

/** GCD */
#define GCDWithGlobal(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCDWithMain(block) dispatch_async(dispatch_get_main_queue(),block)


//单例化 一个类

#define singleH(name) +(instancetype)share##name;

#if __has_feature(objc_arc)

#define singleM(name) static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)share##name\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}
#else
#define singleM static id _instance;\
+(instancetype)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
\
+(instancetype)shareTools\
{\
return [[self alloc]init];\
}\
-(id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(id)mutableCopyWithZone:(NSZone *)zone\
{\
return _instance;\
}\
-(oneway void)release\
{\
}\
\
-(instancetype)retain\
{\
return _instance;\
}\
\
-(NSUInteger)retainCount\
{\
return MAXFLOAT;\
}
#endif

#endif /* MFMacros_h */




