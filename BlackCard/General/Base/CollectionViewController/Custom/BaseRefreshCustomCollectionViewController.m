//
//  BaseRefreshCustomCollectionViewController.m
//  magicbean
//
//  Created by yaowang on 16/4/12.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "BaseRefreshCustomCollectionViewController.h"
#import "UIViewController+RefreshViewController.h"
#import "BaseCollectionViewCell.h"
@interface BaseRefreshCustomCollectionViewController()<UICollectionViewDataSource,UICollectionViewDelegate,CustomCollectionViewCellActionDelegate>
@end
@implementation BaseRefreshCustomCollectionViewController
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
     [self setupRefreshControl];
}






- (void)didRequestComplete:(id)data {
    [self.collectionView reloadData];
    [self endRefreshing];

}

- (void)didRequestError:(NSError *)error {
    [super didRequestError:error];
    [self endRefreshing];
}


- (void)dealloc {
    [self performSelector:@selector(performSelectorRemoveRefreshControl)];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
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
