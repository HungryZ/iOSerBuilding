//
//  UIView+Initializer.m
//  HungryTools
//
//  Created by 张海川 on 2019/5/22.
//  Copyright © 2019 张海川. All rights reserved.
//

#import "UIView+Initializer.h"

@implementation UIView (Initializer)

+ (instancetype)viewWithBackgroundColor:(UIColor *)color {
    UIView * view = [UIView new];
    view.backgroundColor = color;
    
    return view;
}

@end
