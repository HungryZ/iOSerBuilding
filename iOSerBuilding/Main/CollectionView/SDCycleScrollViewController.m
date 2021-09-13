//
//  SDCycleScrollViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2021/8/13.
//

#import "SDCycleScrollViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface SDCycleScrollViewController ()

@end

@implementation SDCycleScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageNamesGroup:@[@"IMG_0", @"IMG_1", @"IMG_2"]];
    [self.view addSubview:banner];
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(188);
    }];
}

@end
