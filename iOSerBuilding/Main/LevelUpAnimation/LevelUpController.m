//
//  LevelUpController.m
//  iOSerBuilding
//
//  Created by cy on 2019/9/18.
//

#import "LevelUpController.h"
#import "LevelUpAnimationView.h"

@interface LevelUpController ()

@end

@implementation LevelUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [LevelUpAnimationView showWithGrade:2];
}

@end
