//
//  ViewTransitionController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/2/15.
//

#import "ViewTransitionController.h"

@interface ViewTransitionController ()

@property (strong, nonatomic) UIImageView *imageV;

@end

@implementation ViewTransitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageV = [UIImageView new];
    self.imageV.image = [UIImage imageNamed:@"0.JPG"];
    self.imageV.userInteractionEnabled = YES;
    self.imageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(NaviBarHeight, 0, 0, 0));
    }];
    //添加手势
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageV addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imageV addGestureRecognizer:rightSwipe];
    
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
        NSString *imageName = [NSString stringWithFormat:@"%d.JPG",_imageIndex];
        self.imageV.image = [UIImage imageNamed:imageName];
        
        dir = @"fromRight";
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        
        _imageIndex--;
        if (_imageIndex < 0) {
            _imageIndex = 2;
        }
        NSString *imageName = [NSString stringWithFormat:@"%d.JPG",_imageIndex];
        self.imageV.image = [UIImage imageNamed:imageName];
        
        dir = @"fromLeft";
    }
    
    //添加动画
    CATransition *anim = [CATransition animation];
    //设置转场类型
    anim.type = @"cube";
    //设置转场的方向
    anim.subtype = dir;
    
    anim.duration = 0.5;
    //动画从哪个点开始
    //        anim.startProgress = 0.2;
    //        anim.endProgress = 0.8;
    
    [self.imageV.layer addAnimation:anim forKey:nil];
    
}

@end
