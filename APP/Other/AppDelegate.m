//
//  AppDelegate.m
//  APP
//
//  Created by Paul on 2018/11/2.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "AppDelegate.h"

// 启动页
#import "StartUpVC.h"
// 登录注册
#import "BaLoginNVC.h"
#import "MaLoginVC.h"
// 主页
#import "BaTabBarController.h"
// 用户
#import "MyUserModel.h"

// 网络
#import "AFHTTPSessionManager.h"
#import "APP-Bridging-Header.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Window Root ViewController
    [self makeRootController];
    
    // 设置HUD
    [GYHUD setDefaultStyle:SVProgressHUDStyleDark];
    [GYHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [GYHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    
    // 检测网络
    [self checkNetwork];
    
    return YES;
}

#pragma mark -- Window Root ViewController
- (void)makeRootController{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    BaTabBarController *tab = [[BaTabBarController alloc] init];
//    self.window.rootViewController = tab;
    
    // 登录页面
    MaLoginVC *vc = [[MaLoginVC alloc] init];
    UIViewController *rootVC = [[BaLoginNVC alloc] initWithRootViewController:vc];
    
    NSString *isFirst = [NSUserDefaults objectForKey:IsFirstLoginApp];
    if ([isFirst isEqualToString:IsFirstLoginApp] == false) {
        // 第一次登录
        StartUpVC *vc = [[StartUpVC alloc] init];
        vc.rootVC = rootVC;
        rootVC = vc;
        
        [NSUserDefaults addValue:IsFirstLoginApp key:IsFirstLoginApp];
    }else{
        
        MyUserModel *user = [MyUserModel user];
        if ([user.token isValidString]) {
            rootVC = [[BaTabBarController alloc] init];
        }
        
        
        
//        if (user) {
//            [[SPKitExample sharedInstance] callThisAfterISVAccountLoginSuccessWithYWLoginId:user.mid passWord:user.mid preloginedBlock:^{
//                //可以显示会话列表页面
//            } successBlock:^{
//                GYLog(@"阿里百川登录成功！");
//            } failedBlock:^(NSError *error){
//                /// 可以显示错误提示
//                [UserModel saveUser:nil];
//                [Networking loginout:@"登录失败，请重新登录！"];
//            }];
//        }
    }
    
    self.window.rootViewController = rootVC;
}

#pragma mark -- 检测网络
- (void)checkNetwork{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [GYHUD _showInfoWithStatus:@"未知网络"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [GYHUD _showErrorWithStatus:@"网络已连接"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [GYHUD _showInfoWithStatus:@"当前使用移动流量"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [GYHUD _showSuccessWithStatus:@"当前使用WiFi网络"];
                break;
            default:
                break;
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
