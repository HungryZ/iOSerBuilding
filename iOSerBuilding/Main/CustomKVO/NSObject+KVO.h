//
//  NSObject+KVO.h
//  iOSerBuilding
//
//  Created by 张海川 on 2021/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZHCKVOChangeHander)(id _Nullable oldValue, id _Nullable newValue);

@interface NSObject (KVO)

- (void)zhc_observeKey:(NSString *)key changeHander:(ZHCKVOChangeHander)changeHander;

@end

NS_ASSUME_NONNULL_END
