//
//  LaunchAnimationController.m
//  iOSerBuilding
//
//  Created by cy on 2019/8/29.
//

#import "LaunchAnimationController.h"
#import "Life_LaunchAnimationView.h"
#import "Life_LaunchModel.h"

@implementation LaunchAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
//    [self.aniView startAnimation];
    Life_LaunchModel * model = [Life_LaunchModel new];
    model.event_type = @"2";
    model.event_time = @"1995-11-25";
//    model.event_type = @"1";
//    model.event_time = @"2020-01-25";
//    model.event_name = @"过年";
    model.daily_soup = @"人们只有在不彼此需要的时候才会是幸福的。只过自己的生活，完全属于自己的、和别人无关的生活。在我们自由的时候。——蕾拉斯利马尼";

    [Life_LaunchAnimationView life_showWithModel:model];
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
