//
//  MarginButtonViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2020/7/22.
//

#import "MarginButtonViewController.h"
#import "ZHCButton.h"

@protocol PropertyTest <NSObject>

@property (nonatomic, strong) NSObject *protocolObj;

@end

@interface MarginButtonViewController () <PropertyTest>

@end

@implementation MarginButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    ZHCButton *button = [ZHCButton new];
    [button setImage:[UIImage imageNamed:@"home_tab"] forState:UIControlStateNormal];
    [button setTitle:@"指定边距按钮" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:36];
    button.backgroundColor = UIColor.orangeColor;
//    button.frame = CGRectMake(100, 100, 100, 100);
    button.zhc_spacing = 10;
    button.zhc_padding = UIEdgeInsetsMake(0, 0, 30, 30);
    button.zhc_alignment = ZHCButtonAlignmentHorizontalReversal;
    
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
    UILabel *rightLabel = [UILabel labelWithFont:@14 text:@"rightLabel"];
    UILabel *bottomLabel = [UILabel labelWithFont:@14 text:@"bottom"];
    rightLabel.backgroundColor = UIColor.redColor;
    bottomLabel.backgroundColor = UIColor.redColor;
    [self.view addSubview:rightLabel];
    [self.view addSubview:bottomLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(button);
        make.left.mas_equalTo(button.mas_right);
    }];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(button);
        make.top.mas_equalTo(button.mas_bottom);
    }];
    self.view.backgroundColor = UIColor.cyanColor;
    
    NSObject *obj = [NSObject new];
    self.protocolObj = obj;
    NSLog(self.protocolObj);
}

- (void)setProtocolObj:(NSObject *)obj {
    
}

- (NSObject *)protocolObj {
    return @"123";
}

@end
