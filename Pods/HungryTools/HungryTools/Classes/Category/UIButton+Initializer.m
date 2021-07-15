//
//  UIButton+Initializer.m
//  HungryTools
//
//  Created by 张海川 on 2019/1/14.
//

#ifndef ThemeColor
    #define ThemeColor [UIColor colorWithRed:103/255.f green:94/255.f blue:247/255.f alpha:1]
#endif

#ifndef DisableColor
    #define DisableColor [UIColor colorWithRed:255/255.f green:173/255.f blue:173/255.f alpha:1]
#endif

#import "UIButton+Initializer.h"
#import "UIImage+Color.h"
#import <objc/runtime.h>

@implementation UIButton (Initializer)

+ (void)load {
    Method originalMethod = class_getInstanceMethod(self, @selector(setSelected:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(ex_setSelected:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (instancetype)buttonWithThemeTitle:(NSString *)title target:(id)target action:(SEL)action {
    
    UIButton * button = [self buttonWithTitle:title titleColor:[UIColor whiteColor] fontSize:16.f cornerRadius:4.f backgroundColor:nil target:target action:action];
    
    [button setBackgroundImage:[UIImage imageWithColor:DisableColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:ThemeColor] forState:UIControlStateSelected];
    button.clipsToBounds = YES;
    
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(float)fontSize cornerRadius:(float)cornerRadius {
    
    return [self buttonWithTitle:title titleColor:titleColor fontSize:fontSize cornerRadius:cornerRadius backgroundColor:nil target:nil action:nil];
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(float)fontSize target:(id)target action:(SEL)action {
    
    return [self buttonWithTitle:title titleColor:titleColor fontSize:fontSize cornerRadius:0 backgroundColor:nil target:target action:action];
}

+ (instancetype)buttonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIButton * button = [self new];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(float)fontSize cornerRadius:(float)cornerRadius backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action {
    
    UIButton * button = [self buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setAdjustsImageWhenHighlighted:NO];
    [button setAdjustsImageWhenDisabled:NO];
    
    if (cornerRadius) {
        button.layer.cornerRadius = cornerRadius;
    }
    
    if (backgroundColor) {
        button.backgroundColor = backgroundColor;
    }
    
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

- (void)ex_setSelected:(BOOL)selected {
    [self ex_setSelected:selected];
    
    UIFont *font = objc_getAssociatedObject(self, selected ? "selectedFont" : "normalFont");
    if (font) {
        self.titleLabel.font = font;
    }
}

- (void)setFont:(UIFont *)font forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        objc_setAssociatedObject(self, "normalFont", font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (!self.isSelected) {
            self.titleLabel.font = font;
        }
    } else if (state == UIControlStateSelected) {
        objc_setAssociatedObject(self, "selectedFont", font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if (self.isSelected) {
            self.titleLabel.font = font;
        }
    }
}

@end
