//
//  BannerLayout.m
//  iOSerBuilding
//
//  Created by 张海川 on 2021/7/30.
//

#import "BannerLayout.h"

@implementation BannerLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    float collectionViewCenterX = self.collectionView.frame.size.width / 2 + self.collectionView.contentOffset.x;
    NSArray *array = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    CGFloat maxDistance = self.itemSize.width + self.minimumInteritemSpacing;
    for (UICollectionViewLayoutAttributes *attri in array) {
        CGFloat distance = attri.center.x - collectionViewCenterX;
        CGFloat scale = 1 - (ABS(distance) / maxDistance) * (1 - 0.8);
        // 修正因为缩放导致的间隔变大
        CGFloat scaledDeltaX = attri.size.width * (1 - scale) / 2 * (distance > 0 ? -1 : 1);
        attri.transform = CGAffineTransformMake(scale, 0, 0, scale, scaledDeltaX, 0);
    }

    return array;
}

@end
