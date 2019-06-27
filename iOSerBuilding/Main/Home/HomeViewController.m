//
//  HomeViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/2/12.
//

#define CellID @"cell"

#import "HomeViewController.h"
#import "BezierViewController.h"
#import "AnimationViewController.h"
#import "TransitionViewController.h"
#import "ScrollMasonryController.h"
#import "RegexViewController.h"
#import "PageViewController.h"
#import "APPConfigController.h"
#import "BannerViewController.h"
#import "MemoryLeakCheckController.h"
#import "GCDViewController.h"
#import "ScreenshotViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSDictionary *> * dataArray;

@property (nonatomic, strong) UITableView * mainTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
#if APPSTATUS == 0
    self.title = @"测试";
#elif APPSTATUS == 1
    self.title = @"正式";
#elif APPSTATUS == 2
    self.title = @"预发";
#endif
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(NaviBarHeight, 0, TabBarHeight, 0));
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.accessoryType = 1;
    cell.selectionStyle = 0;
    
    NSString * title = self.dataArray[indexPath.row][@"title"];
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController * pushedVC = [self.dataArray[indexPath.row][@"controller"] new];
    pushedVC.view.backgroundColor = self.mainTableView.backgroundColor;
    pushedVC.hidesBottomBarWhenPushed = YES;
    pushedVC.title = self.dataArray[indexPath.row][@"title"];
    [self.navigationController pushViewController:pushedVC animated:YES];
}

#pragma mark - Init

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
//        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    }
    return _mainTableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @{
                           @"title" : @"Bezier绘图",
                           @"controller" : [BezierViewController class],
                           },
                       @{
                           @"title" : @"动画",
                           @"controller" : [AnimationViewController class],
                           },
                       @{
                           @"title" : @"转场动画",
                           @"controller" : [TransitionViewController class],
                           },
                       @{
                           @"title" : @"截屏",
                           @"controller" : [ScreenshotViewController class],
                           },
                       @{
                           @"title" : @"Scroll Masonry",
                           @"controller" : [ScrollMasonryController class],
                           },
                       @{
                           @"title" : @"正则表达式",
                           @"controller" : [RegexViewController new],
                           },
                       @{
                           @"title" : @"滑页浏览",
                           @"controller" : [PageViewController class],
                           },
                       @{
                           @"title" : @"应用初始化配置",
                           @"controller" : [APPConfigController class],
                           },
                       @{
                           @"title" : @"轮播图",
                           @"controller" : [BannerViewController class],
                           },
                       @{
                           @"title" : @"内存泄漏检测",
                           @"controller" : [MemoryLeakCheckController class],
                           },
                       @{
                           @"title" : @"GCD",
                           @"controller" : [GCDViewController class],
                           },
                       ];
    }
    return _dataArray;
}

@end
