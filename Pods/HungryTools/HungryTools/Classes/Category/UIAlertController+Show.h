//
//  UIAlertController+Show.h
//  HungryTools
//
//  Created by 张海川 on 2019/6/19.
//  Copyright © 2019 张海川. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfirmBlock)(void);

@interface UIAlertController (Show)

/// 仅有一个确认按钮的StyleAlert
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmBlock:(nullable ConfirmBlock)confirm;

@end

NS_ASSUME_NONNULL_END
