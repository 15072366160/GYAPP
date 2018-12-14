//
//  LoginVC.m
//  APP
//
//  Created by Paul on 2018/11/8.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "MaLoginVC.h"
#import "LoSendMsgVC.h"
#import "LoginVC.h"

#import "MyUserModel.h"



@interface MaLoginVC ()

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIVisualEffectView *effectView; // 毛玻璃

@property (nonatomic,assign) BOOL isRegiest;

@end

@implementation MaLoginVC

- (UIVisualEffectView *)effectView{
    if (_effectView == nil) {
        /*
         毛玻璃的样式(枚举)
         UIBlurEffectStyleExtraLight,
         UIBlurEffectStyleLight,
         UIBlurEffectStyleDark
         */
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    }
    return _effectView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:true animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加背后蓝色模块
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(0, 0, self.view.width, self.view.height / 4);
    layer.backgroundColor = MAIN_COLOR.CGColor;
    [self.view.layer addSublayer:layer];
    
    // 添加高斯模糊
    self.effectView.frame = CGRectMake(0, 0, self.view.width, self.view.height / 3);
    [self.view addSubview:self.effectView];
    
//    // 返回
//    UIButton *bkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [bkBtn setImage:[UIImage imageNamed:@"close"] forState:0];
//    [bkBtn addTarget:self action:@selector(bkBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bkBtn];
//    [bkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo([GYScreen shared].navStatusH);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(44);
//        make.width.mas_equalTo(70);
//    }];
    
    // logo图
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = 3;
    imgView.alpha = 0.9;
    [self.view addSubview:imgView];
    CGFloat w = 90;
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.height / 4 - w / 2);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.width.mas_equalTo(w);
    }];
    self.imgView = imgView;
    
    // app name
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT_BOLD(22);
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgView.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
    
    MyUserModel *user = [MyUserModel user];
    SEL action = nil;
    NSString *text = nil;
    if (user) {
        text = @"登录";
        self.isRegiest = true;
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:user.userIcon] placeholderImage:[UIImage imageNamed:@"logo"]];
        label.text = [user.nick isValidString] ? [@"欢迎回来，" stringByAppendingString:user.nick] : APP_NAME;
        action = @selector(loginBtnAction);
    }else{
        text = @"注册";
        self.isRegiest = false;
        action = @selector(regiestAction);
        imgView.image = [UIImage imageNamed:@"logo"];
        label.text = APP_NAME;
    }
    
    // 注册或者登录
    UIButton *loginBtn = [UIButton buttonWithTarget:self action:action title:text];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-(130 + [GYScreen shared].tabBarAddH ));
        make.height.mas_equalTo(TOUCHBTNHEIGHT);
        make.left.mas_equalTo(TOUCHBTLEFT);
        make.right.mas_equalTo(-TOUCHBTLEFT);
    }];
    self.loginBtn = loginBtn;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"更多" forState:0];
    btn1.titleLabel.font = FONT_SYSTEM(15);
    [btn1 addTarget:self action:@selector(moreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(16);
        make.left.mas_equalTo(TOUCHBTLEFT);
        make.right.mas_equalTo(-TOUCHBTLEFT);
        make.height.mas_equalTo(40);
    }];
    
    // 版权
    UILabel *copyright = [[UILabel alloc] init];
    copyright.textAlignment = NSTextAlignmentCenter;
    copyright.font = FONT_14;
    copyright.textColor = TEXT_COLOR_2;
    copyright.text = APP_COPYRIGHT;
    copyright.adjustsFontSizeToFitWidth = true;
    [self.view addSubview:copyright];
    [copyright mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-(10 + [GYScreen shared].tabBarAddH));
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.height.mas_equalTo(30);
    }];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.imgView corRadius:10];
    
    [self.loginBtn corRadius:5];
}

//// 返回
//- (void)bkBtnAction{
//    [self.navigationController dismiss];
//}

// 更多
- (void)moreBtnAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更多" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    NSString *text = self.isRegiest ? @"注册" : @"登录";
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:text style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.isRegiest) {
            [self regiestAction];
        }else{
            [self loginBtnAction];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"找回密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self findRegiestBtnAction:FindRegiestModeFind];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self present:alert];
}

// 注册
- (void)regiestAction{
    [self findRegiestBtnAction:FindRegiestModeRegiest];
}

// 注册 或者 找回密码
- (void)findRegiestBtnAction:(FindRegiestMode)mode{
    LoSendMsgVC *vc = [[LoSendMsgVC alloc] init];
    vc.mode = mode;
    [self push:vc];
}

// 登录
- (void)loginBtnAction{
    LoginVC *vc = [[LoginVC alloc] init];
    [self push:vc];
}


@end
