//
//  MFHomeViewController.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/5.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFHomeViewController.h"
#import "MFTopAdvanceView.h"
#import "MFMineViewController.h"
@interface MFHomeViewController ()

@end
@implementation MFHomeViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    self.view.backgroundColor = randomColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = randomColor;
    [button handleWithBlock:^(id sender) {
        [self.navigationController pushViewController:[[MFMineViewController alloc] init] animated:YES];
    } controlEvent:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}
@end
