//
//  UILabel+Initializer.h
//  JibeiPro
//
//  Created by 张海川 on 2019/1/14.
//  Copyright © 2019 LinZi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Initializer)

+ (instancetype)labelWithFontSize:(float)size textColor:(nullable UIColor *)color text:(nullable NSString *)text;
+ (instancetype)labelWithFontSize:(float)size textColor:(UIColor *)color;
+ (instancetype)labelWithFontSize:(float)size text:(NSString *)text;
+ (instancetype)labelWithFontSize:(float)size;

@end

NS_ASSUME_NONNULL_END
