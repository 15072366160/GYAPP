//
//  MyHeaderView.m
//  APP
//
//  Created by Paul on 2018/11/10.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "MyHeaderView.h"

@interface MyHeaderView ()

@end

@implementation MyHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.imgView corRadius:5];
    [self.imgView borW:1 color:[UIColor colorWithWhite:1 alpha:0.5]];
    
}


@end
