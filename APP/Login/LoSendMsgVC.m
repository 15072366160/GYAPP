//
//  LoRegiestVC.m
//  APP
//
//  Created by Paul on 2018/11/8.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "LoSendMsgVC.h"

@interface LoSendMsgVC ()

@end

@implementation LoSendMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.mode == FindRegiestModeRegiest ?  @"注册" : @"找回密码";
    
    // 遇到问题
    [self.view addSubview:self.questionBtn];
}


@end
