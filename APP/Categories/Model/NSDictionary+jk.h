//
//  NSDictionary+jk.h
//  APP
//
//  Created by Paul on 2018/12/13.
//  Copyright © 2018 Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (jk)

/**
 NSDictionary转换成去掉空格和换行的Data类型
 @return data
 */
- (NSData *)jk_JSONData;

@end

NS_ASSUME_NONNULL_END
