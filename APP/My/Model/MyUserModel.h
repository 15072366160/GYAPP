//
//  MyUserModel.h
//  APP
//
//  Created by Paul on 2018/11/9.
//  Copyright © 2018 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyUserModel : NSObject<NSCoding>


@property (nonatomic,assign)  NSInteger sid;        // id
@property (nonatomic,copy)    NSString *token;      // token
@property (nonatomic,copy)    NSString *nick;       // 昵称
@property (nonatomic,copy)    NSString *name;       // 姓名
@property (nonatomic,copy)    NSString *phone;      // 电话

@property (nonatomic,assign)  NSInteger sex;        // 性别
@property (nonatomic,copy)    NSString *userIcon;   // 用户头像
@property (nonatomic,assign)  NSInteger attest;     // 是否认证:0未认证，1已认证，2认证中，3认证失败
@property(nonatomic,copy)     NSString *city;       // 城市
@property(nonatomic,copy)     NSString *country;    // 国家

@property(nonatomic,copy)     NSString *province;   // 省份
@property(nonatomic,copy)     NSString *created_at; // 注册时间
@property(nonatomic,copy)     NSString *birthday;   // 生日
@property(nonatomic,copy)     NSString *location;   // 经纬度
@property(nonatomic,copy)     NSString *address;    // 地址

// 缓存
+ (void)save:(MyUserModel *)user;

// 移除
+ (void)remove;

// 获取
+ (MyUserModel *)user;

@end

NS_ASSUME_NONNULL_END
