//
//  InteractiveTransition2.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/7/1.
//

#import "InteractiveTransition2.h"

@implementation InteractiveTransition2

- (void)setController:(UIViewController *)controller {
    _controller = controller;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [_controller.view addGestureRecognizer:pan];
}

//关键的手势过渡的过程
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    
    CGPoint translation = [panGesture translationInView:panGesture.view];
    CGFloat percentComplete = 0.0;
    
    if (translation.x < 0) {
        return; // 左滑
    }
    
    //左右滑动的百分比
    percentComplete = translation.x / (_controller.view.frame.size.width);
    //    percentComplete = fabs(percentComplete);  // 绝对值
    NSLog(@"%f",percentComplete);
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            _isInteractive = YES;
            [_controller.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置转场过程动画进行的百分比，然后系统会根据百分比自动布局动画控件，不用我们控制了
            [self updateInteractiveTransition:percentComplete];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            _isInteractive = NO;
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作，转场失败
            if (percentComplete > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
    
}

@end
