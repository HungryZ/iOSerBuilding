//
//  ZHCTextField.m
//  FCHCL
//
//  Created by 张海川 on 2019/4/25.
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
            if (self.text.length == 3 || self.text.length == 8) {
                self.text = [self.text stringByAppendingString:@" "];
            }
            return [string checkWithRegexString:@"[0-9]+"];
            break;
        }
        case ZHCFieldTypePhoneNumberWithoutSpacing: {
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
        case ZHCFieldTypeIDCardNumber: {
            return [string checkWithRegexString:@"[0-9Xx]+"];
            break;
        }
        case ZHCFieldTypeChinese: {
            return [string checkWithRegexString:@"[a-z\\u4e00-\\u9fa5]+"];
            break;
        }
        case ZHCFieldTypeBankCardNumber: {
            return [string checkWithRegexString:@"[0-9]+"];
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
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)updateBottomLineConstraints {
    [self.bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
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
            self.maxLength = 13;
            break;
        }
        case ZHCFieldTypePhoneNumberWithoutSpacing: {
            self.keyboardType = UIKeyboardTypePhonePad;
            self.maxLength = 11;
            break;
        }
        case ZHCFieldTypePassword:{
            self.secureTextEntry = YES;
            self.rightView = self.secureButton;
            self.rightViewMode = UITextFieldViewModeAlways;
            self.keyboardType = UIKeyboardTypeAlphabet;
            self.maxLength = 18;
            break;
        }
        case ZHCFieldTypeMoney: {
            self.keyboardType = UIKeyboardTypeDecimalPad;
            self.maxLength = 8;
            break;
        }
        case ZHCFieldTypeIDCardNumber: {
            self.maxLength = 18;
            break;
        }
        case ZHCFieldTypeChinese: {
            
            break;
        }
        case ZHCFieldTypeBankCardNumber: {
            self.maxLength = 19;
            break;
        }
    }
}

- (void)setLeftText:(NSString *)leftText {
    
    UIView * leftView = [UIView new];
    UILabel * textLabel = [UILabel labelWithFontSize:14.f text:leftText];
    if (_leftTextColor) {
        textLabel.textColor = _leftTextColor;
    }
    if (_leftTextFontSize > 0) {
        textLabel.font = [UIFont systemFontOfSize:_leftTextFontSize];
    }
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
    
    [self updateBottomLineConstraints];
}

- (void)setLeftImageName:(NSString *)leftImageString {
    
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
    
    [self updateBottomLineConstraints];
}

- (void)setShowBottomLine:(BOOL)isShowBottomLine {
    
    _showBottomLine = isShowBottomLine;
    self.bottomLineView.hidden = !_showBottomLine;
}

- (void)setSecureButtonImages:(NSArray *)secureButtonImages {
    if (secureButtonImages.count != 2) {
        return;
    }
    if ([secureButtonImages[0] isKindOfClass:[UIImage class]]) {
        [_secureButton setImage:secureButtonImages[0] forState:UIControlStateSelected];
    }
    if ([secureButtonImages[1] isKindOfClass:[UIImage class]]) {
        [_secureButton setImage:secureButtonImages[1] forState:UIControlStateNormal];
    }
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
        _secureButton = [UIButton buttonWithImageName:@"Resource.bundle/eye_close" target:self action:@selector(secureBtnClicked)];
        [_secureButton setImage:[UIImage imageNamed:@"Resource.bundle/eye_open"] forState:UIControlStateSelected];
        _secureButton.frame = CGRectMake(0, 0, 23, 20);
        _secureButton.selected = YES;
    }
    return _secureButton;
}

@end
