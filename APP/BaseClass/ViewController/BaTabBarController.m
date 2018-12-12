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

@interface BaTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) UIView *befView;

@end

@implementation BaTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *classNames = @[@"MainVC",@"SecVC",@"ThiVC",@"MyVC"];
    
    NSArray *selectedImageName = @[@"tabbar_1_1",@"tabbar_2_1",@"tabbar_3_1",@"tabbar_4_1"];
    NSArray *normalImageName = @[@"tabbar_1_0",@"tabbar_2_0",@"tabbar_3_0",@"tabbar_4_0"];
    
    NSArray *titles = @[@"附近动态",@"消息",@"好朋友",@"个人中心"];
    
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
    
    self.tabBar.tintColor = MAIN_COLOR;
    self.viewControllers = viewControllers;
    self.delegate = self;
    
//    self.tabBar.barTintColor = WHITE_COLOR;
//    [self.tabBar setShadowImage:[UIImage jk_imageWithColor:LINE_COLOR_0]];
//    [self.tabBar setBackgroundImage:[UIImage jk_imageWithColor:WHITE_COLOR]];
}

#pragma mark -- 即将选择
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    UIView *view = [item valueForKeyPath:@"view"];
    if (self.befView != view) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //速度控制函数，控制动画运行的节奏
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 0.1;       //执行时间
        animation.repeatCount = 1;      //执行次数
        animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
        animation.fromValue = [NSNumber numberWithFloat:0.9];   //初始伸缩倍数
        animation.toValue = [NSNumber numberWithFloat:1.1];     //结束伸缩倍数
        [[view layer] addAnimation:animation forKey:nil];
        self.befView = view;
    }
}

- (void)dealloc{
    NSLog(@"%@ 已经销毁",NSStringFromClass([self class]));
}

@end
