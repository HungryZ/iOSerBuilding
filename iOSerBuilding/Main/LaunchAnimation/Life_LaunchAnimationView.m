//
//  Life_LaunchAnimationView.m
//  iOSerBuilding
//
//  Created by cy on 2019/8/29.
//

#import "Life_LaunchAnimationView.h"
#import "Life_LaunchModel.h"
#import <AVFoundation/AVFoundation.h>

@interface Life_LaunchAnimationView()

@property (nonatomic, strong) AVPlayer *            player;
@property (nonatomic, strong) NSTimer *             timer;

@property (nonatomic, strong) Life_LaunchModel *    model;

@property (nonatomic, strong) UIImageView *         backImageView;
@property (nonatomic, strong) UIView *              backCoverView;

@property (nonatomic, strong) UIView *              countingView;
@property (nonatomic, strong) UILabel *             countingHeaderLabel;
@property (nonatomic, strong) UILabel *             countingLabel;
@property (nonatomic, strong) UILabel *             countingFooterLabel;

@property (nonatomic, strong) UIView *              lineView;
@property (nonatomic, strong) UILabel *             dateLabel;
@property (nonatomic, strong) UILabel *             soupLabel;

@end

@implementation Life_LaunchAnimationView

+ (void)life_showWithModel:(Life_LaunchModel *)model {
    [[UIApplication sharedApplication].keyWindow addSubview:[[self alloc] initWithModel:model]];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (instancetype)initWithModel:(Life_LaunchModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self configUI];
        [self startAnimation];
        
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"ticktock" withExtension:@"mov"];
        _player = [[AVPlayer alloc] initWithURL:url];
    }
    return self;
}

- (void)configUI {
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    
    [self addSubview:self.backImageView];
    [self addSubview:self.backCoverView];
    [self addSubview:self.countingView];
    [self addSubview:self.lineView];
    [self addSubview:self.dateLabel];
    [self addSubview:self.soupLabel];
    
    [self.countingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(StatusBarDifHeight + 132);
        make.centerX.mas_equalTo(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-TabBarDifHeight - 128);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(20, 1));
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineView.mas_top).mas_offset(-16);
        make.centerX.mas_equalTo(0);
    }];
    [self.soupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).mas_offset(16);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(231);
    }];
}

- (void)startAnimation {
    
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        self.backCoverView.alpha = 0.6;
    } completion:nil];
    
    [UIView animateWithDuration:0.25 delay:0.4 options:0 animations:^{
        self.countingHeaderLabel.alpha = 0.5;
        self.countingLabel.alpha = 1;
        self.countingFooterLabel.alpha = 1;
    } completion:^(BOOL finished) {
        self->_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshCountingLabel) userInfo:nil repeats:YES];
        [self->_player play];
        [self performSelector:@selector(voiceDown) withObject:nil afterDelay:3.3f];
    }];
    
    [UIView animateWithDuration:1.5 delay:0.8 options:0 animations:^{
        self.lineView.alpha = 0.7;
        self.dateLabel.alpha = 0.7;
        self.soupLabel.alpha = 0.7;
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:4 options:0 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self->_timer invalidate];
        [self removeFromSuperview];
    }];
}

- (void)refreshCountingLabel {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.countingLabel.text = [self countingText];
    });
}

- (void)voiceDown {
    [_player setVolume:0.3];
}

- (NSString *)countingText {
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    
    NSDate *eventDate = [dateFormatter dateFromString:_model.event_time];
    // 单位 天
    double time = [eventDate timeIntervalSinceNow] / 60. / 60. / 24.;
    NSString * stringFormat = @"%.5f";
    
    // 生日事件以 年 为单位
    if ([_model.event_type isEqualToString:@"2"]) {
        time /= -365;
        stringFormat = @"%.8f";
    }
    
    return [NSString stringWithFormat:stringFormat, time];
}

- (NSString *)nowDateString {
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy.MM.dd EEEE"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

#pragma mark - Getter

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        if (0) {
            _backImageView.image = [UIImage imageNamed:@"LFSheng_IMG_img_BG_dark_Normal"];
        } else {
            _backImageView.image = [UIImage imageNamed:@"LFSheng_IMG_img_BG_dark_NormalX"];
        }
    }
    return _backImageView;
}

- (UIView *)backCoverView {
    if (!_backCoverView) {
        _backCoverView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _backCoverView.backgroundColor = RGBA(0, 0, 0, 0.6);
        _backCoverView.alpha = 0;
    }
    return _backCoverView;
}

- (UIView *)countingView {
    if (!_countingView) {
        _countingView = [UIView new];
        [_countingView addSubview:self.countingHeaderLabel];
        [_countingView addSubview:self.countingLabel];
        [_countingView addSubview:self.countingFooterLabel];
        
        [self.countingHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.mas_equalTo(0);
        }];
        [self.countingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.countingHeaderLabel.mas_bottom).mas_offset(16);
            make.left.mas_offset(0);
        }];
        [self.countingFooterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.countingLabel);
            make.left.equalTo(self.countingLabel.mas_right);
            make.bottom.right.mas_equalTo(0);
        }];
    }
    return _countingView;
}

- (UILabel *)countingHeaderLabel {
    if (!_countingHeaderLabel) {
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = UIColor.whiteColor;
        label.alpha = 0;
        
        if ([_model.event_type isEqualToString:@"2"]) {
            label.text = @"你已经";
        } else {
            label.text = [NSString stringWithFormat:@"距离%@还有", _model.event_name];
        }
        
        _countingHeaderLabel = label;
    }
    return _countingHeaderLabel;
}

- (UILabel *)countingLabel {
    if (!_countingLabel) {
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize:24];
        label.textColor = UIColor.whiteColor;
        label.alpha = 0;
        
        label.text = [self countingText];
        
        _countingLabel = label;
    }
    return _countingLabel;
}

- (UILabel *)countingFooterLabel {
    if (!_countingFooterLabel) {
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize:21];
        label.textColor = UIColor.whiteColor;
        label.alpha = 0;
        
        if ([_model.event_type isEqualToString:@"2"]) {
            label.text = @"岁了";
        } else {
            label.text = @"天";
        }
        
        _countingFooterLabel = label;
    }
    return _countingFooterLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColor.whiteColor;
        _lineView.alpha = 0;
    }
    return _lineView;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = UIColor.whiteColor;
        label.alpha = 0;
        
        label.text = [self nowDateString];
        
        _dateLabel = label;
    }
    return _dateLabel;
}

- (UILabel *)soupLabel {
    if (!_soupLabel) {
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = UIColor.whiteColor;
        label.numberOfLines = 0;
        label.alpha = 0;
        
        label.text = _model.daily_soup;
        
        _soupLabel = label;
    }
    return _soupLabel;
}

@end
