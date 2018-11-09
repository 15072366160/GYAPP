//
//  BaTabBarController.m
//  APP
//
//  Created by Paul on 2018/11/2.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "BaTabBarController.h"
#import "BaNavigationController.h"
#import "BaRootViewController.h"

@interface BaTabBarController ()

@end

@implementation BaTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *classNames = @[@"MainVC",@"MyVC"];
    
    NSArray *selectedImageName = @[@"tabbar_main_sel",@"tabbar_my_sel"];
    NSArray *normalImageName = @[@"tabbar_main_nor",@"tabbar_my_nor"];
    
    NSArray *titles = @[@"首页",@"我的"];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (int i=0; i<classNames.count; i++) {
        Class class = NSClassFromString(classNames[i]);
        BaRootViewController *vc = [[class alloc] init];
        
        UIImage *selectedImage = [[UIImage imageNamed:selectedImageName[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *normalImage = [[UIImage imageNamed:normalImageName[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titles[i] image:normalImage selectedImage:selectedImage];
        vc.tabBarItem = item;
        vc.title = titles[i];
        
        BaNavigationController *nvc = [[BaNavigationController alloc] initWithRootViewController:vc];
        [viewControllers addObject:nvc];
    }
    
    self.tabBar.tintColor = HEX_COLOR(@"f12711");
    self.viewControllers = viewControllers;
    
    [self.tabBar setShadowImage:[UIImage jk_imageWithColor:LINE_COLOR_0]];
    [self.tabBar setBackgroundImage:[UIImage jk_imageWithColor:WHITE_COLOR]];
}

- (void)dealloc{
    NSLog(@"%@ 已经销毁",NSStringFromClass([self class]));
}

@end
