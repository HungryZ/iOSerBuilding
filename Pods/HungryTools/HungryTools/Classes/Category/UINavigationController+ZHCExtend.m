//
//  UINavigationController+ZHCExtend.m
//  HungryTools
//
//  Created by 张海川 on 2020/9/2.
//

#define PerformSEL(obj, sel) [obj respondsToSelector:sel] ? [obj performSelector:sel] : nil

#import "UINavigationController+ZHCExtend.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property (nonatomic, copy) NaviBarConfigBlock zhc_navigationBarRefreshBlock;

@end

@implementation UIViewController (NavigationConfig)

+ (void)load {
    Method method1 = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method method2 = class_getInstanceMethod(self, @selector(zhc_viewWillAppear:));
    method_exchangeImplementations(method1, method2);
}

- (void)zhc_viewWillAppear:(BOOL)animated {
    [self zhc_viewWillAppear:animated];
    
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:self.zhc_hideNavigationBar animated:animated];
        
        if (self.zhc_navigationBarRefreshBlock) {
            self.zhc_navigationBarRefreshBlock(self.navigationController.navigationBar);
        }
    }
}

#pragma mark - Setter

- (void)setZhc_hideNavigationBar:(BOOL)zhc_hideNavigationBar {
    objc_setAssociatedObject(self, @selector(zhc_hideNavigationBar), @(zhc_hideNavigationBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setZhc_navigationBarRefreshBlock:(NaviBarConfigBlock)zhc_navigationBarRefreshBlock {
    objc_setAssociatedObject(self, @selector(zhc_navigationBarRefreshBlock), zhc_navigationBarRefreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - Getter

- (BOOL)zhc_hideNavigationBar {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (NaviBarConfigBlock)zhc_navigationBarRefreshBlock {
    return objc_getAssociatedObject(self, _cmd);
}

@end


@interface UINavigationController () <UIGestureRecognizerDelegate>

@property (nonatomic, copy) UIPanGestureRecognizer *zhc_popGesture;

@end

@implementation UINavigationController (ZHCExtend)

#pragma mark - Life Cycle

+ (void)load {
    Method originalMethod, swizzledMethod;
    
    originalMethod = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    swizzledMethod = class_getInstanceMethod(self, @selector(zhc_pushViewController:animated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    originalMethod = class_getInstanceMethod(self, @selector(setViewControllers:animated:));
    swizzledMethod = class_getInstanceMethod(self, @selector(zhc_setViewControllers:animated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);

    originalMethod = class_getInstanceMethod(self, @selector(popViewControllerAnimated:));
    swizzledMethod = class_getInstanceMethod(self, @selector(zhc_popViewControllerAnimated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);

    originalMethod = class_getInstanceMethod(self, @selector(preferredStatusBarStyle));
    swizzledMethod = class_getInstanceMethod(self, @selector(zhc_preferredStatusBarStyle));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (UIStatusBarStyle)zhc_preferredStatusBarStyle {
    return [self.viewControllers.lastObject preferredStatusBarStyle];
}

- (void)zhc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self checkGesture];
    [self setBackButton:viewController atIndex:self.childViewControllers.count];
    
    [self zhc_pushViewController:viewController animated:animated];
    
    [self refreshNavigationBarAppearenceIfneeded:0 must:NO];
}

- (void)zhc_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [self checkGesture];
    for (int i = 1; i < viewControllers.count; i++) {   // 第一个不设置
        [self setBackButton:viewControllers[i] atIndex:i];
        viewControllers[i].hidesBottomBarWhenPushed = YES;
    }
    
    [self zhc_setViewControllers:viewControllers animated:animated];
    
    [self refreshNavigationBarAppearenceIfneeded:0 must:YES];
}

- (UIViewController *)zhc_popViewControllerAnimated:(BOOL)animated {
    
    [self refreshNavigationBarAppearenceIfneeded:1 must:NO];
    
    return [self zhc_popViewControllerAnimated:animated];
}

#pragma mark - User Interaction

- (void)backAction {
    if (self.childViewControllers.count < 2) {
        return;
    }
    
    if ([self.visibleViewController respondsToSelector:@selector(zhc_navigationControllerCanPopBackByClick)]) {
        BOOL canPop = (BOOL)[self.visibleViewController performSelector:@selector(zhc_navigationControllerCanPopBackByClick)];
        if (canPop) {
            [self popViewControllerAnimated:YES];
        }
        return;
    }
    
    if ([self.visibleViewController respondsToSelector:@selector(zhc_navigationControllerCanPopBack)]) {
        BOOL canPop = (BOOL)[self.visibleViewController performSelector:@selector(zhc_navigationControllerCanPopBack)];
        if (canPop) {
            [self popViewControllerAnimated:YES];
        }
        return;
    }
    
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    if (self.childViewControllers.count < 2) {
        return NO;
    }
    
    if ([self.visibleViewController respondsToSelector:@selector(zhc_navigationControllerCanPopBackByGesture)]) {
        return (BOOL)[self.visibleViewController performSelector:@selector(zhc_navigationControllerCanPopBackByGesture)];
    }
    
    if ([self.visibleViewController respondsToSelector:@selector(zhc_navigationControllerCanPopBack)]) {
        return (BOOL)[self.visibleViewController performSelector:@selector(zhc_navigationControllerCanPopBack)];
    }
    
    return YES;
}

#pragma mark - UINavigationBarDelegate

// 在不同系统上，扩展和子类里表现不一，所以就不支持默认返回按钮(backBarButtonItem)的拦截了
//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
//    return [self canPopByClickOrGesture];
//}

#pragma mark - Helper

- (void)checkGesture {
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.zhc_popGesture]) {
        
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.zhc_popGesture];

        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.zhc_popGesture.delegate = self;
        [self.zhc_popGesture addTarget:internalTarget action:internalAction];
    }
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)setBackButton:(UIViewController *)viewController atIndex:(NSInteger)index {
    if (index < 1) {
        return;
    }
    
    if (![viewController respondsToSelector:@selector(zhc_navigationControllerBackItemContent)]) {
        return;
    }
    
    id content = [viewController performSelector:@selector(zhc_navigationControllerBackItemContent)];
    if (!content) {
        return;
    }
    
    SEL action = @selector(backAction);
    
    UIBarButtonItem *leftItem;
    if ([content isKindOfClass:UIView.class]) {
        if ([content isKindOfClass:UIButton.class]) {
            [(UIButton *)content addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        } else {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
            [(UIView *)content addGestureRecognizer:tap];
        }
        leftItem = [[UIBarButtonItem alloc] initWithCustomView:content];
    } else {
        UIImage *image;
        if ([content isKindOfClass:UIImage.class]) {
            image = content;
        } else if ([content isKindOfClass:NSString.class]) {
            image = [UIImage imageNamed:content];
        }
        if (image) {
            if ([viewController respondsToSelector:@selector(zhc_navigationControllerBackItemTintColor)]) {
                // initWithCustomView设置tintcolor无效
                leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
                leftItem.tintColor = [viewController performSelector:@selector(zhc_navigationControllerBackItemTintColor)];
            } else {
                UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
                
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                [customView addSubview:imageView];
                imageView.center = CGPointMake(imageView.center.x, customView.center.y);
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
                [customView addGestureRecognizer:tap];
                
                leftItem = [[UIBarButtonItem alloc] initWithCustomView:customView];
            }
        }
    }
    if (!leftItem) {
        return;
    }
    
    viewController.navigationItem.leftBarButtonItem = leftItem;
}

// 在push之后或pop之前调用 0入栈 1出栈
- (void)refreshNavigationBarAppearenceIfneeded:(int)type must:(BOOL)mustRefresh {
    if (self.viewControllers.count == 0) {
        // 其实并不会等于零
        return;
    }
    
    if (self.viewControllers.count == 1) {  // 栈中控制器数量为1，只需展示这个VC的导航栏样式即可
        UIViewController *topVC = self.viewControllers.lastObject;
        NaviBarConfigBlock topBlock = PerformSEL(topVC, @selector(zhc_navigationControllerSingleAppearenceConfig));
        if (topBlock) {
            topVC.zhc_navigationBarRefreshBlock = topBlock;
        } else {
            topVC.zhc_navigationBarRefreshBlock = PerformSEL(topVC, @selector(zhc_navigationControllerDefaultAppearenceConfig));
        }
    } else {                                // 栈中控制器数量大于1
        UIViewController *appearingVC, *disappearingVC;
        NaviBarConfigBlock appearingBlock, disappearingBlock;
        if (type == 0) {    // 入栈
            appearingVC = self.viewControllers.lastObject;
            disappearingVC = self.viewControllers[self.viewControllers.count - 2];
        } else {            // 出栈
            appearingVC = self.viewControllers[self.viewControllers.count - 2];
            disappearingVC = self.viewControllers.lastObject;
        }
        appearingBlock = PerformSEL(appearingVC, @selector(zhc_navigationControllerSingleAppearenceConfig));
        disappearingBlock = PerformSEL(disappearingVC, @selector(zhc_navigationControllerSingleAppearenceConfig));
        
        BOOL needRefreshNavigationBar;
        if (mustRefresh) {
            needRefreshNavigationBar = YES;
        } else {
            // 当任意一个block存在说明前后两个VC样式不一样，需要刷新UI
            BOOL haveDiffAppearence = appearingBlock || disappearingBlock;
            // disappearingVC 没有遵守 ZHCNavigationControllerDelegate 协议，可能 disappearingVC 修改了导航栏样式，这种情况也需要刷新UI。（比如push进了一个三方SDK提供的VC，然后再pop回来）
            BOOL fromUnZHCVC = ![disappearingVC conformsToProtocol:@protocol(ZHCNavigationControllerDelegate)];
            
            needRefreshNavigationBar = haveDiffAppearence || fromUnZHCVC;
        }

        if (needRefreshNavigationBar) {
            if (appearingBlock) {
                appearingVC.zhc_navigationBarRefreshBlock = appearingBlock;
            } else {
                appearingVC.zhc_navigationBarRefreshBlock = PerformSEL(appearingVC, @selector(zhc_navigationControllerDefaultAppearenceConfig));
            }
        } else {
            appearingVC.zhc_navigationBarRefreshBlock = nil;
        }
    }
}

#pragma mark - Getter

- (UIPanGestureRecognizer *)zhc_popGesture {
    UIPanGestureRecognizer *gesture = objc_getAssociatedObject(self, _cmd);
    if (!gesture) {
        gesture = [[UIPanGestureRecognizer alloc] init];
        gesture.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return gesture;
}

@end
