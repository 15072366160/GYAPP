//
//  BaLoginNVC.m
//  APP
//
//  Created by Paul on 2018/11/8.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "BaLoginNVC.h"
#import "GYTransition.h"

@interface BaLoginNVC ()

@property (nonatomic,strong) UIVisualEffectView *effectView; // 毛玻璃

@end

@implementation BaLoginNVC

- (UIVisualEffectView *)effectView{
    if (_effectView == nil) {
        /*
         毛玻璃的样式(枚举)
         UIBlurEffectStyleExtraLight,
         UIBlurEffectStyleLight,
         UIBlurEffectStyleDark
         */
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.frame = [UIScreen mainScreen].bounds;
    }
    return _effectView;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    // 添加高斯模糊
    UIViewController *vc = self.presentingViewController;
    [vc.view addSubview:self.effectView];
    // 调整位置
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    CGRect rect = [self.effectView convertRect: self.effectView.bounds toView:window];
    self.effectView.frame = CGRectMake(-rect.origin.x, -rect.origin.y, rect.size.width, rect.size.height);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

   [self.view insertSubview:self.effectView atIndex:0];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    
    [self setNavigationBarHidden:false animated:animated];
}

- (void)dealloc{
    NSLog(@"%@ 已经销毁",NSStringFromClass([self class]));
}

@end
