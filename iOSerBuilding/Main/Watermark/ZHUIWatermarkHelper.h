//
//  ZHUIWatermarkHelper.h
//  LR35_ZhaoHuOASDK
//
//  Created by cmb on 2023/11/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHUIWatermarkHelper : NSObject

/// 配置水印第一行内容（共两行，第二行为日期，自动生成）
/// - Parameter content: 第一行内容
+ (void)configWatermarkContent:(NSString *)content;

/// 向视图添加水印
/// - Parameter view: 目标视图
+ (void)addWatermarkToView:(UIView *)view;

/// 移除视图水印
/// - Parameter view: 目标视图
+ (void)removeViewWatermark:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
