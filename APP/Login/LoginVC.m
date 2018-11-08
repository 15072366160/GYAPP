//
//  LoginVC.m
//  APP
//
//  Created by Paul on 2018/11/8.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "LoginVC.h"
#import "LoRegiestVC.h"

@interface LoginVC ()

@property (nonatomic,strong) UIImageView *imgView;

@end

@implementation LoginVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    // 返回
    UIButton *bkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bkBtn setImage:[UIImage imageNamed:@"back"] forState:0];
    [bkBtn addTarget:self action:@selector(bkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bkBtn];
    [bkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([GYScreen shared].navStatusH);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(80);
    }];
    
    // logo图
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    imgView.contentMode = 3;
    [self.view addSubview:imgView];
    CGFloat w = 100;
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.height / 4 - w / 2);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.width.mas_equalTo(w);
    }];
    self.imgView = imgView;
    
    // app name
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT_BOLD(24);
    label.text = @"久玩游戏";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgView.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
    
    // 登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setImage:[UIImage imageNamed:@"share_微信"] forState:0];
    loginBtn.imageView.contentMode = 2;
    [loginBtn setTitle:@"登录" forState:0];
    loginBtn.titleLabel.font = FONT_18;
    [loginBtn addTarget:self action:@selector(weChatLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-self.view.height / 4);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.width.mas_equalTo(TOUCHBTNHEIGHT);
    }];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.imgView corRadius:8];
}

// 返回
- (void)bkBtnAction{
    
    [self.navigationController dismiss];
    
    LoRegiestVC *vc = [[LoRegiestVC alloc] initWithNibName:@"LoRegiestVC" bundle:nil];
    [self push:vc];
}

// 注册
- (void)regiestBtnAction{
    
}

// 协议
- (void)protocolBtnAction{
    
}

// 微信登录
- (void)weChatLoginBtn{
    
}


@end
