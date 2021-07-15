//
//  UIImage+Compress.h
//  Community
//
//  Created by 张海川 on 2020/4/2.
//  Copyright © 2020 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Compress)

/// 压缩图片质量，如果图片太大压缩不到目标大小，则减小尺寸重绘再压缩
/// @param size 目标大小，单位MB
- (NSData *)compressDataToSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
