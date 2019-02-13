//
//  BaseTabBarManager.m
//  iOSerBuilding
//
//  Created by 张海川 on 2018/12/12.
//

#import "BaseTabBarManager.h"
#import "HomeViewController.h"

@interface BaseTabBarManager()

@property (nonatomic, strong) NSArray * controllersArray;
@property (nonatomic, strong) NSArray * attributesArray;

@end

@implementation BaseTabBarManager

+ (instancetype)sharedManager {
    
    static BaseTabBarManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//
//    return [BaseTabBarManager sharedManager];
//}
//
//- (id)copyWithZone:(NSZone *)zone {
//
//    return [BaseTabBarManager sharedManager];
//}
//
//- (id)mutableCopyWithZone:(NSZone *)zone {
//
//    return [BaseTabBarManager sharedManager];
//}

#pragma mark Init

- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.controllersArray tabBarItemsAttributes:self.attributesArray];
    }
    return _tabBarController;
}

- (NSArray *)controllersArray {
    if (!_controllersArray) {
        
        _controllersArray = @[
                              [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]],
                              ];
    }
    return _controllersArray;
}

- (NSArray *)attributesArray {
    if (!_attributesArray) {
        
        NSDictionary *item1 = @{
                                CYLTabBarItemTitle :@"列表",
                                };
        
        _attributesArray = @[item1];
    }
    return _attributesArray;
}

@end
