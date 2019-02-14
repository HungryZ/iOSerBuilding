//
//  AnimationViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/2/14.
//
// https://www.jianshu.com/p/9fa025c42261

#define angle2Radio(angle) ((angle) * M_PI / 180.0)

#import "AnimationViewController.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /****************************************************
     UIView 动画
     ****************************************************/
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(50, NaviBarHeight + 50, 100, 61.8)];
    view1.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view1];
    
    // anchorPoint称为"定位点"，它决定着CALayer身上的哪个点会在position属性所指的位置。
    // 它的x、y取值范围都是0~1，默认值为(0.5, 0.5)
    view1.layer.anchorPoint = CGPointMake(1, 1);
    [UIView animateWithDuration:5 animations:^{
        view1.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(170, NaviBarHeight + 50, 100, 61.8)];
    view2.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view2];
    
    view2.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [UIView animateWithDuration:5 animations:^{
        view2.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    
    UIView * view3 = [[UIView alloc] initWithFrame:CGRectMake(290, NaviBarHeight + 50, 100, 61.8)];
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
    anim.repeatCount = MAXFLOAT;
    //动画提交时,会自动删除动画
    anim.removedOnCompletion = NO;
    //设置动画最后保持状态
    anim.fillMode = kCAFillModeForwards;
    //添加动画对象
    [view4.layer addAnimation:anim forKey:nil];
    
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
    
    CALayer* aniLayer = [CALayer layer];
    aniLayer.backgroundColor = [UIColor redColor].CGColor;
    aniLayer.position = CGPointMake(0, 0);
    aniLayer.bounds = CGRectMake(0, 0, 100, 61.8);
    aniLayer.cornerRadius = 4;
    [self.view.layer addSublayer:aniLayer];
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 450)];
    CGPoint endPoint = CGPointMake(305, 450);
    [path addQuadCurveToPoint:endPoint controlPoint:CGPointMake(ScreenWidth / 2, 300)];
    [path closePath];
    CAKeyframeAnimation* keyFrameAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAni.repeatCount = NSIntegerMax;
    keyFrameAni.path = path.CGPath;
    keyFrameAni.duration = 3;
//    keyFrameAni.beginTime = CACurrentMediaTime() + 1;
    [aniLayer addAnimation:keyFrameAni forKey:@"keyFrameAnimation"];
    
}

@end
