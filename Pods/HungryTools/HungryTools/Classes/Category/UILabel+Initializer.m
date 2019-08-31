//
//  UILabel+Initializer.m
//  HungryTools
//
//  Created by 张海川 on 2019/1/14.
//

#import "UILabel+Initializer.h"

@implementation UILabel (Initializer)

+ (instancetype)labelWithFontSize:(float)size textColor:(UIColor *)color text:(NSString *)text {
    
    UILabel * label = [self new];
    label.font = [UIFont systemFontOfSize:size];
    
    if (color) {
        label.textColor = color;
    }
    
    if (text) {
        label.text = text;
    }
    
    return label;
}

+ (instancetype)labelWithFontSize:(float)size textColor:(UIColor *)color {
    
    return [self labelWithFontSize:size textColor:color text:nil];
}

+ (instancetype)labelWithFontSize:(float)size text:(NSString *)text {
    
    return [self labelWithFontSize:size textColor:[UIColor blackColor] text:text];
}

+ (instancetype)labelWithFontSize:(float)size {
    
    return [self labelWithFontSize:size textColor:nil text:nil];
}

@end
