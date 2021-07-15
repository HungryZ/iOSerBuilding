//
//  AFTestViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2020/9/11.
//

#import "AFTestViewController.h"
#import <AFNetworking.h>

@implementation AFTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSString *URLString = @"http://112.13.96.207:13919/app/account/generateCode";
    NSDictionary *para = @{@"mobile" : @"18796945365"};
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:para error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

@end
