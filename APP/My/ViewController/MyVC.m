//
//  MyVC.m
//  APP
//
//  Created by Paul on 2018/11/5.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "MyVC.h"
#import "BaLoginNVC.h"
#import "WeChatLoginVC.h"

@interface MyVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation MyVC

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = LINE_COLOR_0;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:SCREEN_BOUNDS];
//    imgView.contentMode = UIViewContentModeScaleAspectFill;
//    imgView.image = [UIImage imageNamed:@"BK"];
//    [self.view addSubview:imgView];
//
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"登录" forState:UIControlStateNormal];
//    UIImage *image = [UIImage imageGradualOblique:HEX_COLOR(@"#ff9966") endColor:HEX_COLOR(@"#ff5e62") size:CGSizeMake(50, 200)];
//    [btn setBackgroundImage:image forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.centerY.mas_equalTo(self.view.mas_centerY);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(50);
//    }];
    
    [self.view addSubview:self.tableView];
}

- (void)action{
    
    WeChatLoginVC *vc = [[WeChatLoginVC alloc] init];
    BaLoginNVC *nvc = [[BaLoginNVC alloc] initWithRootViewController:vc];
    [self present:nvc];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const MyCell = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCell];
    }
    
    return cell;
}

#pragma mark -- UITableViewDelegate

@end
