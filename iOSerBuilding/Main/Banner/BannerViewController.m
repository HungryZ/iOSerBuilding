//
//  BannerViewController.m
//  iOSerBuilding
//
//  Created by 张海川 on 2019/5/8.
//

#import "BannerViewController.h"
#import "CWCarouselHeader.h"

@interface BannerViewController () <CWCarouselDatasource, CWCarouselDelegate>

@property (nonatomic, strong) CWCarousel * bannerView;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CWFlowLayout * layout = [[CWFlowLayout alloc] initWithStyle:3];
    layout.itemSpace_H = 5;
    layout.minScale = 0.88;
    layout.itemWidth = AdaptedWidth(350);
    _bannerView = [[CWCarousel alloc] initWithFrame:CGRectZero
                                           delegate:self
                                         datasource:self
                                         flowLayout:layout];
    _bannerView.isAuto = NO;
    _bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    _bannerView.autoTimInterval = 2;
    _bannerView.endless = YES;
    _bannerView.backgroundColor = [UIColor whiteColor];
    [_bannerView registerViewClass:[UICollectionViewCell class] identifier:@"cellId"];
    [self.view addSubview:_bannerView];
    [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNaviHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
    [_bannerView freshCarousel];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.bannerView controllerWillAppear];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.bannerView controllerWillDisAppear];
//}

- (NSInteger)numbersForCarousel {
    return 3;
}

#pragma mark - Delegate
- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    UICollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor cyanColor];
    UIImageView *imgView = [cell.contentView viewWithTag:7];
    if(!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imgView.tag = 7;
        imgView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:imgView];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 5;
    }
    
    NSString *name = [NSString stringWithFormat:@"%ld.JP", index];
    UIImage *img = [UIImage imageNamed:name];
    if(!img) {
        NSLog(@"%@", name);
    }
    [imgView setImage:img];
    return cell;
}

- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    NSLog(@"...%ld...", (long)index);
}

@end
