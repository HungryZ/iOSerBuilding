//
//  WatermarkViewController.m
//  iOSerBuilding
//
//  Created by cmb on 2023/11/13.
//

#import "WatermarkViewController.h"
#import "ZHUIWatermarkHelper.h"
#import "Aspects.h"

@interface KeyOBJ : NSObject

@end

@implementation KeyOBJ

- (void)dealloc {
    NSLog(@"%s %p", __func__, self);
}

- (void)test:(UIView *)view {
    NSLog(@"zhclog origin %p", view);
}

@end

//@interface ValueOBJ : NSObject
//
//@end
//
//@implementation ValueOBJ
//
//- (void)dealloc {
//    NSLog(@"%s", __func__);
//}
//
//@end


@interface WatermarkViewController ()

@property (nonatomic, strong) KeyOBJ *obj;

@end

@implementation WatermarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 200)];
//    [ZHUIWatermarkHelper addWatermarkToView:view];
//    [self.view addSubview:view];
    
//    _obj = [KeyOBJ new];
//    
//    
//    id<AspectToken> token0 = [_obj aspect_hookSelector:@selector(test:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, UIView *subview) {
//        NSLog(@"zhclog hook0");
//    } error:nil];
//    id<AspectToken> token1 = [_obj aspect_hookSelector:@selector(test:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, UIView *subview) {
//        NSLog(@"zhclog hook1");
//    } error:nil];
//    
//    [token0 remove];
//    
//    [_obj test:self.view];
    
    [ZHUIWatermarkHelper addWatermarkToView:self.view];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 200)];
    view.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:view];
    
    
    NSLog(@"zhclog viewDidLoad");
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
