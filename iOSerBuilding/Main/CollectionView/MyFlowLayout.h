//
//  MyFlowLayout.h
//  iOSerBuilding
//
//  Created by 张海川 on 2021/7/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MyFlowLayout;

@protocol MyFlowLayoutDataSource <NSObject>

- (CGFloat)myFlowLayout:(MyFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MyFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<MyFlowLayoutDataSource> dataSource;

@end

NS_ASSUME_NONNULL_END
