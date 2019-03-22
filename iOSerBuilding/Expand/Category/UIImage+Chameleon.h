//
//  UIImage+Chameleon.h
//  CPAppraisalProduct
//
//  Created by 张海川 on 2019/3/19.
//  Copyright © 2019 CP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
    
};

@interface UIImage (Chameleon)

/** 生成渐变色图片 */
+ (UIImage *)imageWithColors:(NSArray*)colors gradientType:(GradientType)gradientType size:(CGSize)imgSize;

@end

NS_ASSUME_NONNULL_END
