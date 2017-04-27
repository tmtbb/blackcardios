//
// Created by yaowang on 16/3/30.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import "BaseRefreshCollectionViewController.h"
#import "UIViewController+Category.h"

//NSString *const RefreshPullToRefresh = @"下拉刷新";
//NSString *const RefreshReleaseToRefresh = @"松开立即刷新";
//NSString *const RefreshRefreshing = @"加载数据中...";
//NSString *const RefreshError = @"加载失败!";
#define kAfterDelay 0.25
#define kTipsDefaultDelay 2.5
@interface BaseRefreshCollectionViewController()
@end
@implementation BaseRefreshCollectionViewController {
//    MJRefreshHeaderView *_refreshHeaderView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.alwaysBounceVertical = YES;
     [self setupRefreshControl];

}


- (void)dealloc {
    
    [self performSelector:@selector(performSelectorRemoveRefreshControl)];
}



- (void)didRequestComplete:(id)data {
    [self.collectionView reloadData];
    [self endRefreshing];

}

- (void)didRequestError:(NSError *)error {
    [super didRequestError:error];
    [self endRefreshing];
}
@end