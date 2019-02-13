//
//  BaseTabBarManager.h
//  iOSerBuilding
//
//  Created by 张海川 on 2018/12/12.
//
//  单例模式范本  http://www.cocoachina.com/ios/20171123/21300.html

#import <Foundation/Foundation.h>
#import <CYLTabBarController.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTabBarManager : NSObject

@property (nonatomic, strong) CYLTabBarController * tabBarController;

+ (instancetype)sharedManager;

+ (instancetype) alloc          __attribute__((unavailable("call sharedManager instead")));
+ (instancetype) new            __attribute__((unavailable("call sharedManager instead")));
- (instancetype) copy           __attribute__((unavailable("call sharedManager instead")));
- (instancetype) mutableCopy    __attribute__((unavailable("call sharedManager instead")));

@end

NS_ASSUME_NONNULL_END
