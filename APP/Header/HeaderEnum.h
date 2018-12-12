//
//  HeaderEnum.h
//  Mjb
//
//  Created by Paul197309 on 2017/10/26.
//  Copyright © 2017年 ssc. All rights reserved.
//

#ifndef HeaderEnum_h
#define HeaderEnum_h

#import <Foundation/Foundation.h>

#pragma mark -- 支付方式
typedef NS_ENUM(NSUInteger, PayMode) {
    PayModeApple = 0,   // 苹果支付
    PayModeAliPay,      // 支付宝支付
    PayModeWeChatPay,   // 微信支付
    PayModeUnionPay,    // 银联支付
    PayModeQQPay        // QQ钱包支付
};

#pragma mark -- 找回密码 和 注册
typedef NS_ENUM(NSUInteger, FindRegiestMode) {
    FindRegiestModeRegiest = 0,    // 注册
    FindRegiestModeFind,   // 找回密码
};


#endif /* HeaderEnum.h */
