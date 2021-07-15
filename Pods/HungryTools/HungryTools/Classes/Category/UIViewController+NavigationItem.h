//
//  UIViewController+NavigationItem.h
//  HungryTools
//
//  Created by 张海川 on 2020/9/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NavigationItem)

/// 添加导航栏左右按钮
/// @param direction 左右位置，0左1右
/// @param content 内容，支持NSString，UIImage
- (void)addNavigationItemWithLocation:(int)direction content:(id)content;

- (void)navigationItemClicked:(int)direction atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
