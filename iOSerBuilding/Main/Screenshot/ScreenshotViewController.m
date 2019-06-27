//
//  ScreenshotViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/6/27.
//

#import "ScreenshotViewController.h"
#import "OTScreenshotHelper.h"

@interface ScreenshotViewController ()

@property (nonatomic, strong) UIImageView * smallScreenView;

@end

@implementation ScreenshotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _smallScreenView = [UIImageView new];
    _smallScreenView.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:_smallScreenView];
    [_smallScreenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth / 2, ScreenHeight / 2));
    }];
    
    UIButton * button = [UIButton buttonWithThemeTitle:@"截屏" target:self action:@selector(buttonClicked)];
    button.selected = YES;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.smallScreenView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(300, 44));
    }];
}

- (void)buttonClicked {
    _smallScreenView.image = [OTScreenshotHelper screenshot];
}

@end
