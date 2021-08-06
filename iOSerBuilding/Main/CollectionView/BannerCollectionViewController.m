//
//  BannerCollectionViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2021/7/27.
//

#import "BannerCollectionViewController.h"
#import "BannerLayout.h"

@interface BannerCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView  *collectionView;

@property (nonatomic, strong) NSIndexPath       *currentIndexPath;
@property (nonatomic, assign) BOOL              isLooped;
@property (nonatomic, assign) int               bannerCount;
@property (nonatomic, assign) CGFloat           step;
@property (nonatomic, assign) CGFloat           fixOffsetX;

@end

@implementation BannerCollectionViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildUI];
    
    self.isLooped = YES;
    self.bannerCount = 3;
    
    BannerLayout *layout = (BannerLayout *)self.collectionView.collectionViewLayout;
    self.step = layout.itemSize.width + layout.minimumInteritemSpacing;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self configFirstIndexPath];
        [self.collectionView scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    });
}

- (void)viewDidLayoutSubviews {
    BannerLayout *layout = (BannerLayout *)self.collectionView.collectionViewLayout;
    self.fixOffsetX = (self.collectionView.bounds.size.width - (layout.itemSize.width + layout.minimumInteritemSpacing * 2)) / 2;
}

#pragma mark - Layout

- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9999;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.redColor;
    NSString *title = [NSString stringWithFormat:@"%ld", indexPath.item % self.bannerCount];
    if ([cell.contentView viewWithTag:10086]) {
        UILabel *label = [cell.contentView viewWithTag:10086];
        label.text = title;
    } else {
        UILabel *label = [UILabel labelWithFont:@128 text:title];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 10086;
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    
    return cell;
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UICollectionView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSInteger maxIndex = [self collectionView:scrollView numberOfItemsInSection:0] - 1;
    NSInteger minIndex = 0;
    
    if (velocity.x >= 0 && self.currentIndexPath.item == maxIndex) {
        return;
    }
    if (velocity.x <= 0 && self.currentIndexPath.item == minIndex) {
        return;
    }

    if (velocity.x > 0) {           // 左滑,下一张
        self.currentIndexPath = [NSIndexPath indexPathForItem:self.currentIndexPath.item + 1 inSection:0];
    } else if (velocity.x < 0) {    // 右滑,上一张
        self.currentIndexPath = [NSIndexPath indexPathForItem:self.currentIndexPath.item - 1 inSection:0];
    } else if (velocity.x == 0) {   // 还有一种情况,当滑动后手指按住不放,然后松开,此时的速度其实是为0的
        // 当前scrollView.frame的中心点（以其子坐标系计算）
        CGFloat centerX = scrollView.frame.size.width / 2 + scrollView.contentOffset.x;
        CGFloat minSpace = MAXFLOAT;
        for (UICollectionViewCell *cell in scrollView.visibleCells) {
            if (minSpace > ABS(cell.center.x - centerX)) {
                minSpace = ABS(cell.center.x - centerX);
                self.currentIndexPath = [scrollView indexPathForCell:cell];
            }
        }
    }
//    if (self.currentIndexPath.item > 499) {
//        self.currentIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];
//        [scrollView scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
////        return;
//    }
    
    targetContentOffset->x = self.currentIndexPath.item * self.step - self.fixOffsetX;
}

#pragma mark - Helper

- (void)configFirstIndexPath {
    NSInteger realLength = [self collectionView:self.collectionView numberOfItemsInSection:0];
    NSInteger itemIdx = realLength / 2;
    itemIdx -= itemIdx % self.bannerCount;
    self.currentIndexPath = [NSIndexPath indexPathForItem:itemIdx inSection:0];
}

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        BannerLayout *layout = [BannerLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(300, 180);
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
//        _collectionView.prefetchDataSource = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
//        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

@end
