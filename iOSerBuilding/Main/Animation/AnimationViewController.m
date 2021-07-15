//
//  AnimationViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/2/14.
//
// https://www.jianshu.com/p/9fa025c42261

#define angle2Radio(angle) ((angle) * M_PI / 180.0)

#import "AnimationViewController.h"

@interface AnimationViewController () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView * loadingImgView;

@property (nonatomic, strong) CALayer * aniLayer;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /****************************************************
     UIView 动画
     ****************************************************/
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(50, kNaviHeight + 50, 100, 61.8)];
    view1.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view1];
    
    // anchorPoint称为"定位点"，它决定着CALayer身上的哪个点会在position属性所指的位置。
    // 它的x、y取值范围都是0~1，默认值为(0.5, 0.5)
    view1.layer.anchorPoint = CGPointMake(1, 1);
    [UIView animateWithDuration:5 animations:^{
        view1.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(170, kNaviHeight + 50, 100, 61.8)];
    view2.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view2];
    
    view2.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [UIView animateWithDuration:5 animations:^{
        view2.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
    UIView * view3 = [[UIView alloc] initWithFrame:CGRectMake(290, kNaviHeight + 50, 100, 61.8)];
    view3.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view3];
    
    view3.layer.anchorPoint = CGPointMake(0, 0);
    [UIView animateWithDuration:5 animations:^{
        view3.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
    
    /****************************************************
     Core Animation 核心动画
     ****************************************************/
    
    // 平移
    UIView * view4 = [UIView new];
    view4.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(300);
        make.right.mas_equalTo(-50);
        make.size.mas_equalTo(CGSizeMake(100, 61.8));
    }];
    CABasicAnimation *anim = [CABasicAnimation animation];
    //设置动画属性
    anim.keyPath = @"position.x";
    anim.toValue = @100;
    anim.duration = 3;
//    anim.repeatCount = MAXFLOAT;
    //动画提交时,会自动删除动画
    anim.removedOnCompletion = NO;
    //设置动画最后保持状态
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    //添加动画对象
    [view4.layer addAnimation:anim forKey:@"1111"];
    
    
    // 抖动
    UIView * view5 = [UIView new];
    view5.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view5];
    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view4);
        make.right.mas_equalTo(-50);
        make.size.mas_equalTo(CGSizeMake(100, 61.8));
    }];
    //帧动画
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animation];
    anim2.keyPath = @"transform.rotation";
    anim2.values = @[@(angle2Radio(-5)),@(angle2Radio(5)),@(angle2Radio(-5))];
    anim2.repeatCount = NSIntegerMax;
    //自动反转
//    anim2.autoreverses = YES;
    [view5.layer addAnimation:anim2 forKey:nil];
    
    // Bezier曲线
    _aniLayer = [CALayer layer];
    _aniLayer.backgroundColor = [UIColor redColor].CGColor;
    _aniLayer.position = CGPointMake(0, 0);
    _aniLayer.bounds = CGRectMake(0, 0, 100, 61.8);
    _aniLayer.cornerRadius = 4;
    [self.view.layer addSublayer:_aniLayer];
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 450)];
    CGPoint endPoint = CGPointMake(305, 450);
    [path addQuadCurveToPoint:endPoint controlPoint:CGPointMake(kScreenWidth / 2, 300)];
    [path closePath];
    
    CAKeyframeAnimation* keyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAni.repeatCount = NSIntegerMax;
    keyFrameAni.path = path.CGPath;
    keyFrameAni.duration = 3;
//    keyFrameAni.beginTime = CACurrentMediaTime() + 1;
    [_aniLayer addAnimation:keyFrameAni forKey:@"keyFrameAnimation"];
    
    //帧动画
    CAKeyframeAnimation *anim3 = [CAKeyframeAnimation animation];
    anim3.keyPath = @"transform.rotation";
//    anim3.values = @[@(angle2Radio(5)), @(angle2Radio(10)), @(angle2Radio(100)), @(angle2Radio(120)), @(angle2Radio(180)), @(angle2Radio(250)), @(angle2Radio(360))];
    // 弧度制
    anim3.values = @[@0, @(M_PI/20), @(M_PI/18), @(M_PI/14), @(M_PI/7), @M_PI];
    anim3.keyTimes = @[@0, @1, @1, @1, @0.5, @0.5];
    anim3.repeatCount = NSIntegerMax;
//    anim3.duration = 3;
//    anim3.autoreverses = YES;
    [_aniLayer addAnimation:anim3 forKey:nil];
    
    
    
    
    _loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 500, 72, 72)];
    // imageView 默认关闭
    _loadingImgView.userInteractionEnabled = YES;
    _loadingImgView.backgroundColor = [UIColor blueColor];
    NSMutableArray *imgArr = [NSMutableArray array];
    for (int i = 0; i < 22; i++) {
        [imgArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading%d", i + 1]]];

    }
    _loadingImgView.animationImages = imgArr;
    _loadingImgView.animationDuration = 1.1;
    
    UITapGestureRecognizer * tap = [UITapGestureRecognizer new];
    // 连续敲击次数
//    tap.numberOfTapsRequired = 1;
    // 需要的手指数
//    tap.numberOfTouchesRequired = 1;
    [tap addTarget:self action:@selector(tapAction111)];
    [_loadingImgView addGestureRecognizer:tap];
    
    [self.view addSubview:_loadingImgView];
    [_loadingImgView startAnimating];
}

- (void)tapAction111 {
    
    if ([_loadingImgView isAnimating]) {
        [_loadingImgView stopAnimating];
        
        /*
         所有的非Root Layer，也就是手动创建的CALayer对象，都存在着隐式动画
         当对非Root Layer的部分属性进行修改时，默认会自动产生一些动画效果，这些属性称为Animatable Properties(可动画属性)。
         */
        _aniLayer.backgroundColor = [UIColor blueColor].CGColor;
        _aniLayer.bounds = CGRectMake(0, 0, 10, 10);
    } else {
        [_loadingImgView startAnimating];
        
        // 关闭隐式动画
        [CATransaction setDisableActions:YES];
        
        _aniLayer.backgroundColor = [UIColor redColor].CGColor;
        _aniLayer.bounds = CGRectMake(0, 0, 100, 61.8);
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

@end



/*
 Core Animation(核心动画) 中KeyPath的取值
 作者：pandaApe
 链接：https://www.jianshu.com/p/71c880498d7a
 来源：简书
 简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
 */
