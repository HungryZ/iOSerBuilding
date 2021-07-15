//
//  UITableViewCell+SeparatorLine.h
//  HungryTools
//
//  Created by 张海川 on 2019/5/29.
//  Copyright © 2019 张海川. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (SeparatorLine)

@property (nonatomic, assign) UIEdgeInsets  zhc_separatorLineInset;

@property (nonatomic, assign) CGFloat       zhc_separatorLineHeight;

/// 是否显示顶部分割线
/// 需要在 zhc_separatorLineInset，zhc_separatorLineHeight 赋值之后再赋值
@property (nonatomic, assign) BOOL          zhc_showTopSeparatorLine;

@end

NS_ASSUME_NONNULL_END
