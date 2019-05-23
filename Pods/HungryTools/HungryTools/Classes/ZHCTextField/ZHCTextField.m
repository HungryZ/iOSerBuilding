//
//  ZHCTextField.m
//  FCHCL
//
//  Created by 张海川 on 2019/4/25.
//  Copyright © 2019 封建. All rights reserved.
//

#ifndef ThemeColor
#define ThemeColor [UIColor colorWithRed:255/255.f green:80/255.f blue:74/255.f alpha:1]
#endif

#import "ZHCTextField.h"
#import "NSString+Check.h"
#import "Masonry.h"
#import "UILabel+Initializer.h"
#import "UIButton+Initializer.h"

@interface ZHCTextField() <UITextFieldDelegate>

@property (nonatomic, strong) UIView *      bottomLineView;
@property (nonatomic, strong) UIButton *    secureButton;

@end

@implementation ZHCTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addBottomLine];
        self.delegate = self;
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}
// 无效
//- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
//    //        bounds.origin.x -= ViewWidth(self.rightView);
//    CGRect frame = [super clearButtonRectForBounds:bounds];
//    if (self.rightView) {
//        frame.origin.x -= ViewWidth(self.rightView) + 10;
//    }
//    return frame;
//}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 删除
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    NSInteger comingTextLength = textField.text.length + string.length - range.length;
    
    if (_maxLength) {
        if (comingTextLength > _maxLength) {
            return NO;
        }
    }
    
    switch (_fieldType) {
        case ZHCFieldTypeDefault: {
            return YES;
            break;
        }
        case ZHCFieldTypeNumber: {
            return [string checkWithRegexString:@"[0-9]+"];
            break;
        }
        case ZHCFieldTypePhoneNumber: {
            if (comingTextLength > 11) {
                return NO;
            }
            return [string checkWithRegexString:@"[0-9]+"];
            break;
        }
        case ZHCFieldTypePassword: {
            return [string checkWithRegexString:@"[A-Za-z0-9_]"];
            break;
        }
        case ZHCFieldTypeMoney: {
            return [string checkWithRegexString:@"[0-9.]+"];
            break;
        }
        case ZHCFieldTypeIDNumber: {
            if (comingTextLength > 18) {
                return NO;
            }
            return [string checkWithRegexString:@"[0-9Xx]+"];
            break;
        }
        case ZHCFieldTypeChinese: {
            return [string checkWithRegexString:@"[\\u4e00-\\u9fa5]+"];
            break;
        }
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.bottomLineView.backgroundColor = ThemeColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.bottomLineView.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark - Action

- (void)secureBtnClicked {
    self.secureTextEntry ^= 1;
    self.secureButton.selected = self.isSecureTextEntry;
}

#pragma mark - Private Method

- (void)addBottomLine {
    
    [self addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - Public Method

#pragma mark - Setter

- (void)setFieldType:(ZHCFieldType)fieldType {
    
    _fieldType = fieldType;
    
    switch (_fieldType) {
        case ZHCFieldTypeDefault: {
            
            break;
        }
        case ZHCFieldTypeNumber: {
            self.keyboardType = UIKeyboardTypeNumberPad;
            break;
        }
        case ZHCFieldTypePhoneNumber: {
            self.keyboardType = UIKeyboardTypePhonePad;
            break;
        }
        case ZHCFieldTypePassword:{
            self.secureTextEntry = YES;
            self.rightView = self.secureButton;
            self.rightViewMode = UITextFieldViewModeAlways;
            self.keyboardType = UIKeyboardTypeAlphabet;
            break;
        }
        case ZHCFieldTypeMoney: {
            self.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        }
        case ZHCFieldTypeIDNumber: {
            
            break;
        }
        case ZHCFieldTypeChinese: {
            
            break;
        }
    }
}

- (void)setLeftText:(NSString *)leftText {
    
    UIView * leftView = [UIView new];
    UILabel * textLabel = [UILabel labelWithFontSize:14.f text:leftText];
    [leftView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    // 给leftView一个宽度
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textLabel).offset(20);
    }];
    
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setLeftImageString:(NSString *)leftImageString {
    
    UIView * leftView = [UIView new];
    UIImageView * subView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftImageString]];
    [leftView addSubview:subView];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    // 给leftView一个宽度
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(subView).offset(20);
    }];
    
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setIsShowBottomLine:(BOOL)isShowBottomLine {
    
    _isShowBottomLine = isShowBottomLine;
    self.bottomLineView.hidden = !_isShowBottomLine;
}

#pragma mark - Getter

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:216/255.f green:216/255.f blue:216/255.f alpha:1];
    }
    return _bottomLineView;
}

- (UIButton *)secureButton {
    if (!_secureButton) {
        _secureButton = [UIButton buttonWithImageName:@"eye_close" target:self action:@selector(secureBtnClicked)];
        [_secureButton setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
        _secureButton.frame = CGRectMake(0, 0, 23, 20);
        _secureButton.selected = YES;
    }
    return _secureButton;
}

@end
