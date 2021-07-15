//
//  UILabel+Initializer.h
//  HungryTools
//
//  Created by 张海川 on 2019/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Initializer)

+ (instancetype)labelWithFont:(id)font textColor:(nullable UIColor *)color text:(nullable NSString *)text;
+ (instancetype)labelWithFont:(id)font textColor:(nullable UIColor *)color;
+ (instancetype)labelWithFont:(id)font text:(nullable NSString *)text;
+ (instancetype)labelWithFont:(id)font;

/// 等宽数字字体
+ (instancetype)labelWithMonospacedFontSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
