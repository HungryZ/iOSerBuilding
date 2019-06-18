//
//  UIButton+Initializer.h
//  JibeiPro
//
//  Created by 张海川 on 2019/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Initializer)

+ (instancetype)buttonWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                       fontSize:(float)fontSize
                   cornerRadius:(float)cornerRadius
                 backgrondColor:(nullable UIColor *)backgrondColor
                         target:(nullable id)target
                         action:(nullable SEL)action;

+ (instancetype)buttonWithThemeTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action;

+ (instancetype)buttonWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                       fontSize:(float)fontSize
                   cornerRadius:(float)cornerRadius;

+ (instancetype)buttonWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                       fontSize:(float)fontSize
                         target:(nullable id)target
                         action:(nullable SEL)action;

+ (instancetype)buttonWithImageName:(NSString *)imageName
                             target:(nullable id)target
                             action:(nullable SEL)action;


@end

NS_ASSUME_NONNULL_END
