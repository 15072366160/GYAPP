//
//  LoginVC.m
//  APP
//
//  Created by Paul on 2018/11/9.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "LoginVC.h"
#import "LoUnionView.h"
#import "MyUserModel.h"
// 主页
#import "BaTabBarController.h"

@interface LoginVC ()

@property (nonatomic,strong) LoTextField *phoneField;
@property (nonatomic,strong) LoTextField *pwdField;

@property (nonatomic,strong) UIButton *btn;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    self.phoneField = [[LoTextField alloc] initWithMode:LoTextFiledModePhone];
    self.pwdField = [[LoTextField alloc] initWithMode:LoTextFiledModePwd];
    
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.pwdField];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50 + [GYScreen shared].navBarH);
        make.left.mas_equalTo(LoTextFieldLeft);
        make.right.mas_equalTo(-LoTextFieldLeft);
        make.height.mas_equalTo(LoTextFieldHeight);
    }];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(8);
        make.left.mas_equalTo(LoTextFieldLeft);
        make.right.mas_equalTo(-LoTextFieldLeft);
        make.height.mas_equalTo(LoTextFieldHeight);
    }];
    
    self.btn = [UIButton buttonWithTarget:self action:@selector(loginAction) title:@"登录"];
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdField.mas_bottom).offset(40);
        make.left.mas_equalTo(TOUCHBTLEFT);
        make.right.mas_equalTo(-TOUCHBTLEFT);
        make.height.mas_equalTo(TOUCHBTNHEIGHT);
    }];
    
    [self.pwdField addEyes];
    
    self.phoneField.text = [MyUserModel user].phone;
    
    // 遇到问题
    [self.view addSubview:self.questionBtn];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.btn corRadius:5];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    if (self.phoneField.isEditing || self.pwdField.isEditing) {
        [self.view endEditing:true];
    }
}

// 登录
- (void)loginAction{
    
    NSString *phone = [self.phoneField.text removeSpace];
    if ([phone isValidString] == false) {
        [GYHUD _showInfoWithStatus:@"请输入手机号"];
        return;
    }
    if ([phone isPhone] == false) {
        [GYHUD _showInfoWithStatus:@"请输入正确手机号"];
        return;
    }
    NSString *pwd = [self.pwdField.text removeSpace];
    if ([pwd isValidString] == false) {
        [GYHUD _showInfoWithStatus:@"请输入密码"];
        return;
    }

    NSString *password = [pwd jk_md5String];
    WEAKSELF;
    [GYNetworking loginWithPhone:phone password:password result:^(BOOL isSuccess, id data, NSString *msg, NSInteger code) {
        if (isSuccess) {
            
            // 存用户
            MyUserModel *user = [MyUserModel mj_objectWithKeyValues:data];
            [MyUserModel save:user];
            
            // 更新 rootViewController
            BaTabBarController *tab = [[BaTabBarController alloc] init];
            weakSelf.view.window.rootViewController = tab;
            
            // 提示
            [GYHUD _showSuccessWithStatus:@"登录成功"];
            
        } else {
            [GYHUD _showErrorWithStatus:msg];
        }
    }];
}


@end
