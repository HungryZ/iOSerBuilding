//
//  UIImage+Chameleon.m
//  HungryTools
//
//  Created by 张海川 on 2019/3/19.
//

#import "UIImage+Chameleon.h"

@implementation UIImage (Chameleon)

+ (UIImage *)imageWithColors:(NSArray<UIColor *> *)colors {
    return [self imageWithColors:colors direction:DirectionTypeLeftToRight size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColors:(NSArray<UIColor *> *)colors direction:(DirectionType)direction {
    return [self imageWithColors:colors direction:direction size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColors:(NSArray<UIColor *> *)colors direction:(DirectionType)direction size:(CGSize)size {
     
     CGPoint startPoint, endPoint;
     switch (direction) {
         case DirectionTypeTopToBottom:
             startPoint = CGPointMake(0.5, 0);
             endPoint   = CGPointMake(0.5, 1);
             break;
         case DirectionTypeLeftToRight:
             startPoint = CGPointMake(0, 0.5);
             endPoint   = CGPointMake(1, 0.5);
             break;
         case DirectionTypeUpleftToLowright:
             startPoint = CGPointMake(0, 0);
             endPoint   = CGPointMake(1, 1);
             break;
         case DirectionTypeUprightToLowleft:
             startPoint = CGPointMake(1, 0);
             endPoint   = CGPointMake(0, 1);
             break;
     }
     
     CAGradientLayer * layer = [CAGradientLayer new];
     layer.startPoint = startPoint;
     layer.endPoint = endPoint;
     layer.colors = @[(__bridge id)colors[0].CGColor, (__bridge id)colors[1].CGColor];
     layer.frame = CGRectMake(0, 0, size.width, size.height);
     layer.locations = @[@0, @1];
     UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, 0.0);
     [layer renderInContext:UIGraphicsGetCurrentContext()];
     
     UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     return image;
 }

@end
