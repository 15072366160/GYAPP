//
//  LoginVC.m
//  APP
//
//  Created by Paul on 2018/11/9.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    // 遇到问题
    [self.view addSubview:self.questionBtn];
}


@end
