//
//  HomeViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/2/12.
//

#define CellID @"cell"

#import "HomeViewController.h"
#import "iOSerBuilding-Swift.h"
#import "BezierViewController.h"
#import "AnimationViewController.h"
#import "TransitionViewController.h"
#import "ScrollMasonryController.h"
#import "RegexViewController.h"
#import "MemoryLeakCheckController.h"
#import "GCDViewController.h"
#import "ScreenshotViewController.h"
#import "RelativeLabelViewController.h"
#import "MarginButtonViewController.h"
#import "AFTestViewController.h"
#import "JSInteractionViewController.h"
#import "RunLoopViewController.h"
#import "CollectionViewListController.h"
#import "CustomKVOViewController.h"
#import "MessageViewController.h"
#import "WatermarkViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSDictionary *> * dataArray;

@property (nonatomic, strong) UITableView * mainTableView;

@property (nonatomic, copy) NSString *testString;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
#if APPSTATUS == 0
    self.navigationItem.title = @"测试";
#elif APPSTATUS == 1
    self.navigationItem.title = @"正式";
#elif APPSTATUS == 2
    self.navigationItem.title = @"预发";
#endif

    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, kTabHeight, 0));
    }];

//    NSString *str = @"str";
//    self.testString = str;
//    str = @"string";
//    NSLog(@"%@", self.testString);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
//            completionHandler(granted, error);
        }];
        NSLog(@"");
    });
    
    NSLog(@"");
    
    UIView *viewA = [UIView new];
    UIView *viewB = [UIView new];
    UIView *viewC = [UIView new];
    viewC.tag = 199999;
    
    [viewB addSubview:viewC];
    [viewA addSubview:viewB];
    [self.view addSubview:viewA];
    
    UIView *tagView = [self.view viewWithTag:199999];
    NSLog(@"");
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
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTableView.separatorInsetReference = UITableViewSeparatorInsetFromAutomaticInsets;
        
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
                @"controller" : [RegexViewController class],
            },
            @{
                @"title" : @"内存泄漏检测",
                @"controller" : [MemoryLeakCheckController class],
            },
            @{
                @"title" : @"GCD",
                @"controller" : [GCDViewController class],
            },
            @{
                @"title" : @"Label相对布局",
                @"controller" : [RelativeLabelViewController class],
            },
            @{
                @"title" : @"指定边距按钮",
                @"controller" : [MarginButtonViewController class],
            },
            @{
                @"title" : @"离屏渲染",
                @"controller" : [OffScreenRenderedController class],
            },
            @{
                @"title" : @"AF测试",
                @"controller" : [AFTestViewController class],
            },
            @{
                @"title" : @"JS交互",
                @"controller" : [JSInteractionViewController class],
            },
            @{
                @"title" : @"Run Loop",
                @"controller" : [RunLoopViewController class],
            },
            @{
                @"title" : @"CollectionView",
                @"controller" : [CollectionViewListController class],
            },
            @{
                @"title" : @"图片显示优化",
                @"controller" : [ImageImproveViewController class],
            },
            @{
                @"title" : @"CustomKVO",
                @"controller" : [CustomKVOViewController class],
            },
            @{
                @"title" : @"RxSwift",
                @"controller" : [RxSwiftViewController class],
            },
            @{
                @"title" : @"DataStructure",
                @"controller" : [BinaryTreeViewController class],
            },
            @{
                @"title" : @"Message",
                @"controller" : [MessageViewController class],
            },
            @{
                @"title" : @"水印",
                @"controller" : [WatermarkViewController class],
            },
        ];
    }
    return [[_dataArray reverseObjectEnumerator] allObjects];
}

@end
