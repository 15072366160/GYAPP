//
//  BaChildViewController.m
//  APP
//
//  Created by Paul on 2018/11/2.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "BaChildViewController.h"
#import "LoQuestionVC.h"

@interface BaChildViewController ()

@end

@implementation BaChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

#pragma mark -- 遇到问题
- (UIButton *)questionBtn{
    if (_questionBtn == nil) {
        _questionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_questionBtn setTitle:@"遇到问题？" forState:0];
        _questionBtn.titleLabel.font = FONT_SYSTEM(15);
        [_questionBtn addTarget:self action:@selector(questionBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _questionBtn.frame = CGRectMake(TOUCHBTLEFT, SCREEN_HEIGHT - (80 + [GYScreen shared].tabBarAddH), SCREEN_WIDTH - TOUCHBTLEFT * 2, TOUCHBTNHEIGHT);
    }
    return _questionBtn;
}

- (void)questionBtnAction{
    LoQuestionVC *vc = [[LoQuestionVC alloc] initWithNibName:@"LoQuestionVC" bundle:nil];
    [self push:vc];
}


@end
