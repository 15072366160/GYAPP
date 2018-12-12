//
//  MyVC.m
//  APP
//
//  Created by Paul on 2018/11/5.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "MyVC.h"
#import "BaLoginNVC.h"
#import "MaLoginVC.h"
#import "MySetupVC.h"
#import "MyHeaderView.h"
#import "MyUserModel.h"

@interface MyTableView : UITableView

@end

@implementation MyTableView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [MAIN_COLOR set];
    CGFloat height = -self.contentOffset.y;
    CGContextAddRect(context, CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height));
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end

@interface MyVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) MyTableView *tableView;
@property (nonatomic,strong) MyHeaderView *headerView;

@end

@implementation MyVC

- (MyTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[MyTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = LINE_COLOR_0;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:true animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:false animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加tableView
    [self.view addSubview:self.tableView];
    ADJUSTINSETS_NO(self.tableView);
    
    // headerView
    self.headerView = [MyHeaderView loadWithNibName:@"MyHeaderView"];
    self.tableView.tableHeaderView = self.headerView ;
    
    MyUserModel *user = [MyUserModel user];
    self.headerView.nameLabel.text = @"Paul97309";
    self.headerView.accountLabel.text = @"账号：15072366160";
    
    [self.headerView.imgView sd_setImageWithURL:[NSURL URLWithString:user.headimgurl] placeholderImage:[UIImage imageNamed:@"头像"]];
    [self.headerView.btn addTarget:self action:@selector(loginAction)];
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0: [self loginAction];
            break;
        case 1: [self setupAction];
            break;
            
        default:
            break;
    }
}

// 登录
- (void)loginAction{
    MaLoginVC *vc = [[MaLoginVC alloc] init];
    BaLoginNVC *nvc = [[BaLoginNVC alloc] initWithRootViewController:vc];
    [self present:nvc];
}

// 设置
- (void)setupAction{
    MySetupVC *vc = [[MySetupVC alloc] initWithNibName:@"MySetupVC" bundle:nil];
    vc.hidesBottomBarWhenPushed = true;
    [self push:vc];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.tableView setNeedsDisplay];
}

@end
