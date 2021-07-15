//
//  HungryToolsMacro.h
//  HungryTools
//
//  Created by 张海川 on 2018/9/6.
//  Copyright © 2018年 张海川. All rights reserved.
//

#ifndef HungryToolsMacro_h
#define HungryToolsMacro_h


#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define keyWindow                           [UIApplication sharedApplication].keyWindow

#define deleWindow                          [UIApplication sharedApplication].delegate.window

#define UserDefaults                        [NSUserDefaults standardUserDefaults]
// 状态栏高度
#define kStatusHeight                       [[UIApplication sharedApplication] statusBarFrame].size.height
// 导航栏高度
#define kNaviHeight                         (kStatusHeight + 44.0)
// TabBar高度
#define kTabHeight                          (kStatusHeight > 21.0 ? 83.0 : 49.0)
// 当前机型与非刘海屏StatusBar高度差
#define kStatusDifHeight                    (kStatusHeight - 20)
// 当前机型与非刘海屏TabBar高度差
#define kBottomHeight                       (kTabHeight - 49)

#define kScreenWidth                        [[UIScreen mainScreen] bounds].size.width

#define kScreenHeight                       [[UIScreen mainScreen] bounds].size.height
// 普通屏幕宽度375
#define AdaptedWidth(x)                     (kScreenWidth / 375 * (x))


#define StringFormat(string, args...)       [NSString stringWithFormat:string, args]


#define WeakSelf                            __weak __typeof(self)weakSelf = self

#define StrongSelf                          __strong __typeof(weakSelf)strongSelf = weakSelf


#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define RGBA(r, g, b, a)                    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define HexColor(hex)                       [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 \
                                                            green:((float)((hex & 0xFF00) >> 8))/255.0 \
                                                             blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#define Font(x)                             [UIFont systemFontOfSize:(x)]

#define ImageView(name)                     [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]]

#define GroupedTable                        [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped]


#endif /* HungryToolsMacro_h */
