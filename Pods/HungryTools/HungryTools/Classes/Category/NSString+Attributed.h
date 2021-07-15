//
//  NSString+Attributed.h
//  HungryTools
//
//  Created by 张海川 on 2019/5/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Attributed)

- (NSMutableAttributedString *)setLineSpacing:(float)lineSpacing;

- (NSMutableAttributedString *)addAttributeColor:(UIColor *)color range:(NSRange)range;

- (NSMutableAttributedString *)addAttributeFontSize:(float)fontSize range:(NSRange)range;

/**
 dictionary 示例：
 @{
    @"color"            : UIColor.redColor,
    @"colorRange"       : @"(2,3)",
    @"fontSize"         : @(14),
    @"fontSizeRange"    : @"(2,3)",
    @"lineSpacing"      : @(6)
 }
 */
- (NSMutableAttributedString *)addAttributes:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
