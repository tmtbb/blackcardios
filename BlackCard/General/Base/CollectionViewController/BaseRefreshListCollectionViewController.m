//
// Created by yaowang on 16/3/30.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import "BaseRefreshListCollectionViewController.h"


@implementation BaseRefreshListCollectionViewController {

}

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