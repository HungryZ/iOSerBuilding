//
//  RelativeLabelViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2020/3/9.
//  https://www.jianshu.com/p/7798585755cc

#import "RelativeLabelViewController.h"

@interface RelativeLabelViewController ()

@end

@implementation RelativeLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 直接把所有Label放在同一个View下时，只有第一行是第二个Label被压缩，下面的行都是第一个Label被压缩，
    // 暂时不知道原因，所以套了一个View
    UIView *row0 = [UIView new];
    UILabel *label1 = [UILabel labelWithFont:@24 textColor:UIColor.blackColor text:@"RelativeLabelViewController"];
    UILabel *label2 = [UILabel labelWithFont:@24 textColor:UIColor.orangeColor text:@"RelativeLabelViewController"];
    [self.view addSubview:row0];
    [row0 addSubview:label1];
    [row0 addSubview:label2];
    [row0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNaviHeight + 64 * 1);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.left.equalTo(label1.mas_right);
    }];
    
    // ==========================================================================
    
    UIView *row1 = [UIView new];
    UILabel *label3 = [UILabel labelWithFont:@24 textColor:UIColor.blackColor text:@"RelativeLabelViewController"];
    UILabel *label4 = [UILabel labelWithFont:@24 textColor:UIColor.orangeColor text:@"RelativeLabelViewController"];
    [self.view addSubview:row1];
    [row1 addSubview:label3];
    [row1 addSubview:label4];
    [row1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNaviHeight + 64 * 2);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
    }];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.left.equalTo(label3.mas_right);
    }];
    [label4 setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    // ==========================================================================
    
    UIView *row2 = [UIView new];
    UILabel *label5 = [UILabel labelWithFont:@24 textColor:UIColor.blackColor text:@"RelativeLabelViewController"];
    UILabel *label6 = [UILabel labelWithFont:@24 textColor:UIColor.orangeColor text:@"RelativeLabelViewController"];
    [self.view addSubview:row2];
    [row2 addSubview:label5];
    [row2 addSubview:label6];
    [row2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNaviHeight + 64 * 3);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(60).priority(MASLayoutPriorityDefaultLow);
    }];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.left.equalTo(label5.mas_right);
    }];
    
    // ==========================================================================
    
    UIView *row3 = [UIView new];
    UILabel *label7 = [UILabel labelWithFont:@24 textColor:UIColor.blackColor text:@"RelativeLabelViewController"];
    UILabel *label8 = [UILabel labelWithFont:@24 textColor:UIColor.orangeColor text:@"RelativeLabelViewController"];
    [self.view addSubview:row3];
    [row3 addSubview:label7];
    [row3 addSubview:label8];
    [row3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNaviHeight + 64 * 4);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
    }];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.left.equalTo(label7.mas_right);
        make.width.greaterThanOrEqualTo(@2);    // 这里的值随便填
    }];
    
    // ==========================================================================
    
    NSString *string;
    UIView *row4 = [UIView new];
    UILabel *label9 = [UILabel labelWithFont:@24 textColor:UIColor.blackColor text:string ?: @"RelativeLabelViewController"];
    UILabel *label10 = [UILabel labelWithFont:@24 textColor:UIColor.orangeColor text:@"RelativeLabelViewController"];
    [self.view addSubview:row4];
    [row4 addSubview:label9];
    [row4 addSubview:label10];
    [row4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNaviHeight + 64 * 5);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.lessThanOrEqualTo(@260); // @20 @60 @100 @369
    }];
    [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.left.equalTo(label9.mas_right);
    }];
}

@end
