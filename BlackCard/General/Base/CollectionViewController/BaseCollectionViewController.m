//
// Created by yaowang on 16/3/30.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "BaseCollectionViewCell.h"
@interface BaseCollectionViewController ()<CustomCollectionViewCellActionDelegate>

@end

@implementation BaseCollectionViewController {

}

- (NSString *)collectionView:(UICollectionView *)collectionView cellIdentifierForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (id)collectionView:(UICollectionView *)collectionView cellDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self collectionView:collectionView cellIdentifierForItemAtIndexPath:indexPath];
    UICollectionViewCell *cell = nil;
    if (identifier != nil) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    }
    else {
        cell =  [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    
    
    if ( [cell isKindOfClass:[BaseCollectionViewCell class]] && ((BaseCollectionViewCell *)cell).delegate == nil) {
        ((BaseCollectionViewCell *)cell).delegate = self;
    }

    if ([cell conformsToProtocol:@protocol(OEZUpdateProtocol)]) {
        [self collectionView:collectionView willUpdateCell:cell forRowAtIndexPath:indexPath];
        id data = [self collectionView:collectionView cellDataForItemAtIndexPath:indexPath];
        [(id <OEZUpdateProtocol>) cell update:data];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willUpdateCell:(UICollectionViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)view:(UIView *)view didAction:(NSInteger)action andData:(id)data {
    if ([view isKindOfClass:[BaseCollectionViewCell class]]) {
        NSIndexPath *index =   [self.collectionView indexPathForCell:(UICollectionViewCell *)view];
        [self collectionView:self.collectionView rowAtIndexPath:index didAction:action data:data];
    }
}


- (void)collectionView:(UICollectionView *)collectionView rowAtIndexPath:(NSIndexPath *)indexPath didAction:(NSInteger) action data:(id) data {
    
}

@end