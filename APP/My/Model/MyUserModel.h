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

@property(nonatomic,copy) NSString *city;       // 城市
@property(nonatomic,copy) NSString *country;    // 国家
@property(nonatomic,copy) NSString *headimgurl; // 头像
@property(nonatomic,copy) NSString *language;   // 语言
@property(nonatomic,copy) NSString *nickname;   // 昵称

@property(nonatomic,copy) NSString *openid;     // openid
@property(nonatomic,copy) NSString *province;   // 省份
@property(nonatomic,assign) NSInteger sex;      // 性别

@property(nonatomic,copy) NSString *unionid;    // unionid

// 缓存
+ (void)save:(MyUserModel *)user;

// 移除
+ (void)remove;

// 获取
+ (MyUserModel *)user;

@end

NS_ASSUME_NONNULL_END
