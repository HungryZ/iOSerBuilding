//
//  PageViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/3/20.
//

#define ImageWidth AdaptedWidth(355)

#import "PageViewController.h"

@interface PageViewController ()

@property (nonatomic, strong) NSArray *         titleArray;
@property (nonatomic, strong) NSArray *         imageArray;
@property (nonatomic, strong) NSArray *         imageHeightArray;

@property (nonatomic, strong) UILabel *         titleLabel;
@property (nonatomic, strong) UIScrollView *    scrollView;
@property (nonatomic, strong) UIImageView *     imageView;
@property (nonatomic, strong) UIPageControl *   pageControl;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addViews];
}

- (void)addViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NaviBarHeight);
        make.centerX.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(31);
        make.width.mas_equalTo(ImageWidth);
        make.centerX.bottom.mas_equalTo(0);
    }];
    
}
static int _imageIndex = 0;
- (void)swipe:(UISwipeGestureRecognizer *)swipe {
    //转场代码与转场动画必须得在同一个方法当中.
    NSString *dir = nil;
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        _imageIndex++;
        if (_imageIndex > 2) {
            _imageIndex = 0;
        }
        dir = @"fromRight";
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        
        _imageIndex--;
        if (_imageIndex < 0) {
            _imageIndex = 2;
        }
        dir = @"fromLeft";
    }
    
    CGRect frame = CGRectMake(0, 0, ImageWidth, [self.imageHeightArray[_imageIndex] floatValue]);
    self.imageView.image = self.imageArray[_imageIndex];
    self.imageView.frame = frame;
    self.scrollView.contentSize = frame.size;
    self.pageControl.currentPage = _imageIndex;
    
    //添加动画
    CATransition *anim = [CATransition animation];
    //设置转场类型
    anim.type = @"push";
    //设置转场的方向
    anim.subtype = dir;
    
    anim.duration = 0.3;
    //动画从哪个点开始
    //        anim.startProgress = 0.2;
    //        anim.endProgress = 0.8;
    
    [self.imageView.layer addAnimation:anim forKey:nil];
    
}

#pragma mark - Getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:24.f];
        _titleLabel.text = self.titleArray[0];
    }
    return _titleLabel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        [_scrollView addSubview:self.imageView];
        _scrollView.contentSize = CGSizeMake(ImageWidth, [self.imageHeightArray[0] floatValue]);
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:self.imageArray[0]];
        _imageView.frame = CGRectMake(0, 0, ImageWidth, [self.imageHeightArray[0] floatValue]);
        _imageView.userInteractionEnabled = YES;
        //添加手势
        UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [_imageView addGestureRecognizer:leftSwipe];
        
        UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [_imageView addGestureRecognizer:rightSwipe];
    
    }
    return _imageView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[
                        @"黑名单风险检测",
                        @"运营商风险检测",
                        @"信用卡测评",
                        ];
    }
    return _titleArray;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        
        _imageArray = @[
                        [UIImage imageNamed:@"sample_blacklist"],
                        [UIImage imageNamed:@"sample_carrier"],
                        [UIImage imageNamed:@"sample_creditcard"],
                        ];
    }
    return _imageArray;
}

- (NSArray *)imageHeightArray {
    if (!_imageHeightArray) {
        _imageHeightArray = @[@(AdaptedWidth(2087)), @(AdaptedWidth(1257)), @(AdaptedWidth(1088))];
    }
    return _imageHeightArray;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

@end
