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

@implementation UITableViewCell (SeparatorLine)

- (BOOL)zhc_showTopSeparatorLine {
    return [objc_getAssociatedObject(self, "zhc_showTopSeparatorLine") boolValue];
}

- (void)setZhc_showTopSeparatorLine:(BOOL)zhc_showTopSeparatorLine {
    
    objc_setAssociatedObject(self, "zhc_showTopSeparatorLine", @(zhc_showTopSeparatorLine), OBJC_ASSOCIATION_ASSIGN);
    
    if (zhc_showTopSeparatorLine) {
        if (![self viewWithTag:10086]) {
            UIView * separatorLine = [UIView new];
            separatorLine.backgroundColor = SeparatorLineColor;
            separatorLine.tag = 10086;
            separatorLine.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:separatorLine];
            
            [self addConstraints:@[
                [NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:self.zhc_separatorLineInset.top],
                [NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.zhc_separatorLineInset.left],
                [NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-self.zhc_separatorLineInset.right],
                [NSLayoutConstraint constraintWithItem:separatorLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:self.zhc_separatorLineHeight],
            ]];
        }
    } else {
        if ([self viewWithTag:10086]) {
            [[self viewWithTag:10086] removeFromSuperview];
        }
    }
}

- (UIEdgeInsets)zhc_separatorLineInset {
    NSValue *value = objc_getAssociatedObject(self, "zhc_separatorLineInset");
    return [value UIEdgeInsetsValue];
}

- (void)setZhc_separatorLineInset:(UIEdgeInsets)zhc_separatorLineInset {
    NSValue *value = [NSValue valueWithUIEdgeInsets:zhc_separatorLineInset];
    objc_setAssociatedObject(self, "zhc_separatorLineInset", value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)zhc_separatorLineHeight {
    return [objc_getAssociatedObject(self, "zhc_separatorLineHeight") floatValue] ?: 0.5;
}

- (void)setZhc_separatorLineHeight:(CGFloat)zhc_separatorLineHeight {
    objc_setAssociatedObject(self, "zhc_separatorLineHeight", @(zhc_separatorLineHeight), OBJC_ASSOCIATION_ASSIGN);
}

@end
