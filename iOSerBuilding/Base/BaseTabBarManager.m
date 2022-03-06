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

#pragma mark - Init

- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.controllersArray tabBarItemsAttributes:self.attributesArray];
        
        // 普通状态下的文字属性
        NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
        normalAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        
        // 选中状态下的文字属性
        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        selectedAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        
        // 设置文字属性
        UITabBarItem *tabBarItem = [UITabBarItem appearance];
        [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    }
    return _tabBarController;
}

- (NSArray *)controllersArray {
    if (!_controllersArray) {
        
        _controllersArray = @[
            [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]],
            [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]],
            [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]],
        ];
    }
    return _controllersArray;
}

- (NSArray *)attributesArray {
    if (!_attributesArray) {
        
        NSDictionary *item1 = @{
            CYLTabBarItemTitle          : @"列表",
            CYLTabBarItemImage          : @"home_tab",
            CYLTabBarItemSelectedImage  : @"home_tab",
        };
        
        NSDictionary *item2 = @{
            CYLTabBarItemTitle          : @"列表2",
            CYLTabBarItemImage          : @"home_tab",
            CYLTabBarItemSelectedImage  : @"home_tab",
        };
        
        NSDictionary *item3 = @{
            CYLTabBarItemTitle          : @"列表3",
            CYLTabBarItemImage          : @"home_tab",
            CYLTabBarItemSelectedImage  : @"home_tab",
        };
        
        _attributesArray = @[item1, item2, item3];
    }
    return _attributesArray;
}

@end
