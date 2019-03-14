//
//  NSString+Check.h
//  iOSerBuilding
//
//  Created by 张海川 on 2019/3/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Check)

- (BOOL)isPhoneNumber;

- (BOOL)isEmail;

@end

NS_ASSUME_NONNULL_END
