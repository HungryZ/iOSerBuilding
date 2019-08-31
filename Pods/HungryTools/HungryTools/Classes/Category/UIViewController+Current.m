//
//  UIViewController+Current.m
//  HungryTools
//
//  Created by 张海川 on 2019/7/15.
//  Copyright © 2019 张海川. All rights reserved.
//

#import "UIViewController+Current.h"

@implementation UIViewController (Current)

/** 获取当前控制器 */
+ (UIViewController *)currentController {
    // 获得当前活动窗口的根视图
    UIViewController * vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        // 根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController *)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController *)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        } else {
            break;
        }
    }
    return vc;
}

@end
