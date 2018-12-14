//
//  NSDictionary+jk.m
//  APP
//
//  Created by Paul on 2018/12/13.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "NSDictionary+jk.h"

@implementation NSDictionary (jk)

- (NSData *)jk_JSONData{
    NSData *data = nil;
    if (@available(iOS 11.0, *)) {
        data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingSortedKeys error:nil];
    } else {
        NSString *jsonStr = [self jk_JSONString];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    return data;
}

@end
