//
//  MySQLTestViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2018/12/29.
//

#import "MySQLTestViewController.h"
#import "OHMySQL.h"

@interface MySQLTestViewController ()

@end

@implementation MySQLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    OHMySQLUser *auser = [[OHMySQLUser alloc] initWithUserName:@"b_0zektxk6zebk7a"
                                                      password:@"YKKgpePqwbAK5L0g"
                                                    serverName:@"b-0zektxk6zebk7a.bch.rds.gz.baidubce.com"
                                                        dbName:@"b_0zektxk6zebk7a"
                                                          port:3306
                                                        socket:@"b-0zektxk6zebk7a.bch.rds.gz.baidubce.com"];
    OHMySQLStoreCoordinator *coordinator = [[OHMySQLStoreCoordinator alloc] initWithUser:auser];
    
    //连接
    [coordinator connect];
}

@end
