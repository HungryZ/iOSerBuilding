//
//  MemoryLeakCheckController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/6/13.
//

#import "MemoryLeakCheckController.h"
#import "ZHCTextField.h"

typedef void(^RetainBlock)(void);

@interface MemoryLeakCheckController ()

@property (nonatomic, copy) RetainBlock block;

@end

@implementation MemoryLeakCheckController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"引用计数0 --- %ld", CFGetRetainCount((CFTypeRef)self));
    _block = ^{
//        NSLog(@"引用计数1.5 --- %ld", CFGetRetainCount((CFTypeRef)self));
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"引用计数1.6 --- %ld", CFGetRetainCount((CFTypeRef)self));
//        });
        ^{
            ^{
                ^{
                    ^{
                        NSLog(@"引用计数1.4 --- %ld", CFGetRetainCount((CFTypeRef)self));
                        ^{
                            NSLog(@"引用计数1.5 --- %ld", CFGetRetainCount((CFTypeRef)self));
                            ^{
                                ^{
                                    ^{
                                        ^{
                                            ^{
                                                ^{
                                                    ^{
                                                        NSLog(@"引用计数1.6 --- %ld", CFGetRetainCount((CFTypeRef)self));
                                                    }();
                                                    NSLog(@"引用计数1.7 --- %ld", CFGetRetainCount((CFTypeRef)self));
                                                }();
                                                NSLog(@"引用计数1.8 --- %ld", CFGetRetainCount((CFTypeRef)self));
                                            }();
                                            NSLog(@"引用计数1.9 --- %ld", CFGetRetainCount((CFTypeRef)self));
                                        }();
                                    }();
                                }();
                            }();
                        }();
                    }();
                }();
            }();
        }();
//        NSLog(@"引用计数2 --- %ld", CFGetRetainCount((CFTypeRef)self));
    };
    NSLog(@"引用计数1 --- %ld", CFGetRetainCount((CFTypeRef)self));
    _block();
    NSLog(@"引用计数3 --- %ld", CFGetRetainCount((CFTypeRef)self));
    
//    [self seeRetainCountFromARC];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"引用计数5 --- %ld", CFGetRetainCount((CFTypeRef)self));
}

- (void)printMessage {
    NSLog(@"%s", __func__);
}

- (void)seeRetainCountFromARC {
    
    NSObject *objOC = [[NSObject alloc] init];
    CFTypeRef objCF = (__bridge CFTypeRef)objOC;
    
    // 最初的引用计数
//     NSInteger retainCount = CFGetRetainCount(objCF);
    // 这里可以不用以 bridge前缀转换，但是如果拆开就得加上 bridge
    NSInteger retainCount = CFGetRetainCount((CFTypeRef)objOC);
    NSLog(@"最初 --引用计数 --- %ld", retainCount);
    
    // 引用计数加1
    CFRetain(objCF);
    NSLog(@"retain ---引用计数 --- %ld", CFGetRetainCount(objCF));
    // 引用计数减1
    CFRelease(objCF);
    NSLog(@"release -引用计数 --- %ld", CFGetRetainCount(objCF));
    
    // 使用_bridge_retained为前缀转换，引用计数会加1 obiCF=( bridge retained CFTypeRef)obiOC;
    NSLog(@"bridge_retained-引用计数 --- %ld", CFGetRetainCount(objCF));
    
    // 当把objoc设为nil，在ARC下引用计数为0，系统会自动销毁objoc对象
    objOC = nil;
}

@end
