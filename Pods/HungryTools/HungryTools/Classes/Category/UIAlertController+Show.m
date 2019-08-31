//
//  UIAlertController+Show.m
//  HungryTools
//
//  Created by 张海川 on 2019/6/19.
//  Copyright © 2019 张海川. All rights reserved.
//

#import "UIAlertController+Show.h"

@implementation UIAlertController (Show)

/** 获取当前控制器 */
+ (UIViewController *)currentViewController {
    // 获得当前活动窗口的根视图
    UIViewController * vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
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

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmBlock:(ConfirmBlock)confirm {
    
    UIAlertController * alertC = [self alertControllerWithTitle:title message:message  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (confirm) {
            confirm();
        }
    }];
    [alertC addAction:confirmAction];
    
    [[self currentViewController] presentViewController:alertC animated:YES completion:nil];
}

@end
