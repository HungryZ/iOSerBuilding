//
//  Life_LaunchAnimationView.h
//  iOSerBuilding
//
//  Created by cy on 2019/8/29.
//

#import <UIKit/UIKit.h>

@class Life_LaunchModel;

NS_ASSUME_NONNULL_BEGIN

@interface Life_LaunchAnimationView : UIView

+ (void)life_showWithModel:(Life_LaunchModel *)model;

- (instancetype)initWithModel:(Life_LaunchModel *)model;

- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
