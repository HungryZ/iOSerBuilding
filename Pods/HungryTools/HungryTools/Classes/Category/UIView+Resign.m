//
//  UIView+Resign.m
//  StrategyPlus
//
//  Created by 张海川 on 2019/5/22.
//  Copyright © 2019 张海川. All rights reserved.
//

#import "UIView+Resign.h"

@implementation UIView (Resign)

- (void)resignAllResponder {
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [(UITextField *)view resignFirstResponder];
            continue;
        }
        if ([view isKindOfClass:[UIView class]]) {
            [view resignAllResponder];
        }
    }
}

@end
