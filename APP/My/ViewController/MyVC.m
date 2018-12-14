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
    self.headerView.nameLabel.text = [user.nick isValidString] ? user.nick : @"昵称";
    self.headerView.accountLabel.text = [user.phone isValidString] ? [NSString stringWithFormat:@"账号：%@",user.phone] : @"账号";
    
    [self.headerView.imgView sd_setImageWithURL:[NSURL URLWithString:user.userIcon] placeholderImage:[UIImage imageNamed:@"logo"]];
    [self.headerView.btn addTarget:self action:@selector(loginout)];

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
        case 0: [self loginout];
            break;
        case 1: [self setupAction];
            break;
            
        default:
            break;
    }
}

// 登录
- (void)loginout{
    
    // 退出登录
    MyUserModel *user = [MyUserModel user];
    user.token = @"";
    [MyUserModel save:user];
    
    // 更新 rootViewController
    MaLoginVC *vc = [[MaLoginVC alloc] init];
    BaLoginNVC *nvc = [[BaLoginNVC alloc] initWithRootViewController:vc];
    [self updateWindowsRootViewController:nvc];
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
