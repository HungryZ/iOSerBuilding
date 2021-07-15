//
//  NSDate+Format.h
//  HungryTools
//
//  Created by 张海川 on 2020/8/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Format)

/*
 yyyy-MM-dd HH:mm:ss
 yyyy.MM.dd EEEE
 */
- (NSString *)toFormat:(NSString *)format;

- (NSDate *)cc_dateByMovingToBeginningOfDay;

@end

NS_ASSUME_NONNULL_END
