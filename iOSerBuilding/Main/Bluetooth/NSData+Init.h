//
//  NSData+Init.h
//  iOSerBuilding
//
//  Created by 张海川 on 2022/3/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Init)

+ (NSData *)dataFromHexString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
