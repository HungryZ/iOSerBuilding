//
//  UIButton+Initializer.h
//  JibeiPro
//
//  Created by 张海川 on 2019/1/14.
//  Copyright © 2019 LinZi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Initializer)

+ (instancetype _Nullable )buttonWithTitle:(NSString *)title
                                titleColor:(UIColor *)titleColor
                                  fontSize:(float)fontSize
                              cornerRadius:(float)cornerRadius
                            backgrondColor:(nullable UIColor *)backgrondColor
                                    target:(nullable id)target
                                    action:(nullable SEL)action;

+ (instancetype _Nullable )buttonWithTitle:(NSString *)title
                                titleColor:(UIColor *)titleColor
                                  fontSize:(float)fontSize
                              cornerRadius:(float)cornerRadius;

+ (instancetype _Nullable )buttonWithThemeTitle:(NSString *)title target:(nullable id)target action:(nullable SEL)action;

@end
