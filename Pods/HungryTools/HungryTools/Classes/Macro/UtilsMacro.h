//
//  UtilsMacro.h
//  StoneCopy
//
//  Created by 张海川 on 2018/9/6.
//  Copyright © 2018年 张海川. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h


#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define UserDefaults                        [NSUserDefaults standardUserDefaults]
// 状态栏高度
#define StatusBarHeight                     [[UIApplication sharedApplication] statusBarFrame].size.height
// 导航栏高度
#define NaviBarHeight                       (StatusBarHeight + 44.0)
// 底部TabBar高度
#define TabBarHeight                        (StatusBarHeight > 21.0 ? 83.0 : 49.0)

#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width

#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
// 普通屏幕宽度375
#define AdaptedWidth(x)                     (ScreenWidth / 375 * (x))

#define StringFormat(string, args...)       [NSString stringWithFormat:string, args]

#define WeakSelf                            __weak __typeof(self)weakSelf = self

#define StrongSelf                          __strong __typeof(weakSelf)strongSelf = weakSelf

#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define RGBA(r, g, b, a)                    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]


#endif /* UtilsMacro_h */
