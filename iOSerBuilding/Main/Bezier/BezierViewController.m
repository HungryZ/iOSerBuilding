//
//  BezierViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/2/12.
//

#import "BezierViewController.h"
#import "BezierView.h"
#import "BezierDropView.h"

@interface BezierViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BezierView * bezierView;
@property (nonatomic, strong) BezierDropView * dropView;

@property (nonatomic, strong) UITableView * mainTableView;

@end

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNaviHeight, 0, 0, 0));
    }];
    
    _dropView = [BezierDropView new];
    [self.view addSubview:_dropView];
    [_dropView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.mainTableView);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [UITableViewCell new];
    cell.selectionStyle = 0;
    _bezierView = [BezierView new];
    _bezierView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:_bezierView];
    [_bezierView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _dropView.offsetY = scrollView.contentOffset.y;
    [_dropView setNeedsDisplay];
}

#pragma mark - Init

- (UITableView *)mainTableView {
    if (!_mainTableView) {
//        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView = [UITableView new];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.rowHeight = kScreenHeight - kNaviHeight;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}
@end
