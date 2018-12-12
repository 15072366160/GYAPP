//
//  LoUnionView.m
//  APP
//
//  Created by Paul on 2018/12/12.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "LoUnionView.h"

@interface LoTextField() <UITextFieldDelegate>

@property (nonatomic,assign) LoTextFiledMode mode;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *imgName;
@property (nonatomic,assign) UIKeyboardType type;

@end


@implementation LoTextField

- (NSString *)name{
    switch (self.mode) {
        case LoTextFiledModePhone:    return @"手机号";
        case LoTextFiledModePwd:      return @"密码";
        case LoTextFiledModeCode:     return @"验证码";
    }
}

- (NSString *)imgName{
    switch (self.mode) {
        case LoTextFiledModePhone:      return @"icon_phone";
        case LoTextFiledModePwd:        return @"icon_lock";
        case LoTextFiledModeCode:       return @"icon_email";
    }
}

- (UIKeyboardType)type{
    switch (self.mode) {
        case LoTextFiledModePhone:      return UIKeyboardTypeNumberPad;
        case LoTextFiledModePwd:        return UIKeyboardTypeASCIICapable;
        case LoTextFiledModeCode:       return UIKeyboardTypeNumberPad;
    }
}

- (instancetype)initWithMode:(LoTextFiledMode)mode{
    
    self = [super init];
    if (self) {
        self.mode = mode;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 22)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image = [UIImage imageNamed:self.imgName];
        self.leftView = imgView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        UIFont *font = FONT_16;
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.name attributes:@{NSFontAttributeName:font}];
        self.font = font;
        self.textColor = TEXT_COLOR_2;
        
        self.keyboardType = self.type;
        
        self.delegate = self;
    }
    return self;
}

- (UIButton *)addSendCodeWithTarget:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.rightView = btn;
    self.rightViewMode = UITextFieldViewModeAlways;
    btn.frame = CGRectMake(0, 0, 100, LoTextFieldHeight);
    [btn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_16;
    return btn;
}

- (void)addEyes{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(eyesAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 35, 35);
    [btn setImage:[UIImage imageNamed:@"icon_eyes_close"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_eyes_open"] forState:UIControlStateSelected];
    self.secureTextEntry = true;
    self.rightView = btn;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)eyesAction:(UIButton *)btn{
    self.secureTextEntry = btn.selected;
    btn.selected = !btn.selected;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.5);
    CGContextSetStrokeColorWithColor(context, LINE_COLOR_2.CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, self.jk_height);
    CGContextAddLineToPoint(context, self.jk_width, self.jk_height);
    CGContextStrokePath(context);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (string.length <= 0) {
        return true;
    }
    
    if ([string isEqualToString:@" "]) {
        return false;
    }
    
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (self.mode == LoTextFiledModeCode) {
        if (str.length > 6){
            return false;
        }
    }
    
    if (self.mode == LoTextFiledModePhone) {
        if (str.length > 11){
            return false;
        }
    }
    
    if (str.length > 30){
        return false;
    }
    
    // 只输入数字
    if (self.mode == LoTextFiledModePhone || self.mode == LoTextFiledModeCode) {
        return [str isNumber];
    }
    
    return true;
}

@end

