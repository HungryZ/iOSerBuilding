//
//  ScrollMasonryController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2018/12/12.
//

#import "ScrollMasonryController.h"

@interface ScrollMasonryController ()

@end

@implementation ScrollMasonryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self demo1];
    UIScrollView * scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNaviHeight, 0, kTabHeight - 49, 0));
    }];
    
    UIView * baseView = [UIView new];
    baseView.backgroundColor = [UIColor purpleColor];
    [scrollView addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.width.mas_equalTo(scrollView);
    }];
    
    UIView * view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(50);
        make.size.mas_equalTo(100);
    }];
    
    UIView * view2 = [UIView new];
    view2.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom);
        make.left.mas_equalTo(view1.mas_right);
        make.size.mas_equalTo(100);
    }];
    
    UIView * view3 = [UIView new];
    view3.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_bottom).offset(2000);
        make.left.mas_equalTo(view1.mas_right);
        make.size.mas_equalTo(100);
        make.bottom.mas_equalTo(-100);
    }];
}

- (void)demo1 {
    UIScrollView *horizontalScrollView = [[UIScrollView alloc]init];
    horizontalScrollView.backgroundColor = [UIColor orangeColor];
    horizontalScrollView.pagingEnabled =YES;
    // 添加scrollView添加到父视图，并设置其约束
    [self.view addSubview:horizontalScrollView];
    [horizontalScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(kNaviHeight);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(100);
    }];
    // 设置scrollView的子视图，即过渡视图contentSize，并设置其约束
    UIView *horizontalContainerView = [[UIView alloc]init];
    [horizontalScrollView addSubview:horizontalContainerView];
    [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
        make.height.equalTo(horizontalScrollView);
    }];
    //过渡视图添加子视图
    UIView *previousView =nil;
    for (int i =0; i <10; i++)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment =NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithHue:(arc4random() %256 / 256.0)
                                           saturation:(arc4random() %128 /256.0) +0.5
                                           brightness:(arc4random() %128 /256.0) +0.5
                                                alpha:1];
        label.text = [NSString stringWithFormat:@"第 %d个视图", i+1];
        
        //添加到父视图，并设置过渡视图中子视图的约束
        [horizontalContainerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.top.and.bottom.equalTo(horizontalContainerView);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(horizontalScrollView);
            
            if (previousView)
            {
                make.left.mas_equalTo(previousView.mas_right);
            }
            else
            {
                make.left.mas_equalTo(0);
            }
        }];
        
        previousView = label;
    }
    // 设置过渡视图的右距（此设置将影响到scrollView的contentSize）
    [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(previousView.mas_right);
    }];
}

@end
