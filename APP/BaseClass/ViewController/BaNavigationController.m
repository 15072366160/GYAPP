//
//  BaNavigationController.m
//  APP
//
//  Created by Paul on 2018/11/2.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "BaNavigationController.h"

@interface BaNavigationController ()

@end

@implementation BaNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barStyle = UIBarStyleBlack;
    
    UIImage *img = [UIImage imageGradualOblique:HEX_COLOR(@"FF652D") endColor:HEX_COLOR(@"FF2424") size:CGSizeMake(SCREEN_WIDTH, [GYScreen shared].navBarH)];
    [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage jk_imageWithColor:CLEAR_COLOR]];
}

- (void)dealloc{
    NSLog(@"%@ 已经销毁",NSStringFromClass([self class]));
}

@end
