//
//  SubviewWithCollectionView.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubviewWithCollectionViewDelegate <NSObject>
@optional
- (void)collectionView:(UIView *)collectionView didAction:(NSIndexPath *)action data:(id)data;

- (void)view:(UIView *)view pageIndex:(NSInteger)pageIndex;
@end
@interface SubviewWithCollectionView : UICollectionView
@property(weak,nonatomic)id<SubviewWithCollectionViewDelegate>myDelegate;
@property(nonatomic)CGFloat minLine;
- (NSInteger)update:(id)data;
- (NSInteger)sectionWithUnmber;



- (CGFloat)minimumInteritemSpacing;
- (CGFloat)minimumLineSpacing;
- (NSString *)cellKey ;
- (UIEdgeInsets)collectionViewLayoutEdge;


;

@end
