//
//  FlowCollectionViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2021/7/29.
//

#import "FlowCollectionViewController.h"
#import "MyFlowLayout.h"

@interface FlowCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

@implementation FlowCollectionViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.redColor;
    if ([cell.contentView viewWithTag:10086]) {
        UILabel *label = [cell.contentView viewWithTag:10086];
        label.text = [NSString stringWithFormat:@"%ld", indexPath.item];
    } else {
        UILabel *label = [UILabel labelWithFont:@128 text:[NSString stringWithFormat:@"%ld", indexPath.item]];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 10086;
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    
    return cell;
}

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        MyFlowLayout *layout = [MyFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(80, 80);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

@end
