//
//  CollectionViewListController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2021/7/29.
//

#import "CollectionViewListController.h"
#import "BannerCollectionViewController.h"
#import "FlowCollectionViewController.h"

@interface CollectionViewListController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray<NSDictionary *> * dataArray;

@property (nonatomic, strong) UITableView * mainTableView;

@end

@implementation CollectionViewListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, kTabHeight, 0));
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = 0;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Banner";
            break;
        case 1:
            cell.textLabel.text = @"Flow";
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *nextVC;
    switch (indexPath.row) {
        case 0:
            nextVC = [BannerCollectionViewController new];
            break;
        case 1:
            nextVC = [FlowCollectionViewController new];
            break;
    }
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTableView.separatorInsetReference = UITableViewSeparatorInsetFromAutomaticInsets;
    }
    return _mainTableView;
}

@end
