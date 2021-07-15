//
//  UINavigationController+ZHCExtend.h
//  HungryTools
//
//  Created by 张海川 on 2020/9/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NaviBarConfigBlock)(UINavigationBar *naviBar);

@protocol ZHCNavigationControllerDelegate <NSObject>

@required
/// 定制返回按钮内容，可以是NSString（图片名），UIImage，UIButton，UIView
/// 与 zhc_navigationControllerBackItemTintColor 联合使用，可以灵活控制按钮颜色
- (id)zhc_navigationControllerBackItemContent;

@optional
/// 能否返回，同时对点击和手势生效
- (BOOL)zhc_navigationControllerCanPopBack;
/// 能否通过点击返回，优先级大于 zhc_navigationControllerCanPopBack
- (BOOL)zhc_navigationControllerCanPopBackByClick;
/// 能否通过手势返回，优先级大于 zhc_navigationControllerCanPopBack
- (BOOL)zhc_navigationControllerCanPopBackByGesture;

/// 返回按钮的颜色，仅当 zhc_navigationControllerBackItemContent 为NSString，UIImage时生效
- (UIColor *)zhc_navigationControllerBackItemTintColor API_AVAILABLE(ios(11));


/// 默认导航栏样式（在没有实现「当前控制前导航栏样式」情况下只会调用一次）
- (NaviBarConfigBlock)zhc_navigationControllerDefaultAppearenceConfig;
/// 当前控制前导航栏样式
- (NaviBarConfigBlock)zhc_navigationControllerSingleAppearenceConfig;

@end


@interface UIViewController (NavigationConfig)

@property (nonatomic, assign) BOOL zhc_hideNavigationBar;

@end


@interface UINavigationController (ZHCExtend)

@end

NS_ASSUME_NONNULL_END
