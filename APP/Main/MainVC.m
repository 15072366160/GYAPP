//
//  ViewController.m
//  APP
//
//  Created by Paul on 2018/11/2.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "MainVC.h"


#import "AFHTTPSessionManager.h"

@interface MainVC ()


@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    NSString *url = @"http://v.juhe.cn/exp/index?key=key&com=sf&no=575677355677";
    
    //开始请求数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPRequestSerializer *requset = [AFHTTPRequestSerializer serializer];
    requset.stringEncoding = NSUTF8StringEncoding;
    requset.timeoutInterval = 5.0;
    manager.requestSerializer = requset;
    
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json",@"text/plain", @"text/javascript", nil];
    manager.responseSerializer = response;
    
    if ([url jk_isContainChinese]) {
        url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
