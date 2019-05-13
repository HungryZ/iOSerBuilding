//
//  AppDelegate.m
//  iOSerBuilding
//
//  Created by 张海川 on 2018/12/12.
//

#import "AppDelegate.h"
#import "BaseTabBarManager.h"
#import "FMDeviceManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 坐标原点移动到(0, 0)
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        [[UITableView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    UIWindow * window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.rootViewController = [BaseTabBarManager sharedManager].tabBarController;
    
    self.window = window;
    [self.window makeKeyAndVisible];
    
    [self initTD];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/**
 初始化同盾
 */
- (void)initTD {
    
    if (![UserDefaults boolForKey:IsTDOpen]) {
        return;
    }
    
    // 获取设备管理器实例
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    // 准备SDK初始化参数
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    
    /*
     * SDK具有防调试功能，当使用xcode运行时(开发测试阶段),请取消下面代码注释，
     * 开启调试模式,否则使用xcode运行会闪退。上架打包的时候需要删除或者注释掉这
     * 行代码,如果检测到调试行为就会触发crash,起到对APP的保护作用
     */
    // 上线Appstore的版本，请记得删除此行，否则将失去防调试防护功能！
#if defined (DEBUG) || defined(_DEBUG) || APPSTATUS !=1
    [options setValue:@"allowd" forKey:@"allowd"];  // TODO
    NSLog(@"测试代码");
#endif
    // 此处替换为您的合作方标识
    [options setValue:@"M" forKey:@"partner"];
    
    //    /*
    //     * 若需要通过回调方式获取blackBox, 请在初始化参数中添加回调block
    //     * SDK初始化完成，生成blackBox的时候就会立即触发此回调
    //     */
    //    [options setObject:^(NSString *blackBox){
    //        //添加你的回调逻辑
    //        printf("同盾设备指纹,回调函数获取到的blackBox:%s\n",[blackBox UTF8String]);
    //    } forKey:@"callback"];
    //设置超时时间(单位:秒)
    //    [options setValue:@"6" forKey:@"timeLimit"];
    // 使用上述参数进行SDK初始化
    manager->initWithOptions(options);
}


@end
