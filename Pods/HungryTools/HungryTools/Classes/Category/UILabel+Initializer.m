//
//  UILabel+Initializer.m
//  HungryTools
//
//  Created by 张海川 on 2019/1/14.
//

#import "UILabel+Initializer.h"

@implementation UILabel (Initializer)

+ (instancetype)labelWithFont:(id)font textColor:(UIColor *)color text:(NSString *)text {
    
    UIFont *realFont;
    if ([font isKindOfClass:UIFont.class]) {
        realFont = font;
    } else if ([font isKindOfClass:NSNumber.class]) {
        realFont = [UIFont systemFontOfSize:[font floatValue]];
    }
    
    UILabel * label = [self new];
    label.font = realFont;
    
    if (color) {
        label.textColor = color;
    }
    
    if (text) {
        label.text = text;
    }
    
    return label;
}

+ (instancetype)labelWithFont:(id)font textColor:(UIColor *)color {
    
    return [self labelWithFont:font textColor:color text:nil];
}

+ (instancetype)labelWithFont:(id)font text:(NSString *)text {
    
    return [self labelWithFont:font textColor:[UIColor blackColor] text:text];
}

+ (instancetype)labelWithFont:(id)font {
    
    return [self labelWithFont:font textColor:nil text:nil];
}

+ (instancetype)labelWithMonospacedFontSize:(CGFloat)size {
    
    UILabel * label = [self new];
    label.font = [UIFont fontWithName:@"Helvetica Neue" size:size];
    
    return label;
}

@end
