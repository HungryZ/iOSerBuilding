//
//  NSString+Check.h
//  HungryTools
//
//  Created by 张海川 on 2019/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Check)

- (BOOL)checkWithRegexString:(NSString *)regexString;

- (BOOL)isPhoneNumber;

- (BOOL)isEmail;

- (BOOL)isPassword;

- (NSString *)phoneFormat;

@end

NS_ASSUME_NONNULL_END
