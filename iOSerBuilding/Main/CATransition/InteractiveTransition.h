//
//  InteractiveTransition.h
//  iOSerBuilding
//
//  Created by 张海川 on 2019/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, weak) UIViewController *      controller;

@property (nonatomic, assign) BOOL                  isInteractive;

@end

NS_ASSUME_NONNULL_END
