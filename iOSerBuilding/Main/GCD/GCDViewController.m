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
    
//    [self semaphoreDemo];
//    [self serialDemo];
    
//    dispatch_queue_t queue = dispatch_queue_create("serialDemo", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue = dispatch_queue_create("serialDemo", DISPATCH_QUEUE_CONCURRENT);
//    
//    // 并发还是串行取决于 queue 的类型，并发会有最大线程数限制，不会一次性开辟100条线程（可以用来并发遍历（遍历内部配合锁使用））
//    dispatch_apply(100, queue, ^(size_t iteration) {
//        NSLog(@"%zu start", iteration);
//        sleep(1 + arc4random() % 3);
//        NSLog(@"%zu end", iteration);
//    });
//    NSLog(@"done");
    
    self.view.backgroundColor = UIColor.redColor;
    UIButton *button = [UIButton new];
    [button setTitle:@"button" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:button];
    
    UIContentUnavailableConfiguration *config = [UIContentUnavailableConfiguration emptyConfiguration];
    config.text = @"没有数据";
    config.secondaryText = @"......";
    UIButtonConfiguration *buttonConfig = [UIButtonConfiguration filledButtonConfiguration];
    buttonConfig.title = @"加载数据";
    config.button = buttonConfig;
    UIContentUnavailableView *unavailableView = [[UIContentUnavailableView alloc] initWithConfiguration:config];
    
    self.contentUnavailableConfiguration = config;
}

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
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

// 此处模拟一个停车场
//- (void)semaphoreDemo {
//    // 并发队列
//    dispatch_queue_t concurrentQueue = dispatch_queue_create("iOSerBuilding", DISPATCH_QUEUE_CONCURRENT);
//    // 创建信号量，初始值为5 (5个车位）
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(5);
//    while (YES) {
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        NSLog(@"进来了一辆车");
//        dispatch_async(concurrentQueue, ^{
//            sleep(arc4random() % 3 + 3);
//            dispatch_semaphore_signal(semaphore);
//            NSLog(@"离开了一辆车");
//        });
//    }
//}

- (void)serialDemo {
    // 串行队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("serialDemo", DISPATCH_QUEUE_SERIAL);
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 3; i++) {
            dispatch_async(concurrentQueue, ^{
                sleep(3 - i);
                NSLog(@"循环 %d 结束", i);
            });
        }
        sleep(5);
        NSLog(@"线程结束");
    });
}

@end
