//
//  NSString+Attributed.m
//  clq
//
//  Created by 张海川 on 2019/5/14.
//  Copyright © 2019 封建. All rights reserved.
//

#import "NSString+Attributed.h"

@implementation NSString (Attributed)

- (NSMutableAttributedString *)setLineSpacing:(float)lineSpacing {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    
    return attributedString;
}

@end
