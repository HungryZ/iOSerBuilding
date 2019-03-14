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

@property (nonatomic, strong) UIImageView * loadingImgView;

@property (nonatomic, strong) CALayer * aniLayer;

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
    _aniLayer = [CALayer layer];
    _aniLayer.backgroundColor = [UIColor redColor].CGColor;
    _aniLayer.position = CGPointMake(0, 0);
    _aniLayer.bounds = CGRectMake(0, 0, 100, 61.8);
    _aniLayer.cornerRadius = 4;
    [self.view.layer addSublayer:_aniLayer];
    
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

@end

/*
 Core Animation(核心动画) 中KeyPath的取值
 作者：pandaApe
 链接：https://www.jianshu.com/p/71c880498d7a
 来源：简书
 简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
 
 一、可动画属性
 1. 几何属性 (Geometry Properties)
 
 
 
 Field Key Path
 Remark
 En Description
 
 
 
 
 transform.rotation.x
 按x轴旋转的弧度
 Set to an NSNumber object whose value is the rotation, in radians, in the x axis.
 
 
 transform.rotation.y
 按y轴旋转的弧度
 Set to an NSNumber object whose value is the rotation, in radians, in the y axis.
 
 
 transform.rotation.z
 按z轴旋转的弧度
 Set to an NSNumber object whose value is the rotation, in radians, in the z axis.
 
 
 transform.rotation
 按z轴旋转的弧度, 和transform.rotation.z效果一样
 Set to an NSNumber object whose value is the rotation, in radians, in the z axis. This field is identical to setting the rotation.z field.
 
 
 transform.scale.x
 在x轴按比例放大缩小
 Set to an NSNumber object whose value is the scale factor for the x axis.
 
 
 transform.scale.y
 在x轴按比例放大缩小
 Set to an NSNumber object whose value is the scale factor for the y axis.
 
 
 transform.scale.z
 在z轴按比例放大缩小
 Set to an NSNumber object whose value is the scale factor for the z axis.
 
 
 transform.scale
 按比例放大缩小
 Set to an NSNumber object whose value is the average of all three scale factors.
 
 
 transform.translation.x
 沿x轴平移
 Set to an NSNumber object whose value is the translation factor along the x axis.
 
 
 transform.translation.y
 沿y轴平移
 Set to an NSNumber object whose value is the translation factor along the y axis.
 
 
 transform.translation.z
 沿z轴平移
 Set to an NSNumber object whose value is the translation factor along the z axis.
 
 
 transform.translation
 x,y 坐标均发生改变
 Set to an NSValue object containing an NSSize or CGSize data type. That data type indicates the amount to translate in the x and y axis.
 
 
 transform
 CATransform3D 4*4矩阵
 
 
 
 bounds
 layer大小
 
 
 
 position
 layer位置
 
 
 
 frame
 不支持 frme 属性
 computed from the bounds and position and is NOT animatable
 
 
 anchorPoint
 锚点位置
 
 
 
 cornerRadius
 圆角大小
 
 
 
 zPosition
 z轴位置
 
 
 
 
 
 2.背景属性 (Background Properties)
 
 
 
 Field Key Path
 Remark
 En Description
 
 
 
 
 backgroundColor
 背景颜色
 
 
 
 
 
 3.Layer内容 (Layer Content)
 
 
 
 Field Key Path
 Remark
 En Description
 
 
 
 
 contents
 Layer内容，呈现在背景颜色之上
 
 
 
 contentsRect
 
 The rectangle, in the unit coordinate space, that defines the portion of the layer’s contents that should be used.
 
 
 masksToBounds
 
 setting the layer’s masksToBounds property to YES does cause the layer to clip to its corner radius
 
 
 
 4.子Layer内容 (Sublayers Content)
 
 
 
 Field Key Path
 Remark
 En Description
 
 
 
 
 sublayers
 子Layer数组
 
 
 sublayerTransform
 子Layer的Transform
 Specifies the transform to apply to sublayers when rendering.
 
 
 
 5.边界属性 (Border Attributes)
 
 
 
 Field Key Path
 Remark
 En Description
 
 
 
 
 borderColor
 
 
 
 
 borderWidth
 
 
 
 
 
 
 6.阴影属性 (Shadow Properties)
 
 
 
 Field Key Path
 Remark
 En Description
 
 
 
 
 shadowColor
 阴影颜色
 
 
 
 shadowOffset
 阴影偏移距离
 
 
 
 shadowOpacity
 阴影透明度
 
 
 
 shadowRadius
 阴影圆角
 
 
 
 shadowPath
 阴影路径
 
 
 
 
 
 7.透明度 (Opacity Property)
 
 
 
 Field Key Path
 Remark
 En Description
 
 
 
 
 opacity
 透明度
 
 
 
 hiden
 
 
 
 
 
 
 8.遮罩 (Mask Properties)
 
 
 
 Field Key Path
 Remark
 En Description
 
 
 
 
 mask
 
 
 
 
 
 
 9.ShapeLayer属性 (ShapeLayer)
 
 
 
 Field Key Path
 Remark
 En Description
 
 
 
 
 fillColor
 
 
 
 
 strokeColor
 
 
 
 
 strokeStart
 从无到有
 
 
 
 strokeEnd
 从有到无
 
 
 
 lineWidth
 路径的线宽
 
 
 
 miterLimit
 相交长度的最大值
 
 
 
 lineDashPhase
 虚线样式
 

 */
