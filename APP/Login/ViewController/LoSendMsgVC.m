//
//  LoRegiestVC.m
//  APP
//
//  Created by Paul on 2018/11/8.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "LoSendMsgVC.h"
#import "LoUnionView.h"
#import "MyUserModel.h"

// 主页
#import "BaTabBarController.h"

@interface LoSendMsgVC ()


@property (nonatomic,strong) LoTextField *phoneField;
@property (nonatomic,strong) LoTextField *codeField;
@property (nonatomic,strong) LoTextField *pwdField;

@property (nonatomic,strong) UIButton *btn;

@end

@implementation LoSendMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phoneField = [[LoTextField alloc] initWithMode:LoTextFiledModePhone];
    self.codeField = [[LoTextField alloc] initWithMode:LoTextFiledModeCode];
    self.pwdField = [[LoTextField alloc] initWithMode:LoTextFiledModePwd];
    
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.pwdField];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50 + [GYScreen shared].navBarH);
        make.left.mas_equalTo(LoTextFieldLeft);
        make.right.mas_equalTo(-LoTextFieldLeft);
        make.height.mas_equalTo(LoTextFieldHeight);
    }];
    
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(8);
        make.left.mas_equalTo(LoTextFieldLeft);
        make.right.mas_equalTo(-LoTextFieldLeft);
        make.height.mas_equalTo(LoTextFieldHeight);
    }];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeField.mas_bottom).offset(8);
        make.left.mas_equalTo(LoTextFieldLeft);
        make.right.mas_equalTo(-LoTextFieldLeft);
        make.height.mas_equalTo(LoTextFieldHeight);
    }];
    
    NSString *text = self.mode == FindRegiestModeRegiest ?  @"注册" : @"找回密码";
    self.title = text;
    self.btn = [UIButton buttonWithTarget:self action:@selector(btnAction) title:text];
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdField.mas_bottom).offset(40);
        make.left.mas_equalTo(TOUCHBTLEFT);
        make.right.mas_equalTo(-TOUCHBTLEFT);
        make.height.mas_equalTo(TOUCHBTNHEIGHT);
    }];
    
    [self.pwdField addEyes];
    [self.codeField addSendCodeWithTarget:self action:@selector(sendCodeAction)];
    
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

- (void)btnAction{
    
    NSString *phone = [self.phoneField.text removeSpace];
    if ([phone isValidString] == false) {
        [GYHUD _showInfoWithStatus:@"请输入手机号"];
        return;
    }
    if ([phone isPhone] == false) {
        [GYHUD _showInfoWithStatus:@"请输入正确手机号"];
        return;
    }
    NSString *code = [self.codeField.text removeSpace];
    if ([code isValidString] == false) {
        [GYHUD _showInfoWithStatus:@"请输入验证码"];
        return;
    }
    NSString *pwd = [self.pwdField.text removeSpace];
    if ([pwd isValidString] == false) {
        [GYHUD _showInfoWithStatus:@"请输入密码"];
        return;
    }
    
    if (self.mode == FindRegiestModeFind) {
        [self findAction:phone code:code pwd:pwd];
    }else{
        [self regiestAction:phone code:code pwd:pwd];
    }
}

// 注册
- (void)regiestAction:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd{
    
    NSString *password = [pwd jk_md5String];
    WEAKSELF;
    [GYNetworking regiestWithPhone:phone password:password result:^(BOOL isSuccess, id data, NSString *msg, NSInteger code) {
        if (isSuccess) {
            [weakSelf regiestSuccess:data];
        } else {
            [GYHUD _showErrorWithStatus:msg];
        }
    }];
}

- (void)regiestSuccess:(id)data{
    
    // 存用户
    MyUserModel *user = [MyUserModel mj_objectWithKeyValues:data];
    [MyUserModel save:user];
    
    // 回调切换root
    BaTabBarController *tab = [[BaTabBarController alloc] init];
    self.view.window.rootViewController = tab;
    
    // 提示
    [GYHUD _showSuccessWithStatus:@"注册成功"];
}

// 找回密码
- (void)findAction:(NSString *)phone code:(NSString *)code pwd:(NSString *)pwd{
    
}

// 发送验证码
- (void)sendCodeAction{

}


@end
