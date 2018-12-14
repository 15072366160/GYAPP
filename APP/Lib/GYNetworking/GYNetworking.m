//
//  GYNetworking.m
//  GYGameSDK
//
//  Created by Paul on 2018/9/27.
//  Copyright © 2018年 GY. All rights reserved.
//

#import "GYNetworking.h"

#import "AFNetworking.h"
#import "GYAPIHeader.h"

#import "MyUserModel.h"

static NSString *const SIGNSALT = @"B3D811FCBC141316";

@implementation GYNetworking


/**
 GET 请求
 @param url api地址
 @param params 请求参数
 @param result 返回结果
 */
+ (void)getWithURL:(NSString *)url params:(NSMutableDictionary *)params result:(ResultBlock)result{
    [self requestMode:NetModeGET url:url params:params result:result];
}

+ (void)postWithURL:(NSString *)url params:(NSMutableDictionary *)params result:(ResultBlock)result{
    [self requestMode:NetModePOST url:url params:params result:result];
}

+ (void)hudGetWithURL:(NSString *)url params:(NSMutableDictionary *)params result:(ResultBlock)result{
    [GYHUD _show];
    [self requestMode:NetModeGET url:url params:params result:^(BOOL isSuccess, id data, NSString *msg, NSInteger code) {
        [GYHUD _dismiss];
        result(isSuccess,data,msg,code);
    }];
}

+ (void)hudPostWithURL:(NSString *)url params:(NSMutableDictionary *)params result:(ResultBlock)result{
    [GYHUD _show];
    [self requestMode:NetModePOST url:url params:params result:^(BOOL isSuccess, id data, NSString *msg, NSInteger code) {
        [GYHUD _dismiss];
        result(isSuccess,data,msg,code);
    }];
}

+ (void)requestMode:(NetMode)mode header:(NSDictionary *)header url:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable data))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure{
    
    //开始请求数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    AFHTTPRequestSerializer *requset = [AFHTTPRequestSerializer serializer];
    requset.stringEncoding = NSUTF8StringEncoding;
    requset.timeoutInterval = 5.0;
    for (NSString *key in header.allKeys) {
        [requset setValue:header[key] forHTTPHeaderField:key];
    }
    manager.requestSerializer = requset;
    
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json",@"text/plain", @"text/javascript", nil];
    manager.responseSerializer = response;
    
    if ([url jk_isContainChinese]) {
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    GYLog(@"urlStr：%@", url);
    GYLog(@"params：%@", params);
    
    if (mode == NetModeGET) {
        [manager GET:url parameters:params progress:nil success:success failure:failure];
    } else {
        [manager POST:url parameters:params progress:nil success:success failure:failure];
    }
}

+ (void)requestMode:(NetMode)mode url:(NSString *)url params:(NSMutableDictionary *)params result:(ResultBlock)result{
    
    NSString *timestamp = [NSString stringWithFormat:@"%.0lf",[[NSDate date] timeIntervalSince1970]];
    [params addValue:timestamp key:@"timestamp"];

    NSString *sign = [GYNetworking sign:params];
    NSString *token = [MyUserModel user].token;
    
    //开始请求数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    AFHTTPRequestSerializer *requset = [AFHTTPRequestSerializer serializer];
    requset.stringEncoding = NSUTF8StringEncoding;
    requset.timeoutInterval = 5.0;
    if ([token isValidString]) {
        [requset setValue:token forHTTPHeaderField:@"token"];
    }
    if ([sign isValidString]) {
        [requset setValue:sign forHTTPHeaderField:@"sign"];
    }
    manager.requestSerializer = requset;

    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", @"text/javascript", nil];
    manager.responseSerializer = response;

    NSString *urlStr = [NetServer stringByAppendingPathComponent:url];
    if ([urlStr jk_isContainChinese]) {
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    GYLog(@"urlStr：%@", urlStr);
    GYLog(@"params：%@", params);

    if (mode == NetModeGET) {
        [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [GYNetworking getResult:responseObject result:result];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            result(false,nil,@"网络异常，请检查网络",error.code);
        }];
    } else {
        [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [GYNetworking getResult:responseObject result:result];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            result(false,nil,@"网络异常，请检查网络",error.code);
        }];
    }
}

+ (void)getResult:(id)responseObject result:(ResultBlock)result{

    NSDictionary *dict = (NSDictionary *)responseObject;
    NSInteger code = [dict[@"code"] integerValue];
    NSString *msg = dict[@"msg"];
    
    if (code == 0) {
        id data = [self changeType:dict[@"data"]];
        GYLog(@"dict = %@",data);
        result(true,data,msg,code);
    } else {
        NSString *str = [NSString stringWithFormat:@"%ld",code];
        if ([str hasPrefix:@"5000"]) {
            // token 失效 重新登录
            result(false,nil,msg,code);
        } else {
            if ([msg isValidString] == false) {
                msg = @"数据解析错误!";
            }
            result(false,nil,msg,code);
        }
    }
}

+ (void)sendFile:(NSData *)file url:(NSString *)url params:(NSDictionary *)params result:(ResultBlock)result{
    #warning 重写上传文件
//    NSDictionary *resultParams = [GYNetworking formatParams:params];
//    NSString *sign = [GYNetworking sign:resultParams];
//    NSString *token = [GYUserModel user].token;
//    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
//    [headers addValue:token key:@"token"];
//    [headers addValue:sign key:@"sign"];
//
//    //开始请求数据
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//    AFHTTPRequestSerializer *requset = [AFHTTPRequestSerializer serializer];
//    requset.stringEncoding = NSUTF8StringEncoding;
//    requset.timeoutInterval = 5.0;
//    manager.requestSerializer = requset;
//
//    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
//    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", @"text/javascript", nil];
//    manager.responseSerializer = response;
//
//    NSString *urlStr = [NetServer stringByAppendingString:url];
//    if ([urlStr jk_isContainChinese]) {
//        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    }
//    GYLog(@"%@", urlStr);
//    GYLog(@"%@", resultParams);
//
//    [manager POST:urlStr parameters:resultParams headers:headers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        NSInteger time = [[NSDate date] timeIntervalSince1970] * 1000;
//        NSString *fileName = [NSString stringWithFormat:@"%ld.jpeg",time];
//        [formData appendPartWithFileData:file name:@"image" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [GYNetworking getResult:responseObject result:result];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        GYAPIError *err = [GYAPIError initWithCode:[NSString stringWithFormat:@"%ld",error.code]];
//        err.describe = @"网络异常，请检查网络";
//        result(false,nil,err);
//        GYLog(@"%@", error);
//    }];
}

+ (NSString *)sign:(NSDictionary *)dict{
    NSInteger count = dict.allKeys.count;
    if (count == 0) {
        return @"";
    }
    
    NSArray *keys = [dict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSString *sign = @"";
    for (int i=0; i<count; i++) {
        NSString *key   = keys[i];
        NSString *value = dict[key];
        sign = [sign stringByAppendingFormat:@"%@=%@&",key,value];
    }
    sign = [sign stringByAppendingString:SIGNSALT];
    return [sign jk_md5String];
}

#pragma mark - 私有方法

//将NSDictionary中的Null类型的项目转化成@""

+(NSDictionary *)nullDic:(NSDictionary *)myDic{
    
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    
    for (int i = 0; i < keyArr.count; i ++){
        
        id obj = [myDic objectForKey:keyArr[i]];
        obj = [self changeType:obj];
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr{
    
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++){
        id obj = myArr[i];
        obj = [self changeType:obj];
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string{
    return string;
}

//将Null类型的项目转化成@""

+(NSString *)nullToString{
    return @"";
}

#pragma mark - 公有方法

//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj{
    
    if ([myObj isKindOfClass:[NSDictionary class]]){
        
        return [self nullDic:myObj];
    }else if([myObj isKindOfClass:[NSArray class]]){
        
        return [self nullArr:myObj];
    }else if([myObj isKindOfClass:[NSString class]]){
        
        return [self stringToString:myObj];
    }else if([myObj isKindOfClass:[NSNull class]]){
        
        return [self nullToString];
    }else{
        
        return myObj;
    }
}

@end
