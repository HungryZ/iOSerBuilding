//
//  UIImage+Compress.m
//  Community
//
//  Created by 张海川 on 2020/4/2.
//  Copyright © 2020 ChinaMobile. All rights reserved.
//

#import "UIImage+Compress.h"

@implementation UIImage (Compress)

- (NSData *)compressDataToSize:(CGFloat)size {
    
    int aimBytes = size * (1 << 20);
    CGFloat min = 0, max = 1;
    
    NSData *data = UIImageJPEGRepresentation(self, 1);
    if (data.length <= aimBytes) {
        return data;
    }
    
    for (int i = 0; i < 6; i++) {
        CGFloat quality = (min + max) / 2;
        data = UIImageJPEGRepresentation(self, quality);
        if (data.length > aimBytes) {
            max = quality;
        } else if (data.length < aimBytes * 0.9) {
            min = quality;
        } else {
            break;
        }
    }
    
    if (data.length <= aimBytes) {
        return data;
    }
    
    UIImage *newImage = self;
    while (data.length > aimBytes) {
        CGFloat ratio = (CGFloat)aimBytes / data.length;
        CGRect rect = CGRectMake(0, 0, (int)(newImage.size.width * sqrt(ratio)), (int)(newImage.size.height * sqrt(ratio)));
        UIGraphicsBeginImageContext(rect.size);
        [newImage drawInRect:rect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(newImage, (min + max) / 2);
    }
    
    return data;
}

@end
