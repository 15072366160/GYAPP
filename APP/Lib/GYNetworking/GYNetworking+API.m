//
//  SYHNetworking+API.m
//  SYHGameSDK
//
//  Created by Paul on 2018/9/30.
//  Copyright © 2018年 Syh. All rights reserved.
//

#import "GYNetworking+API.h"
// API接口
#import "GYAPIHeader.h"


@implementation GYNetworking (API)

+ (void)regiestWithPhone:(NSString *)phone password:(NSString *)password result:(ResultBlock)result{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addValue:phone key:@"phone"];
    [params addValue:password key:@"password"];
    [params addValue:DEV_IDFA key:@"uuid"];
    [params addValue:@(1) key:@"mode"];
    [params addValue:DEV_MODELNAME key:@"modelName"];
    [GYNetworking hudPostWithURL:Api_regiest params:params result:result];
}

+ (void)loginWithPhone:(NSString *)phone password:(NSString *)password result:(ResultBlock)result{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addValue:phone key:@"phone"];
    [params addValue:password key:@"password"];
    [GYNetworking hudPostWithURL:Api_login params:params result:result];
}


@end























