//
//  UtilsMacro.h
//  StoneCopy
//
//  Created by 张海川 on 2018/9/6.
//  Copyright © 2018年 张海川. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h


#endif /* UtilsMacro_h */



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
// iPhone6 屏幕宽度375
#define AdaptedWidth(x)                     (ScreenWidth / 375 * (x))

#define ViewWidth(v)                        v.frame.size.width

#define ViewHeight(v)                       v.frame.size.height

#define ViewX(v)                            v.frame.origin.x

#define ViewY(v)                            v.frame.origin.y

#define SelfViewWidth                       self.view.bounds.size.width

#define SelfViewHeight                      self.view.bounds.size.height

#define RectX(f)                            f.origin.x

#define RectY(f)                            f.origin.y

#define RectWidth(f)                        f.size.width

#define RectHeight(f)                       f.size.height

#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))

#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)

#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))

#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))

#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)

#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))

#define StringFormat(string, args...)       [NSString stringWithFormat:string, args]

#define WS(weakSelf)                        __weak __typeof(&*self) weakSelf = self
