//
//  UIButton+Initializer.m
//  HungryTools
//
//  Created by 张海川 on 2019/1/14.
//

#ifndef ThemeColor
    #define ThemeColor [UIColor colorWithRed:255/255.f green:80/255.f blue:74/255.f alpha:1]
#endif

#ifndef DisableColor
    #define DisableColor [UIColor colorWithRed:255/255.f green:173/255.f blue:173/255.f alpha:1]
#endif

#import "UIButton+Initializer.h"

@implementation UIButton (Initializer)

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(float)fontSize cornerRadius:(float)cornerRadius backgrondColor:(UIColor *)backgrondColor target:(id)target action:(SEL)action {
    
    UIButton * button = [self buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setAdjustsImageWhenHighlighted:NO];
    
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
    
    UIButton * button = [self buttonWithTitle:title titleColor:[UIColor whiteColor] fontSize:16.f cornerRadius:4.f backgrondColor:nil target:target action:action];
    
    [button setBackgroundImage:[self imageWithColor:DisableColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:ThemeColor] forState:UIControlStateSelected];
    button.clipsToBounds = YES;
    
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(float)fontSize target:(id)target action:(SEL)action {
    
    return [self buttonWithTitle:title titleColor:titleColor fontSize:fontSize cornerRadius:0 backgrondColor:nil target:target action:action];
}

+ (instancetype)buttonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIButton * button = [self new];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
