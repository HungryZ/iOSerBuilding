//
//  TransitionViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/2/14.
//

#define CellID @"cell"

#import "TransitionViewController.h"
#import "ViewTransitionController.h"
#import "NaviTransitionController.h"

@interface TransitionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSArray *> * dataArray;

@property (nonatomic, strong) UITableView * mainTableView;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(NaviBarHeight, 0, 0, 0));
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"自带效果";
    } else {
        return @"自定义效果";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    cell.accessoryType = 1;
    cell.selectionStyle = 0;
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController * pushedVC = [self.dataArray[indexPath.section][indexPath.row][@"controller"] new];
    pushedVC.view.backgroundColor = [UIColor whiteColor];
    pushedVC.hidesBottomBarWhenPushed = YES;
    pushedVC.title = self.dataArray[indexPath.section][indexPath.row][@"title"];
    self.navigationController.delegate = pushedVC;
    [self.navigationController pushViewController:pushedVC animated:YES];
}

#pragma mark - Init

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    }
    return _mainTableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        NSArray * group1 = @[
                             @{
                                 @"title" : @"View转场",
                                 @"controller" : [ViewTransitionController class]
                                 },
                             ];
        NSArray * group2 = @[
                             @{
                                 @"title" : @"Navi转场",
                                 @"controller" : [NaviTransitionController class]
                                 },
                             ];
        
        _dataArray = @[group1, group2];
    }
    return _dataArray;
}

@end
