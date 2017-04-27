//
//  BaseRefreshCustomCollectionViewController.h
//  magicbean
//
//  Created by yaowang on 16/4/12.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "BaseRequestViewController.h"
@interface BaseRefreshCustomCollectionViewController : BaseRequestViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



- (NSString *)collectionView:(UICollectionView *)collectionView cellIdentifierForItemAtIndexPath:(NSIndexPath *)indexPath;
- (id) collectionView:(UICollectionView *)collectionView cellDataForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView willUpdateCell:(UICollectionViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(UICollectionView *)collectionView rowAtIndexPath:(NSIndexPath *)indexPath didAction:(NSInteger) action data:(id) data;
@end
