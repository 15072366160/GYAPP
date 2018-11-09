//
//  LoginVC.m
//  APP
//
//  Created by Paul on 2018/11/8.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "WeChatLoginVC.h"
#import "LoSendMsgVC.h"
#import "LoginVC.h"

#import "MyUserModel.h"

// 微信登录
#import "WechatAuthSDK.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface WeChatLoginVC ()

@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIButton *loginBtn;

@end

@implementation WeChatLoginVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微信登录";
    self.view.backgroundColor = [UIColor clearColor];
    
    // 返回
    UIButton *bkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bkBtn setImage:[UIImage imageNamed:@"close"] forState:0];
    [bkBtn addTarget:self action:@selector(bkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bkBtn];
    [bkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([GYScreen shared].navStatusH);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(70);
    }];
    
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
//    label.text = @"久玩游戏";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgView.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(30);
    }];
    
    MyUserModel *user = [MyUserModel user];
    [imgView sd_setImageWithURL:[NSURL URLWithString:user.headimgurl] placeholderImage:[UIImage imageNamed:@"logo"]];
    label.text = user.nickname.length > 0? user.nickname : @"久玩游戏";
    
    // 登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundColor:HEX_COLOR(@"1aad19")];
    [loginBtn setTitle:@"微信登录" forState:0];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [loginBtn addTarget:self action:@selector(weChatLoginBtn) forControlEvents:UIControlEventTouchUpInside];
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
    copyright.font = FONT_12;
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
    
    // 登录通知
    [GYNOTI addObserver:self selector:@selector(weChatLoginBtn) name:NOTI_WX_LOGIN object:nil];
}

- (void)dealloc{
    // 移除通知
    [GYNOTI removeObserver:self name:NOTI_WX_LOGIN object:nil];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.imgView corRadius:10];
    
    [self.loginBtn corRadius:5];
}

// 返回
- (void)bkBtnAction{
    [self.navigationController dismiss];
}

// 更多
- (void)moreBtnAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更多" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"账号密码登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loginBtnAction];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self findRegiestBtnAction:FindRegiestModeRegiest];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"找回密码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self findRegiestBtnAction:FindRegiestModeFind];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [self present:alert];
}

// 注册 或者 找回密码
- (void)findRegiestBtnAction:(FindRegiestMode)mode{
    LoSendMsgVC *vc = [[LoSendMsgVC alloc] initWithNibName:@"LoSendMsgVC" bundle:nil];
    vc.mode = mode;
    [self push:vc];
}

// 登录
- (void)loginBtnAction{
    LoginVC *vc = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
    [self push:vc];
}

// 微信登录
- (void)weChatLoginBtn{
    NSString *accessToken = [NSUserDefaults objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [NSUserDefaults objectForKey:WX_OPEN_ID];
    
    if (accessToken.length > 0 && openID.length > 0) {
        NSString *refreshToken = [NSUserDefaults objectForKey:WX_REFRESH_TOKEN];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict addValue:AppID key:@"appid"];
        [dict addValue:@"refresh_token" key:@"grant_type"];
        [dict addValue:refreshToken key:@"refresh_token"];
        [GYNetworking requestMode:NetModeGET header:nil url:@"https://api.weixin.qq.com/sns/oauth2/refresh_token" params:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
            
            NSDictionary *dict = (NSDictionary *)data;
            NSString *reAccessToken = dict[WX_ACCESS_TOKEN];
            // 如果reAccessToken为空,说明reAccessToken也过期了,反之则没有过期
            if (reAccessToken) {
                // 更新access_token、refresh_token、open_id
                [NSUserDefaults addValue:dict[WX_ACCESS_TOKEN] key:WX_ACCESS_TOKEN];
                [NSUserDefaults addValue:dict[WX_OPEN_ID] key:WX_OPEN_ID];
                [NSUserDefaults addValue:dict[WX_REFRESH_TOKEN] key:WX_REFRESH_TOKEN];
                
                [self getWXUserInfo];
            }else {
                [self login];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [GYHUD _showErrorWithStatus:@"网络未连接，请检查网络！"];
        }];
    }else{
        [self login];
    }
}

- (void)login{
    
    if ([WXApi isWXAppInstalled] == false) {
        [UIAlertController alert:@"该设备未安装微信，是否前往App Store安装微信？" sure:^(UIAlertAction *action) {
            NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8"];
            [[UIApplication sharedApplication] openURL:url];
        } canle:nil];
        return;
    }
    //构造SendAuthReq结构体
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"123";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

// 获取用户个人信息（UnionID机制）
- (void)getWXUserInfo {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addValue:[NSUserDefaults objectForKey:WX_ACCESS_TOKEN] key:WX_ACCESS_TOKEN];
    [dict addValue:[NSUserDefaults objectForKey:WX_OPEN_ID] key:WX_OPEN_ID];
    WEAKSELF;
    [GYNetworking requestMode:NetModeGET header:nil url:@"https://api.weixin.qq.com/sns/userinfo" params:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable data) {
        
        [weakSelf loginSuccess:data];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [GYHUD _showErrorWithStatus:@"网络未连接，请检查网络！"];
    }];
}

- (void)loginSuccess:(NSDictionary *)dict{
    MyUserModel *user = [MyUserModel mj_objectWithKeyValues:dict];
    [MyUserModel save:user];
    
    [self bkBtnAction];
}


@end
