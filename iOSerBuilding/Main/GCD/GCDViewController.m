//
//  GCDViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/6/14.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self semaphoreDemo];
}

- (void)groupDemo {
    // DISPATCH_QUEUE_CONCURRENT 并发队列
    dispatch_queue_t dispatchQueue = dispatch_queue_create("iOSerBuilding", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t dispatchGroup = dispatch_group_create();
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        sleep(6);
        NSLog(@"dispatch-1");
    });
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        sleep(3);
        NSLog(@"dspatch-2");
    });
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"end");
    });
}

// 此处模拟一个车位数量为5的停车场
- (void)semaphoreDemo {
    // 并发队列 （可以同时进入多个车辆）
    dispatch_queue_t concurrentQueue = dispatch_queue_create("iOSerBuilding", DISPATCH_QUEUE_CONCURRENT);
    // 创建信号量，初始值为5 (5个车位）
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(5);
    while (YES) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"进来了一辆车");
        dispatch_async(concurrentQueue, ^{
            sleep(arc4random() % 3 + 3);
            dispatch_semaphore_signal(semaphore);
            NSLog(@"离开了一辆车");
        });
    }
}

@end
