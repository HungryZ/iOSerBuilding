//
//  Life_LaunchModel.h
//  iOSerBuilding
//
//  Created by cy on 2019/8/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Life_LaunchModel : NSObject


/**
 事件类型
 1.将来事件
 2.生日
 */
@property (nonatomic, copy) NSString *  event_type;
/// 事件日期
@property (nonatomic, copy) NSString *  event_time;
/// 事件名称
@property (nonatomic, copy) NSString *  event_name;
/// 鸡汤文本
@property (nonatomic, copy) NSString *  daily_soup;
/// 服务器时间戳
@property (nonatomic, assign) long      current_time;

@end

NS_ASSUME_NONNULL_END
