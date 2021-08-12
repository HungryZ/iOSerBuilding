//
//  NSObject+KVO.m
//  iOSerBuilding
//
//  Created by 张海川 on 2021/8/10.
//  https://www.jianshu.com/p/bf053a28accb

#import "NSObject+KVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define ZHCKVOClassPrifix @"ZHCKVO_"

@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary *allObserveHanders;

@end

@implementation NSObject (KVO)

- (void)zhc_observeKey:(NSString *)key changeHander:(ZHCKVOChangeHander)changeHander {
    SEL setterSEL = NSSelectorFromString([self setterForGetter:key]);
    Method setterMethod = class_getInstanceMethod(self.class, setterSEL);
    if (!setterMethod) {
        //
        return;
    }
    
    NSString *selfClassName = NSStringFromClass(object_getClass(self));
    if (![selfClassName hasPrefix:ZHCKVOClassPrifix]) {
        object_setClass(self, [self jr_KVOClassWithOriginalClassName:selfClassName]);
    }
    
    Class kvoClass = object_getClass(self);
    const char *types = method_getTypeEncoding(setterMethod);
    IMP setterIMP = class_getMethodImplementation(self.class, @selector(zhc_setter:));
//    IMP setterIMP = (IMP)jr_setter;
    class_addMethod(kvoClass, setterSEL, setterIMP, types);
    
    NSMutableArray *handers = self.allObserveHanders[key];
    if (!handers) {
        handers = [NSMutableArray new];
        [self.allObserveHanders setValue:handers forKey:key];
    }
    [handers addObject:changeHander];
}

- (NSString *)setterForGetter:(NSString *)key
{
    // name -> Name -> setName:
    
    // 1. 首字母转换成大写
    unichar c = [key characterAtIndex:0];
    NSString *str = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%c", c-32]];
    
    // 2. 最前增加set, 最后增加:
    NSString *setter = [NSString stringWithFormat:@"set%@:", str];

    return setter;
    
}

- (NSString *)getterForSetter:(NSString *)key
{
    // setName: -> Name -> name
    
    // 1. 去掉set
    NSRange range = [key rangeOfString:@"set"];
    
    NSString *subStr1 = [key substringFromIndex:range.location + range.length];
    
    // 2. 首字母转换成大写
    unichar c = [subStr1 characterAtIndex:0];
    NSString *subStr2 = [subStr1 stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%c", c+32]];
    
    // 3. 去掉最后的:
    NSRange range2 = [subStr2 rangeOfString:@":"];
    NSString *getter = [subStr2 substringToIndex:range2.location];
    
    return getter;
}

- (Class)jr_KVOClassWithOriginalClassName:(NSString *)className
{
    // 生成kvo_class的类名
    NSString *kvoClassName = [ZHCKVOClassPrifix stringByAppendingString:className];
    Class kvoClass = NSClassFromString(kvoClassName);
    
    // 如果kvo class已经被注册过了, 则直接返回
    if (kvoClass) {
        return kvoClass;
    }
    
    // 如果kvo class不存在, 则创建这个类
    Class originClass = object_getClass(self);
    kvoClass = objc_allocateClassPair(originClass, kvoClassName.UTF8String, 0);
    
    // 修改kvo class方法的实现, 学习Apple的做法, 隐瞒这个kvo_class
    Method clazzMethod = class_getInstanceMethod(kvoClass, @selector(class));
    const char *types = method_getTypeEncoding(clazzMethod);
    class_addMethod(kvoClass, @selector(class), (IMP)jr_class, types);
    
    // 注册kvo_class
    objc_registerClassPair(kvoClass);
    
    return kvoClass;
    
}

Class jr_class(id self, SEL cmd)
{
    Class clazz = object_getClass(self); // kvo_class
    Class superClazz = class_getSuperclass(clazz); // origin_class
    return superClazz; // origin_class
}

static void jr_setter(id self, SEL _cmd, id newValue) {
//    NSString *setterName = NSStringFromSelector(_cmd);
//    NSString *getterName = [self getterForSetter:setterName];
//
//    if (!getterName) {
//        NSLog(@"找不到getter方法");
//        // throw exception here
//    }
//
//    // 获取旧值
//    id oldValue = [self valueForKey:getterName];
//
//    // 调用原类的setter方法
//    struct objc_super superClazz = {
//        .receiver = self,
//        .super_class = class_getSuperclass(object_getClass(self))
//    };
//    // 这里需要做个类型强转, 否则会报too many argument的错误
//    ((void (*)(void *, SEL, id))objc_msgSendSuper)(&superClazz, _cmd, newValue);
//
//    NSMutableArray *handers = self.allObserveHanders[getterName];
//    for (ZHCKVOChangeHander hander in handers) {
//        hander(oldValue, newValue);
//    }
}

- (void)zhc_setter:(id)newValue {
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = [self getterForSetter:setterName];

    if (!getterName) {
        NSLog(@"找不到getter方法");
        // throw exception here
    }

    // 获取旧值
    id oldValue = [self valueForKey:getterName];

    // 调用原类的setter方法
    struct objc_super superClazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    // 这里需要做个类型强转, 否则会报too many argument的错误
    ((void (*)(void *, SEL, id))objc_msgSendSuper)(&superClazz, _cmd, newValue);

    NSMutableArray *handers = self.allObserveHanders[getterName];
    for (ZHCKVOChangeHander hander in handers) {
        hander(oldValue, newValue);
    }
}

- (NSMutableDictionary *)allObserveHanders {
    id allObserveHanders = objc_getAssociatedObject(self, _cmd);
    if (!allObserveHanders) {
        allObserveHanders = [NSMutableDictionary new];
        objc_setAssociatedObject(self, _cmd, allObserveHanders, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return allObserveHanders;
}

@end
