//
//  APPConfigController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/3/25.
//

#import "APPConfigController.h"

@interface APPConfigController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, strong) UITableView * mainTableView;

@end

@implementation APPConfigController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTableView];
}

#pragma mark -

- (void)valueChanged:(UISwitch *)sender {
    [UserDefaults setBool:sender.isOn forKey:IsTDOpen];
    self.dataArray = nil;
}

#pragma mark - UITableView DD

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [UITableViewCell new]; // 不必重用
    cell.selectionStyle = 0;
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    
    UISwitch * kaiguan = [UISwitch new];
    kaiguan.on = [self.dataArray[indexPath.row][@"value"] boolValue];
    [kaiguan addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = kaiguan;
    
    return cell;
}

#pragma mark - Getter

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        CGRect frame = CGRectMake(0, NaviBarHeight, ScreenWidth, ScreenHeight - NaviBarHeight);
        _mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        
    }
    return _mainTableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @{
                           @"title" : @"同盾",
                           @"value" : @([UserDefaults boolForKey:IsTDOpen]),
                           },
                       ];
    }
    return _dataArray;
}

@end
