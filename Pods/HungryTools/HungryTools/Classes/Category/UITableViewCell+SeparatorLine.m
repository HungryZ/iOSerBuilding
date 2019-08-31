//
//  UITableViewCell+SeparatorLine.m
//  HungryTools
//
//  Created by 张海川 on 2019/5/29.
//  Copyright © 2019 张海川. All rights reserved.
//

#ifndef SeparatorLineColor
    #define SeparatorLineColor  [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1.f]
#endif

#import "UITableViewCell+SeparatorLine.h"
#import <objc/runtime.h>
#import "Masonry.h"

@implementation UITableViewCell (SeparatorLine)

- (BOOL)showSeparatorLine {
    return [objc_getAssociatedObject(self, "showSeparatorLine") boolValue];
}

- (void)setShowSeparatorLine:(BOOL)showSeparatorLine {
    
    objc_setAssociatedObject(self, "showSeparatorLine", @(showSeparatorLine), OBJC_ASSOCIATION_ASSIGN);
    
    if (showSeparatorLine) {
        if (![self viewWithTag:10086]) {
            UIView * separatorLine = [UIView new];
            separatorLine.backgroundColor = SeparatorLineColor;
            separatorLine.tag = 10086;
            [self addSubview:separatorLine];
            [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.mas_equalTo(0);
                make.height.mas_equalTo(0.5);
            }];
        }
    } else {
        if ([self viewWithTag:10086]) {
            [[self viewWithTag:10086] removeFromSuperview];
        }
    }
}

@end
