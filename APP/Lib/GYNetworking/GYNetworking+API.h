//
//  SYHNetworking+API.h
//  SYHGameSDK
//
//  Created by Paul on 2018/9/30.
//  Copyright © 2018年 Syh. All rights reserved.
//

#import "GYNetworking.h"

@interface GYNetworking (API)

/**
 注册
 @param phone 手机号
 @param password 密码
 @param result 返回结果 isSuccess:是否成功 data:成功返回数据 msg:返回信息 code:返回码
 */
+ (void)regiestWithPhone:(NSString *)phone password:(NSString *)password result:(ResultBlock)result;

/**
 登录
 @param phone 手机号
 @param password 密码
 @param result 返回结果 isSuccess:是否成功 data:成功返回数据 msg:返回信息 code:返回码
 */
+ (void)loginWithPhone:(NSString *)phone password:(NSString *)password result:(ResultBlock)result;

@end








