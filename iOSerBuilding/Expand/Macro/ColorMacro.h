//
//  ColorMacro.h
//  iOSerBuilding
//
//  Created by 张海川 on 2019/4/23.
//

#ifndef ColorMacro_h
#define ColorMacro_h


#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define RGBA(r, g, b, a)                    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define HexColor(hex)                       [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 \
                                                            green:((float)((hex & 0xFF00) >> 8))/255.0 \
                                                             blue:((float)(hex & 0xFF))/255.0 alpha:1.0]

#define ThemeColor                          HexColor(0x678DDD)

#endif /* ColorMacro_h */
