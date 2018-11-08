//
//  MyVC.m
//  APP
//
//  Created by Paul on 2018/11/5.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "MyVC.h"
#import "BaLoginNVC.h"
#import "LoginVC.h"

@interface MyVC ()

@end

@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:SCREEN_BOUNDS];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.image = [UIImage imageNamed:@"BK"];
    [self.view addSubview:imgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    UIImage *image = [UIImage imageGradualOblique:HEX_COLOR(@"#ff9966") endColor:HEX_COLOR(@"#ff5e62") size:CGSizeMake(50, 200)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
}

- (void)action{
    
    LoginVC *vc = [[LoginVC alloc] init];
    BaLoginNVC *nvc = [[BaLoginNVC alloc] initWithRootViewController:vc];
    [self present:nvc];
}

@end
