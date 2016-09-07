//
//  UIActionSheet+Block.h
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/5.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionSheetBlock)(UIActionSheet *sheet,NSInteger index);

@interface UIActionSheet (Block)<UIActionSheetDelegate>
- (void)showInView:(UIView *)view handleBlock:(ActionSheetBlock)block;
@end
