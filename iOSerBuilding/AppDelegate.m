//
//  AppDelegate.m
//  iOSerBuilding
//
//  Created by 张海川 on 2018/12/12.
//

#import "AppDelegate.h"
#import "BaseTabBarManager.h"
#import "LogFileManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 坐标原点移动到(0, 0)
//    if (@available(iOS 11.0, *)) {
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
//        [[UITableView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
//    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = [BaseTabBarManager sharedManager].tabBarController;
    
    [self.window makeKeyAndVisible];
    
//    [self configLog];
    
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


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

#pragma mark -

- (void)configLog {
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:[LogFileManager new]];
    fileLogger.rollingFrequency = 60 * 60 * 24;  // 每个文件超过24小时后会被新的日志覆盖
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;  //最多保存7个日志文件
    fileLogger.maximumFileSize = (1 << 10) * 50;   //每个文件数量最大尺寸为50k
    [DDLog addLogger:fileLogger];
    
    
//    DDLogError(@"DDLogError");
//    DDLogWarn(@"DDLogWarn");
//    DDLogInfo(@"DDLogInfo");
//    DDLogDebug(@"DDLogDebug");
//    DDLogVerbose(@"DDLogVerbose");
    
    for (int i = 0; i < 10000; i++) {
        DDLogVerbose(@"DDLogVerbose LogFileManager %d", i);
//        NSLog(@"DDLogVerbose LogFileManager %d", i);
    }
}


@end
