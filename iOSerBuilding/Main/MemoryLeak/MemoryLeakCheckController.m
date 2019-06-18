//
//  MemoryLeakCheckController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/6/13.
//

#import "MemoryLeakCheckController.h"
#import "ZHCTextField.h"

typedef void(^RetainBlock)(void);

@interface MemoryLeakCheckController ()

@property (nonatomic, copy) RetainBlock block;

@end

@implementation MemoryLeakCheckController

- (void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _block = ^{
//        [self printMessage];
//    };
//    _block();
    
    UITextField * field0 = [UITextField new];
    field0.delegate = field0;
    field0.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:field0];
    [field0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(300, 44));
    }];
    
    ZHCTextField * field = [ZHCTextField new];
    field.fieldType = ZHCFieldTypeNumber;
    field.leftTextColor = UIColor.lightGrayColor;
    field.leftTextFontSize = 12.f;
    field.leftText = @"¥";
    field.maxLength = 2;
    field.layer.cornerRadius = 4;
    field.clipsToBounds = YES;
    field.showBottomLine = NO;

    UILabel * rightView = [UILabel labelWithFontSize:12 textColor:UIColor.whiteColor text:@"万元"];
    rightView.frame = CGRectMake(0, 0, 42, 25);
    rightView.backgroundColor = ThemeColor;
    rightView.textAlignment = NSTextAlignmentCenter;
    field.rightView = rightView;
    field.rightViewMode = UITextFieldViewModeAlways;
    //    field.delegate = field;
    field.backgroundColor = UIColor.purpleColor;
    [self.view addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(field0.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(300, 44));
    }];
}

- (void)printMessage {
    NSLog(@"%s", __func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
