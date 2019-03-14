//
//  RegexViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/3/14.
//  http://www.runoob.com/regexp/regexp-tutorial.html

#import "RegexViewController.h"
#import "NSString+Check.h"

@interface RegexViewController ()

@property (nonatomic, strong) UITextField * phoneField;
@property (nonatomic, strong) UIButton *    phoneCheckButton;
@property (nonatomic, strong) UILabel *     phoneStatusLabel;

@property (nonatomic, strong) UITextField * emailField;
@property (nonatomic, strong) UIButton *    emailCheckButton;
@property (nonatomic, strong) UILabel *     emailStatusLabel;

@end

@implementation RegexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NaviBarHeight + 10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(44);
    }];
    
    [self.view addSubview:self.phoneCheckButton];
    [self.phoneCheckButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneField.mas_bottom).offset(10);
        make.left.mas_equalTo(self.phoneField);
        make.size.mas_equalTo(CGSizeMake(64, 44));
    }];
    
    [self.view addSubview:self.phoneStatusLabel];
    [self.phoneStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.phoneCheckButton);
        make.right.mas_equalTo(self.phoneField);
    }];
    
    [self.view addSubview:self.emailField];
    [self.emailField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneCheckButton.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.phoneField);
        make.height.mas_equalTo(44);
    }];
    
    [self.view addSubview:self.emailCheckButton];
    [self.emailCheckButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emailField.mas_bottom).offset(10);
        make.left.mas_equalTo(self.emailField);
        make.size.mas_equalTo(CGSizeMake(64, 44));
    }];
    
    [self.view addSubview:self.emailStatusLabel];
    [self.emailStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.emailCheckButton);
        make.right.mas_equalTo(self.emailField);
    }];
}

- (void)phoneCheckBtnClicked {
    
    self.phoneStatusLabel.text = [self.phoneField.text isPhoneNumber] ? @"合法" : @"不合法";
}

- (void)emailCheckBtnClicked {
    
    self.emailStatusLabel.text = [self.emailField.text isEmail] ? @"合法" : @"不合法";
}

- (UITextField *)phoneField {
    if (!_phoneField) {
        _phoneField = [UITextField new];
        _phoneField.backgroundColor = [UIColor whiteColor];
        _phoneField.placeholder = @"手机号码校验";
    }
    return _phoneField;
}

- (UIButton *)phoneCheckButton {
    if (!_phoneCheckButton) {
        _phoneCheckButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_phoneCheckButton setTitle:@"Check" forState:UIControlStateNormal];
        _phoneCheckButton.backgroundColor = [UIColor whiteColor];
        
        [_phoneCheckButton addTarget:self action:@selector(phoneCheckBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneCheckButton;
}

- (UILabel *)phoneStatusLabel {
    if (!_phoneStatusLabel) {
        _phoneStatusLabel = [UILabel new];
    }
    return _phoneStatusLabel;
}

- (UITextField *)emailField {
    if (!_emailField) {
        _emailField = [UITextField new];
        _emailField.backgroundColor = [UIColor whiteColor];
        _emailField.placeholder = @"邮箱地址校验";
    }
    return _emailField;
}

- (UIButton *)emailCheckButton {
    if (!_emailCheckButton) {
        _emailCheckButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_emailCheckButton setTitle:@"Check" forState:UIControlStateNormal];
        _emailCheckButton.backgroundColor = [UIColor whiteColor];
        
        [_emailCheckButton addTarget:self action:@selector(emailCheckBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emailCheckButton;
}

- (UILabel *)emailStatusLabel {
    if (!_emailStatusLabel) {
        _emailStatusLabel = [UILabel new];
    }
    return _emailStatusLabel;
}

@end
