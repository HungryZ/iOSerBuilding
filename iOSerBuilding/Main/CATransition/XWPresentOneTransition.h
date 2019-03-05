//
//  XWPresentOneTransition.h
//  iOSerBuilding
//
//  Created by 张海川 on 2019/2/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XWPresentOneTransitionType) {
    XWPresentOneTransitionTypePresent = 0,//管理present动画
    XWPresentOneTransitionTypeDismiss//管理dismiss动画
};

@interface XWPresentOneTransition : NSObject<UIViewControllerAnimatedTransitioning>
//根据定义的枚举初始化的两个方法
//+ (instancetype)transitionWithTransitionType:(XWPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(XWPresentOneTransitionType)type;

@end

NS_ASSUME_NONNULL_END
