//
//  SubviewWithCollectionView.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "SubviewWithCollectionView.h"


@interface SubviewWithCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(nonatomic)NSInteger pageIndex;
@property(nonatomic)NSInteger onePageCount;
@end
@implementation SubviewWithCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setWithInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setWithInit];
    }
    return self;
}
- (void)setWithInit {
    self.delegate = self;
    self.dataSource = self;
    _onePageCount = [self sectionWithUnmber];
}

- (NSInteger)sectionWithUnmber {
    CGFloat width =  kMainScreenWidth - 24 - 70 + 1;
    NSInteger count = width / (70 + 24) + 1;
    
    _minLine = (kMainScreenWidth - 24 - count * 70 ) /(count - 1.0);
    
    return  count * 2;
    
}





- (NSInteger)update:(id)data {
    
    
    NSMutableArray *array  =  [[(NSArray *)data splitTwoDimensional:_onePageCount] mutableCopy];
    NSMutableArray *lastArray = [array.lastObject mutableCopy];
    for (NSInteger  i = 0,len = _onePageCount - lastArray.count; i < len; i++) {
        [lastArray addObject:@""];
    }
    
    array[array.count - 1] = lastArray;
    _dataArray = array;
    [self reloadData];
    return _dataArray.count;
}


- (NSString *)cellKey {
    static  NSString *cellKey = @"SubviewWithCollectionViewCellKey";
    return cellKey;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(70, 70);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return  [self collectionViewLayoutEdge];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return _minLine;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [self minimumInteritemSpacing];
}

- (CGFloat)minimumLineSpacing {
    
    return _minLine;
}
- (CGFloat)minimumInteritemSpacing {
    
    return 35;
}

- (UIEdgeInsets)collectionViewLayoutEdge {
    
    return UIEdgeInsetsMake(15, 0, 10,0);
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _onePageCount;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return _dataArray.count;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.myDelegate respondsToSelector:@selector(collectionView:didAction:data: )]) {
        [self.myDelegate collectionView:collectionView didAction:indexPath data:nil];
    }
    
    
}


- (id)collectionView:(UICollectionView *)collectionView cellForDataInSection:(NSIndexPath *)index {
    return _dataArray[index.section][index.item];
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellKey]  forIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(OEZUpdateProtocol)]) {
        
        [(id<OEZUpdateProtocol>)cell update:[self collectionView:collectionView cellForDataInSection:indexPath]];
    }
//
//    
//    if ([cell valueForKey:@"delegate"]) {
//        [cell setValue:self forKey:@"delegate"];
//    }
    
    return  cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.frameWidth;
    if (index != _pageIndex) {
        _pageIndex = index;
        if ([self.myDelegate respondsToSelector:@selector(view:pageIndex:)]) {
            [self.myDelegate view:self pageIndex:_pageIndex];
        }
    }
}


@end
