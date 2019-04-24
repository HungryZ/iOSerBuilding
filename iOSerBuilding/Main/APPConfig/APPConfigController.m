//
//  APPConfigController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/3/25.
//

#define TDStatus [UserDefaults boolForKey:IsTDOpen]

#import "APPConfigController.h"
#import "FMDeviceManager.h"

@interface APPConfigController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, strong) UITableView * mainTableView;
@property (nonatomic, strong) UIView * footerView;

@end

@implementation APPConfigController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTableView];
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

#pragma mark - Action

- (void)alertBtnClicked {
    
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"Black Box" message:[self getTDBlackBox]  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
    
}

#pragma mark -

- (void)valueChanged:(UISwitch *)sender {
    self.dataArray = nil;
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"关闭应用" message:@"需要手动重启应用才会生效"  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"关闭应用" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [UserDefaults setBool:sender.isOn forKey:IsTDOpen];
        //        [UserDefaults synchronize];
        // 强制退出应用
        abort();
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 没有动画效果，待解决
        [sender setOn:!sender.isOn];
    }];
    [alertC addAction:confirmAction];
    [alertC addAction:cancelAction];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

- (NSString *)getTDBlackBox {
    // 获取设备管理器实例
    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
    /*
     * 获取设备指纹黑盒数据，请确保在应用开启时已经对SDK进行初始化，切勿在get的时候才初始化
     * 如果此处获取到的blackBox特别长(超过400字节)，说明初始化尚未完成(一般需要1-3秒)，或者由于网络问题导致初始化失败，进入了降级处理
     * 降级不影响正常设备信息的获取，只是会造成blackBox字段超长，且无法获取设备真实IP
     * 降级数据平均长度在2KB以内,一般不超过3KB,数据的长度取决于采集到的设备信息的长度,无法100%确定最大长度
     */
    NSString *blackBox = manager->getDeviceInfo();
    // 将blackBox随业务请求提交到您的服务端，服务端调用同盾风险决策API时需要带上这个参数
    NSLog(@"同盾设备指纹数据: %@", blackBox);
    
    return blackBox;
}

#pragma mark - Getter

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        CGRect frame = CGRectMake(0, NaviBarHeight, ScreenWidth, ScreenHeight - NaviBarHeight);
        _mainTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.tableFooterView = TDStatus ? self.footerView : nil;
    }
    return _mainTableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, AdaptedWidth(60))];
        
        UIButton * alertButton = [UIButton buttonWithThemeTitle:@"显示黑箱" target:self action:@selector(alertBtnClicked)];
        [_footerView addSubview:alertButton];
        [alertButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.bottom.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(AdaptedWidth(325), AdaptedWidth(44)));
        }];
    }
    return _footerView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
                       @{
                           @"title" : @"同盾",
                           @"value" : @(TDStatus),
                           },
                       ];
    }
    return _dataArray;
}

@end
