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

MJExtensionCodingImplementation

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
