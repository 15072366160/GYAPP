//
//  BaViewController.m
//  APP
//
//  Created by Paul on 2018/11/2.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "BaViewController.h"

@interface BaViewController ()

@end

@implementation BaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
}

- (void)dealloc{
    NSLog(@"%@ 已经销毁",NSStringFromClass([self class]));
}

@end
