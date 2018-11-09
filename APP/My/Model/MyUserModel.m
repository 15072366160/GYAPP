//
//  MyUserModel.m
//  APP
//
//  Created by Paul on 2018/11/9.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "MyUserModel.h"
//存入document
#define DocumentPath(File) ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:File])

@implementation MyUserModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        // 解档
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.country = [aDecoder decodeObjectForKey:@"country"];
        self.headimgurl = [aDecoder decodeObjectForKey:@"headimgurl"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];

        self.openid = [aDecoder decodeObjectForKey:@"openid"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
        self.unionid = [aDecoder decodeObjectForKey:@"unionid"];
        
        self.sex = [aDecoder decodeIntegerForKey:@"sex"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    // 归档
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.headimgurl forKey:@"headimgurl"];
    [aCoder encodeObject:self.language forKey:@"language"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    
    [aCoder encodeObject:self.openid forKey:@"openid"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.unionid forKey:@"unionid"];
    
    [aCoder encodeInteger:self.sex forKey:@"sex"];
}

+ (void)save:(MyUserModel *)user{
    if (user) {
        [NSKeyedArchiver archiveRootObject:user toFile:DocumentPath(@"User.archiver")];
    }
}

+ (void)remove{
    [[NSFileManager defaultManager] removeItemAtPath:DocumentPath(@"User.archiver") error:nil];
}

+ (MyUserModel *)user{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:DocumentPath(@"User.archiver")];
}

@end
