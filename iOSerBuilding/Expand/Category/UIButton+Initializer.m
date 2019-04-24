//
//  UIButton+Initializer.m
//  JibeiPro
//
//  Created by 张海川 on 2019/1/14.
//  Copyright © 2019 LinZi. All rights reserved.
//

#import "UIButton+Initializer.h"

@implementation UIButton (Initializer)

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(float)fontSize cornerRadius:(float)cornerRadius backgrondColor:(UIColor *)backgrondColor target:(id)target action:(SEL)action {
    
    UIButton * button = [self buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    if (cornerRadius) {
        button.layer.cornerRadius = cornerRadius;
    }
    
    if (backgrondColor) {
        button.backgroundColor = backgrondColor;
    }
    
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(float)fontSize cornerRadius:(float)cornerRadius {
    
    return [self buttonWithTitle:title titleColor:titleColor fontSize:fontSize cornerRadius:cornerRadius backgrondColor:nil target:nil action:nil];
}

+ (instancetype)buttonWithThemeTitle:(NSString *)title target:(id)target action:(SEL)action {
    
    return [self buttonWithTitle:title titleColor:[UIColor whiteColor] fontSize:16.f cornerRadius:5.f backgrondColor:ThemeColor target:target action:action];
}

@end
