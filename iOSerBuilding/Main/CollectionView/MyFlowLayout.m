//
//  MyFlowLayout.m
//  iOSerBuilding
//
//  Created by 张海川 on 2021/7/28.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout {
    //这个数组就是我们自定义的布局配置数组
    NSMutableArray * _attributeAttay;
    
    CGFloat _leftLine;
    CGFloat _rightLine;
    
    CGFloat _itemWidth;
    
    NSMutableArray *_itemFramesArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _leftLine = _rightLine = 0;
        
        CGFloat spaceSum = self.sectionInset.left + self.sectionInset.right + self.minimumInteritemSpacing;
        _itemWidth = (kScreenWidth - spaceSum) / 2;
        _itemFramesArray = [NSMutableArray new];
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

//数组的相关设置在这个方法中
//布局前的准备会调用这个方法
//-(void)prepareLayout{
//    _attributeAttay = [[NSMutableArray alloc]init];
//    [super prepareLayout];
//    //演示方便 我们设置为静态的2列
//    //计算每一个item的宽度
//    float WIDTH = ([UIScreen mainScreen].bounds.size.width-self.sectionInset.left-self.sectionInset.right-self.minimumInteritemSpacing)/2;
//    //定义数组保存每一列的高度
//    //这个数组的主要作用是保存每一列的总高度，这样在布局时，我们可以始终将下一个Item放在最短的列下面
//    CGFloat colHight[2]={self.sectionInset.top,self.sectionInset.bottom};
//    //itemCount是外界传进来的item的个数 遍历来设置每一个item的布局
//    for (int i=0; i<_itemCount; i++) {
//        //设置每个item的位置等相关属性
//        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
//        //创建一个布局属性类，通过indexPath来创建
//        UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
//        //随机一个高度 在40——190之间
//        CGFloat hight = arc4random()%150+40;
//        //哪一列高度小 则放到那一列下面
//        //标记最短的列
//        int width=0;
//        if (colHight[0]<colHight[1]) {
//            //将新的item高度加入到短的一列
//            colHight[0] = colHight[0]+hight+self.minimumLineSpacing;
//            width=0;
//        }else{
//            colHight[1] = colHight[1]+hight+self.minimumLineSpacing;
//            width=1;
//        }
//
//        //设置item的位置
//        attris.frame = CGRectMake(self.sectionInset.left+(self.minimumInteritemSpacing+WIDTH)*width, colHight[width]-hight-self.minimumLineSpacing, WIDTH, hight);
//        [_attributeAttay addObject:attris];
//    }
//
//    //设置itemSize来确保滑动范围的正确 这里是通过将所有的item高度平均化，计算出来的(以最高的列位标准)
//    if (colHight[0]>colHight[1]) {
//        self.itemSize = CGSizeMake(WIDTH, (colHight[0]-self.sectionInset.top)*2/_itemCount-self.minimumLineSpacing);
//    }else{
//          self.itemSize = CGSizeMake(WIDTH, (colHight[1]-self.sectionInset.top)*2/_itemCount-self.minimumLineSpacing);
//    }
//
//}

//这个方法中返回我们的布局数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    for (UICollectionViewLayoutAttributes *attri in array) {
        if (attri.indexPath.item < _itemFramesArray.count) {
            // 这个item已经计算过了，直接赋值
            attri.frame = [_itemFramesArray[attri.indexPath.item] CGRectValue];
            NSLog(@"----------");
            LogRect(attri.frame);
            continue;
        }
        CGFloat itemHeight = [self.dataSource myFlowLayout:self heightForItemAtIndexPath:attri.indexPath];
        if (_leftLine <= _rightLine) {
            // 加到左边
            attri.frame = CGRectMake(self.sectionInset.left, _leftLine + self.minimumLineSpacing, _itemWidth, itemHeight);
            _leftLine += self.minimumLineSpacing + itemHeight;
        } else {
            // 加到右边
            attri.frame = CGRectMake(self.sectionInset.left + _itemWidth + self.minimumLineSpacing, _rightLine + self.minimumLineSpacing, _itemWidth, itemHeight);
            _rightLine += self.minimumLineSpacing + itemHeight;
        }
        [_itemFramesArray addObject:[NSValue valueWithCGRect:attri.frame]];
        LogRect(attri.frame);
    }
    
    return array;
}

@end
