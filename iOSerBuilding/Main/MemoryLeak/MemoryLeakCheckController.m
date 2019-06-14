//
//  MemoryLeakCheckController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/6/13.
//

#import "MemoryLeakCheckController.h"

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
    _block = ^{
        [self printMessage];
    };
    _block();
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
