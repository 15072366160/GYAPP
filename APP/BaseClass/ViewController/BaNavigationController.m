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
    [self.navigationBar setTintColor:WHITE_COLOR];
    self.navigationBar.barTintColor = HEX_COLOR(@"303439");
//    [self.navigationBar setShadowImage:[UIImage jk_imageWithColor:CLEAR_COLOR]];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)dealloc{
    NSLog(@"%@ 已经销毁",NSStringFromClass([self class]));
}

@end
