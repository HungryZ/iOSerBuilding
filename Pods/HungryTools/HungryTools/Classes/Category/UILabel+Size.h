//
//  UILabel+Size.h
//  HungryTools
//
//  Created by 张海川 on 2019/7/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Size)

/// 单行文本宽度
@property (nonatomic, assign, readonly) float textWidth;
/// 多行普通文本高度
- (float)textHeightWithWidth:(float)width;
/// 多行富文本高度（需先赋值 attributedText 属性）
- (float)attributedTextHeightWithWidth:(float)width;

@end

NS_ASSUME_NONNULL_END
