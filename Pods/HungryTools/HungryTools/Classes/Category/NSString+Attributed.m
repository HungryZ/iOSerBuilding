//
//  NSString+Attributed.m
//  HungryTools
//
//  Created by 张海川 on 2019/5/14.
//

#import "NSString+Attributed.h"

@implementation NSString (Attributed)

- (NSString *)rangeToString:(NSRange)range {
    return [NSString stringWithFormat:@"(%zd,%zd)", range.location, range.length];
}

- (NSRange)stringToRange:(NSString *)rangeString {
    rangeString = [rangeString substringFromIndex:1];
    rangeString = [rangeString substringToIndex:rangeString.length - 1];
    NSArray * array = [rangeString componentsSeparatedByString:@","];
    int location = [array[0] intValue];
    int length = [array[1] intValue];
    
    return NSMakeRange(location, length);
}

- (NSMutableAttributedString *)addAttributes:(NSDictionary *)dictionary {
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    
    if (dictionary[@"color"] && dictionary[@"colorRange"]) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:dictionary[@"color"] range:[self stringToRange:dictionary[@"colorRange"]]];
    }
    
    if (dictionary[@"fontSize"] && dictionary[@"fontSizeRange"]) {
        UIFont * font = [UIFont systemFontOfSize:[dictionary[@"fontSize"] floatValue]];
        [attributedString addAttribute:NSFontAttributeName value:font range:[self stringToRange:dictionary[@"fontSizeRange"]]];
    }
    
    if (dictionary[@"lineSpacing"]) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:[dictionary[@"lineSpacing"] floatValue]];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    }
    
    return attributedString;
}

- (NSMutableAttributedString *)addAttributeColor:(UIColor *)color range:(NSRange)range {
    return [self addAttributes:@{
                                 @"color" : color,
                                 @"colorRange" : [self rangeToString:range],
                                 }];
}

- (NSMutableAttributedString *)addAttributeFontSize:(float)fontSize range:(NSRange)range {
    return [self addAttributes:@{
                                 @"fontSize" : @(fontSize),
                                 @"fontSizeRange" : [self rangeToString:range],
                                 }];
}

- (NSMutableAttributedString *)setLineSpacing:(float)lineSpacing {
    return [self addAttributes:@{
                                 @"lineSpacing" : @(lineSpacing)
                                 }];
}

@end
