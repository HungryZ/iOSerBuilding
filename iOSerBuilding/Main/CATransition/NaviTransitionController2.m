//
//  NaviTransitionController2.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/7/1.
//

#import "NaviTransitionController2.h"
#import "InteractiveTransition2.h"

@interface NaviTransitionController2 () <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (nonatomic, assign) UINavigationControllerOperation   operation;

@property (nonatomic, strong) InteractiveTransition2 *          transition;

@end

@implementation NaviTransitionController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.JPG"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    _transition = [InteractiveTransition2 new];
    _transition.controller = self;
}

#pragma mark - NavigationController

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    self.operation = operation;
    return self;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    if (_operation == UINavigationControllerOperationPop && _transition.isInteractive) {
        return _transition;
    }
    
    return nil;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.operation == UINavigationControllerOperationPush) {
        //取出转场前后视图控制器上的视图view
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *containerView = [transitionContext containerView];
        
        [containerView addSubview:toView];

        CGRect startFrame = CGRectMake(toView.frame.size.width / 2, toView.frame.size.height / 2, 10, 10);
        
        //通过如下方法计算获取在x和y方向按钮距离边缘的最大值，然后利用勾股定理即可算出最大半径
        CGFloat x = MAX(startFrame.origin.x, containerView.frame.size.width - startFrame.origin.x);
        CGFloat y = MAX(startFrame.origin.y, containerView.frame.size.height - startFrame.origin.y);
        //勾股定理计算半径
        CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
        
        UIBezierPath * startPath = [UIBezierPath bezierPathWithOvalInRect:startFrame];
        UIBezierPath * endPath = [UIBezierPath bezierPathWithArcCenter:startFrame.origin radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        //创建CAShapeLayer进行遮盖
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        //设置layer的path保证动画后layer不会回弹
        maskLayer.path = endPath.CGPath;
        //将maskLayer作为toVC.View的遮盖
        toView.layer.mask = maskLayer;
        //创建路径动画
        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.delegate = self;
        //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
        maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
        maskLayerAnimation.toValue = (__bridge id)((endPath.CGPath));
        maskLayerAnimation.duration = [self transitionDuration:transitionContext];
        //设置淡入淡出
        maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
        [maskLayer addAnimation:maskLayerAnimation forKey:@"enter"];
        
    } else {
        //取出转场前后视图控制器上的视图view
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *containerView = [transitionContext containerView];
        
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
        
        CGRect endFrame = CGRectMake(fromView.frame.size.width / 2, fromView.frame.size.height / 2, 10, 10);
        
        //通过如下方法计算获取在x和y方向按钮距离边缘的最大值，然后利用勾股定理即可算出最大半径
        CGFloat x = MAX(endFrame.origin.x, containerView.frame.size.width - endFrame.origin.x);
        CGFloat y = MAX(endFrame.origin.y, containerView.frame.size.height - endFrame.origin.y);
        //勾股定理计算半径
        CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
        
        UIBezierPath * endPath = [UIBezierPath bezierPathWithOvalInRect:endFrame];
        UIBezierPath * startPath = [UIBezierPath bezierPathWithArcCenter:endFrame.origin radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        
        //创建CAShapeLayer进行遮盖
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        //设置layer的path保证动画后layer不会回弹
        maskLayer.path = endPath.CGPath;
        //将maskLayer作为toVC.View的遮盖
        fromView.layer.mask = maskLayer;
        //创建路径动画
        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.delegate = self;
        //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
        maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
        maskLayerAnimation.toValue = (__bridge id)((endPath.CGPath));
        maskLayerAnimation.duration = [self transitionDuration:transitionContext];
        //设置淡入淡出
        maskLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
        [maskLayer addAnimation:maskLayerAnimation forKey:@"exit"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    NSLog(@"%s", __func__);
    if (flag) {
        NSLog(@"yes");
    } else {
        NSLog(@"no");
    }
    id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toView];
    if (self.operation == UINavigationControllerOperationPush) {
        [transitionContext completeTransition:YES];
        toView.layer.mask = nil;
    } else {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        fromView.layer.mask = nil;
        if([transitionContext transitionWasCancelled]){
            //手势取消
        }else{
            //手势完成
        }
    }
}

@end
