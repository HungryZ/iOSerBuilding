//
//  UIButton+Initializer.h
//  HungryTools
//
//  Created by 张海川 on 2019/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Initializer)

+ (instancetype)buttonWithThemeTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action;

+ (instancetype)buttonWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                       fontSize:(float)fontSize
                   cornerRadius:(float)cornerRadius
                backgroundColor:(nullable UIColor *)backgroundColor
                         target:(nullable id)target
                         action:(nullable SEL)action;

+ (instancetype)buttonWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                       fontSize:(float)fontSize
                   cornerRadius:(float)cornerRadius;

+ (instancetype)buttonWithTitle:(nullable NSString *)title
                     titleColor:(nullable UIColor *)titleColor
                       fontSize:(float)fontSize
                         target:(nullable id)target
                         action:(nullable SEL)action;

+ (instancetype)buttonWithImageName:(NSString *)imageName
                             target:(nullable id)target
                             action:(nullable SEL)action;


/// 只做了对Normal和Selected的支持
- (void)setFont:(UIFont *)font forState:(UIControlState)state;


@end

NS_ASSUME_NONNULL_END
