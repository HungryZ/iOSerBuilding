//
//  MessageViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2022/3/6.
//

#import "MessageViewController.h"
#import <objc/runtime.h>

@interface OtherClass : NSObject

@end

@implementation OtherClass

- (void)hello {
    NSLog(@"hello");
}

@end


@interface NSObject (ISA)

- (void)testMethod;
+ (void)testMethod;

@end

@implementation NSObject (ISA)

+ (void)testMethod {
    NSLog(@"%s", __func__);
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self performSelector:@selector(hello)];
    
//    [NSObject testMethod];
    [[NSObject new] testMethod];
}

- (void)backupMethod {
    NSLog(@"backup method");
}

#pragma mark - Method resolution 动态方法解析

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(hello)) {
//        IMP imp = class_getMethodImplementation(self, @selector(backupMethod));
//        Method method = class_getInstanceMethod(self, @selector(backupMethod));
//        const char *types = method_getTypeEncoding(method);
//
//        return class_addMethod(self, sel, imp, types);
//    }
//
//    return [super resolveInstanceMethod:sel];
//}

#pragma mark - Fast fowarding 快速转发/备援接收者

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return [OtherClass new];
//}

#pragma mark - Normal forwarding 完整的消息转发

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    
    if (methodSignature == nil) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    SEL sel = anInvocation.selector;

    OtherClass *jack = [OtherClass new];

    if ([jack respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:jack];
    }
}

#pragma mark - Crash

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"carshed");
}

@end

