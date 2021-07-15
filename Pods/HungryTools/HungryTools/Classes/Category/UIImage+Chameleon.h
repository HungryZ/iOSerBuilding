//
//  UIImage+Chameleon.h
//  HungryTools
//
//  Created by 张海川 on 2019/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DirectionType) {
    DirectionTypeTopToBottom,            //从上到下
    DirectionTypeLeftToRight,            //从左到右
    DirectionTypeUpleftToLowright,       //左上到右下
    DirectionTypeUprightToLowleft        //右上到左下
};

@interface UIImage (Chameleon)

/// 生成渐变色图片，方向从左到右
+ (UIImage *)imageWithColors:(NSArray<UIColor *> *)colors;

+ (UIImage *)imageWithColors:(NSArray<UIColor *> *)colors direction:(DirectionType)direction;

+ (UIImage *)imageWithColors:(NSArray<UIColor *> *)colors direction:(DirectionType)direction size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
