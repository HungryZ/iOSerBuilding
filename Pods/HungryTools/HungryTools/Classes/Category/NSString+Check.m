//
//  NSString+Check.m
//  HungryTools
//
//  Created by 张海川 on 2019/3/14.
//

#import "NSString+Check.h"

@implementation NSString (Check)

- (BOOL)checkWithRegexString:(NSString *)regexString {
    
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString] evaluateWithObject:self];
}

- (BOOL)isPhoneNumber {
    
    // 表达式中 \ 需用 \\ 转义表示
    // 粗略判断
    return [self checkWithRegexString:@"^1[3-9]\\d{9}$"];
}

- (BOOL)isEmail {
    
    // 看不懂 [-+.]
    // \w 匹配字母、数字、下划线。等价于 [A-Za-z0-9_]
    return [self checkWithRegexString:@"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"];
}

- (BOOL)isPassword {
    return [self checkWithRegexString:@"^(?=.*\\d)(?=.*[A-Za-z]).{6,16}$"];
}

- (NSString *)phoneFormat {
    if (![self isPhoneNumber]) {
        return @"";
    }
    NSString *str1 = [self substringToIndex:3];
    NSString *str2 = [self substringWithRange:NSMakeRange(3, 4)];
    NSString *str3 = [self substringFromIndex:7];
    
    return [NSString stringWithFormat:@"%@ %@ %@", str1, str2, str3];
}

@end
