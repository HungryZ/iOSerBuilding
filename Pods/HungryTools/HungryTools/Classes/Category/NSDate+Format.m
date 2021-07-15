//
//  NSDate+Format.m
//  HungryTools
//
//  Created by 张海川 on 2020/8/29.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)

/*
 yyyy-MM-dd HH:mm:ss
 yyyy.MM.dd EEEE
 */
- (NSString *)toFormat:(NSString *)format {
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:format];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    
    return [dateFormatter stringFromDate:self];
}

- (NSDate *)cc_dateByMovingToBeginningOfDay {
  unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
  NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
  [parts setHour:0];
  [parts setMinute:0];
  [parts setSecond:0];
  return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

@end
