//
//  LoUnionView.h
//  APP
//
//  Created by Paul on 2018/12/12.
//  Copyright © 2018 Paul. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LoTextFiledMode) {
    LoTextFiledModePhone,
    LoTextFiledModePwd,
    LoTextFiledModeCode
};

static CGFloat LoTextFieldLeft = 20;
static CGFloat LoTextFieldHeight = 45;

NS_ASSUME_NONNULL_BEGIN

@interface LoTextField : UITextField

- (instancetype)initWithMode:(LoTextFiledMode)mode;

- (UIButton *)addSendCodeWithTarget:(id)target action:(SEL)action;

- (void)addEyes;

@end

NS_ASSUME_NONNULL_END
