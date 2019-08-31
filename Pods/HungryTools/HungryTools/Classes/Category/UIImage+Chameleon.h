//
//  UIImage+Chameleon.h
//  HungryTools
//
//  Created by 张海川 on 2019/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom,            //从上到下
    GradientTypeLeftToRight,            //从左到右
    GradientTypeUpleftToLowright,       //左上到右下
    GradientTypeUprightToLowleft        //右上到左下
    
};

@interface UIImage (Chameleon)

/** 生成渐变色图片 */
+ (UIImage *)imageWithColors:(NSArray*)colors gradientType:(GradientType)gradientType size:(CGSize)imgSize;

@end

NS_ASSUME_NONNULL_END
