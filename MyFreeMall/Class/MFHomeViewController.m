//
//  MFHomeViewController.m
//  MyFreeMall
//
//  Created by boundlessocean on 16/9/5.
//  Copyright © 2016年 GXCloud. All rights reserved.
//

#import "MFHomeViewController.h"
#import "MFTopAdvanceView.h"
@interface MFHomeViewController ()

@end
@implementation MFHomeViewController

- (void)viewDidLoad{

    [super viewDidLoad];
    self.view.backgroundColor = randomColor;
    UITextField *feild = [[UITextField alloc] init];
    feild.backgroundColor = randomColor;
    feild.layer.borderColor = LineColor.CGColor;
    feild.layer.borderWidth = 0.5;
    
    [self.view addSubview:feild];
    
    [feild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(350);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
}
@end
