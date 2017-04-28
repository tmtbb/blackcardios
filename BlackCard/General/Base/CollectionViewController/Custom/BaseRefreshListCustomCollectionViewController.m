//
//  BaseRefreshListCustomCollectionViewController.m
//  magicbean
//
//  Created by yaowang on 16/4/12.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "BaseRefreshListCustomCollectionViewController.h"

@implementation BaseRefreshListCustomCollectionViewController


- (void)didRequestComplete:(id)data {
    _dataArray = data;
    [super didRequestComplete:data];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (id)collectionView:(UICollectionView *)collectionView cellDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_dataArray objectAtIndex:indexPath.item];
}

@end
