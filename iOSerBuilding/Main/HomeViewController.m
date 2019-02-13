//
//  HomeViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/2/12.
//

#define CellID @"cell"

#import "HomeViewController.h"
#import "BezierViewController.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSDictionary *> * dataArray;

@property (nonatomic, strong) UITableView * mainTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    cell.accessoryType = 1;
    cell.selectionStyle = 0;
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController * pushedVC = self.dataArray[indexPath.row][@"controller"];
    pushedVC.title = self.dataArray[indexPath.row][@"title"];
    [self.navigationController pushViewController:pushedVC animated:YES];
}

#pragma mark ----------------Init

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    }
    return _mainTableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @{
                           @"title" : @"Bezier绘图",
                           @"controller" : [BezierViewController new],
                           },
                       ];
    }
    return _dataArray;
}

@end
