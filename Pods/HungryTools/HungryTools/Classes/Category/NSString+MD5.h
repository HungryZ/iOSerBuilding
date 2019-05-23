//
//  NSString+md5.h
//
//
//  Created by yufajun on 2017/9/20.
//  Copyright © 2017年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

#pragma mark - 计算当前字符串的 MD5值
/** 计算当前字符串的 MD5值 */
- (NSString *)MD5;

- (NSString *)MD5Hash;
/**  哈希256 */
- (NSString *)sha256;

@end
