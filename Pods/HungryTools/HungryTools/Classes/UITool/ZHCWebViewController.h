//
//  ZHCWebViewController.h
//  HungryTools
//
//  Created by 张海川 on 2019/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHCWebViewController : UIViewController

@property (nonatomic, copy) NSString * urlString;

- (instancetype)initWithURLString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
