//
//  LevelUpAnimationView.m
//  iOSerBuilding
//
//  Created by cy on 2019/9/18.
//

#import "LevelUpAnimationView.h"

@interface LevelUpAnimationView()

@property (nonatomic, assign) int grade;
/// 渐变背景
@property (nonatomic, strong) UIView *          coverView;
/// CONGRATULATIONS
@property (nonatomic, strong) UIImageView *     congratulateImageView;
@property (nonatomic, strong) UILabel *         levelUpLabel;
@property (nonatomic, strong) UILabel *         intimacyTitleLabel;
/// 外层圆圈
@property (nonatomic, strong) UIImageView *     circleImageView;
/// 红心
@property (nonatomic, strong) UIImageView *     heartImageView;
/// 亲密度
@property (nonatomic, strong) UILabel *         intimacyLabel;
/// 添加好友
@property (nonatomic, strong) UIButton *        makeFriendButton;
/// 查看星空
@property (nonatomic, strong) UIButton *        browseSkyButton;

@end

@implementation LevelUpAnimationView

+ (void)showWithGrade:(int)grade {
    [[UIApplication sharedApplication].keyWindow addSubview:[[self alloc] initWithGrade:grade]];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)initWithGrade:(int)grade {
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        self.grade = grade;
        
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    [self addSubview:self.coverView];
    [self addSubview:self.congratulateImageView];
    [self addSubview:self.levelUpLabel];
    [self addSubview:self.intimacyTitleLabel];
    [self addSubview:self.circleImageView];
    [self addSubview:self.heartImageView];
    [self addSubview:self.intimacyLabel];
    [self addSubview:self.makeFriendButton];
    [self addSubview:self.browseSkyButton];
    
    [self.congratulateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(NaviBarHeight + 28);
    }];
    [self.levelUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.congratulateImageView.mas_bottom).mas_offset(10);
    }];
    [self.intimacyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.levelUpLabel.mas_bottom).mas_offset(16);
    }];
    [self.circleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.intimacyTitleLabel.mas_bottom).mas_offset(16);
    }];
    [self.heartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.circleImageView);
    }];
    [self.intimacyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.circleImageView);
    }];
    [self.makeFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.circleImageView.mas_bottom).mas_offset(51);
        make.width.mas_equalTo(256);
        make.height.mas_equalTo(self.grade == 3 ? 0 : 44);
    }];
    [self.browseSkyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(self.makeFriendButton.mas_bottom).mas_offset(16);
        make.width.mas_equalTo(256);
        make.height.mas_equalTo(self.grade == 1 ? 0 : 44);
    }];
}

- (void)layoutSubviews {
    [self startAnimation];
}

- (void)startAnimation {
    [UIView animateWithDuration:0.2 animations:^{
        self.coverView.alpha = 1;
    }];
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        self.congratulateImageView.transform = CGAffineTransformMakeScale(1, 1);
        self.levelUpLabel.transform = CGAffineTransformMakeScale(1, 1);
        self.intimacyTitleLabel.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    [UIView animateWithDuration:0.45 delay:0.05 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
        self.circleImageView.alpha = 1;
        self.intimacyLabel.alpha = 1;
        self.circleImageView.transform = CGAffineTransformMakeScale(1, 1);
        self.intimacyLabel.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    [UIView animateWithDuration:0.86 delay:0.05 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:0 animations:^{
        self.heartImageView.alpha = 1;
        self.heartImageView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    [UIView animateWithDuration:0.2 delay:0.05 options:0 animations:^{
        self.makeFriendButton.alpha = 1;
        self.browseSkyButton.alpha = 1;
    } completion:nil];
}

#pragma mark - Click Event

- (void)makeFriendBtnClicked {
    [self removeFromSuperview];
}

- (void)browseSkyBtnClicked {
    [self removeFromSuperview];
}

#pragma mark - Getter

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.frame];
        _coverView.alpha = 0;
        
        CGColorRef startColor = [HexColor(0x3E2E8C) colorWithAlphaComponent:0.6].CGColor;
        CGColorRef endColor = HexColor(0x2A1B72).CGColor;
        
        CAGradientLayer * coverLayer = [CAGradientLayer layer];
        coverLayer.frame = _coverView.frame;
        coverLayer.startPoint = CGPointMake(0.5, 0);
        coverLayer.endPoint = CGPointMake(0.5, 1);
        coverLayer.colors = @[(__bridge id)startColor, (__bridge id)endColor];
        coverLayer.locations = @[@(0), @(1.0f)];
        
        [_coverView.layer addSublayer:coverLayer];
    }
    return _coverView;
}

- (UIImageView *)congratulateImageView {
    if (!_congratulateImageView) {
        _congratulateImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_CONGRATULATIONS"]];
        _congratulateImageView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    }
    return _congratulateImageView;
}

- (UILabel *)levelUpLabel {
    if (!_levelUpLabel) {
        _levelUpLabel = [UILabel labelWithFontSize:16 textColor:UIColor.whiteColor text:@"恭喜升级"];
        if (_grade == 3) {
            _levelUpLabel.text = @"恭喜你们成为亲密好友";
        }
        _levelUpLabel.transform = CGAffineTransformMakeScale(0.3, 0.3);
    }
    return _levelUpLabel;
}

- (UILabel *)intimacyTitleLabel {
    if (!_intimacyTitleLabel) {
        _intimacyTitleLabel = [UILabel labelWithFontSize:32 textColor:UIColor.whiteColor text:@"亲密度"];
        _intimacyTitleLabel.font = [UIFont boldSystemFontOfSize:32];
        _intimacyTitleLabel.transform = CGAffineTransformMakeScale(0.3, 0.3);
    }
    return _intimacyTitleLabel;
}

- (UIImageView *)circleImageView {
    if (!_circleImageView) {
        _circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_lvup_gq_236"]];
        _circleImageView.alpha = 0;
        _circleImageView.transform = CGAffineTransformMakeScale(0, 0);
    }
    return _circleImageView;
}

- (UIImageView *)heartImageView {
    if (!_heartImageView) {
        _heartImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_lvup_heart_120x102"]];
        _heartImageView.alpha = 0;
        _heartImageView.transform = CGAffineTransformMakeScale(0, 0);
    }
    return _heartImageView;
}

- (UILabel *)intimacyLabel {
    if (!_intimacyLabel) {
        NSString * text = [NSString stringWithFormat:@"%d", self.grade];
        _intimacyLabel = [UILabel labelWithFontSize:56 textColor:UIColor.whiteColor text:text];
        _intimacyLabel.alpha = 0;
        _intimacyLabel.transform = CGAffineTransformMakeScale(0, 0);
    }
    return _intimacyLabel;
}

- (UIButton *)makeFriendButton {
    if (!_makeFriendButton) {
        _makeFriendButton = [UIButton buttonWithTitle:@"加TA为好友"
                                           titleColor:UIColor.whiteColor
                                             fontSize:16
                                         cornerRadius:24
                                       backgrondColor:HexColor(0x7A47FF)
                                               target:self
                                               action:@selector(makeFriendBtnClicked)];
        _makeFriendButton.clipsToBounds = YES;
        _makeFriendButton.alpha = 0;
    }
    return _makeFriendButton;
}

- (UIButton *)browseSkyButton {
    if (!_browseSkyButton) {
        _browseSkyButton = [UIButton buttonWithTitle:@"查看TA的星空"
                                           titleColor:UIColor.whiteColor
                                             fontSize:16
                                         cornerRadius:24
                                       backgrondColor:nil
                                               target:self
                                               action:@selector(browseSkyBtnClicked)];
        _browseSkyButton.layer.borderColor = UIColor.whiteColor.CGColor;
        _browseSkyButton.layer.borderWidth = 1.f;
        _browseSkyButton.clipsToBounds = YES;
        _browseSkyButton.alpha = 0;
    }
    return _browseSkyButton;
}

@end
