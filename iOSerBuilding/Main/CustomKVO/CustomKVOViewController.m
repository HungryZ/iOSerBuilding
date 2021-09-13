//
//  CustomKVOViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2021/8/11.
//

#import "CustomKVOViewController.h"
#import "NSObject+KVO.h"

@interface CustomKVOViewController ()

@property (nonatomic, assign) int testValue;

@end

@implementation CustomKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self zhc_observeKey:@"view" changeHander:^(id  _Nullable oldValue, id  _Nullable newValue) {
        NSLog(@"changed");
    }];
    self.view = [UIView new];
    
    
//    [self zhc_observeKey:@"testValue" changeHander:^(id  _Nullable oldValue, id  _Nullable newValue) {
//        NSLog(@"changed");
//    }];
//    self.testValue = 1;
}

@end
