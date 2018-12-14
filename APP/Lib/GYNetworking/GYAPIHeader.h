//
//  GYAPIHeader.h
//  SYHGameSDK
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 Syh. All rights reserved.
//

#ifndef SYHAPIHeader_h
#define SYHAPIHeader_h

#ifdef SYH_DEBUG

static NSString *const NetServer = @"http://127.0.0.1:8000/api"; //测试服务器
#else

static NSString *const NetServer = @"http://127.0.0.1:8000/api"; // 正式服务器
#endif

static NSString *const Api_test1   = @"member/test1"; // 测试

static NSString *const Api_regiest = @"member/regiest"; // 注册

static NSString *const Api_login   = @"member/login"; // 登录



#endif /* SYHAPIHeader_h */
