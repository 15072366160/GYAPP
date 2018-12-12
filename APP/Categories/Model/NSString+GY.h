//
//  NSString+GY.h
//  APP
//
//  Created by Paul on 2018/11/6.
//  Copyright © 2018 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GY)

///**
// 获取设备连接网络IP
// @param block 返回IP
// */
//+ (void)getNetworkIP:(BKDictionaryBlock)block;
//

/**
 获取设备IP
 @param preferIPv4 是否优先IPv
 @return 返回IP
 */
+ (NSString *)getLocalIP:(BOOL)preferIPv4;

/**
 是不是数字
 **/
- (BOOL)isNumber;

/**
 是不是有效字符串
 **/
- (BOOL)isValidString;

/**
 去除前后空格
 **/
- (NSString *)removeSpace;

/**
 是不是手机号
 @return Bool
 */
- (BOOL)isPhone;

@end

NS_ASSUME_NONNULL_END
