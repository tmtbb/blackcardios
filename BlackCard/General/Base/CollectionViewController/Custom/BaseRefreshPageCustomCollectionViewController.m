//
//  BaseRefreshPageCustomCollectionViewController.m
//  magicbean
//
//  Created by yaowang on 16/4/12.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "BaseRefreshPageCustomCollectionViewController.h"
#import "UIViewController+LoadMoreViewController.h"
#import "UIViewController+RefreshViewController.h"
#import "LoadMoreView.h"
@implementation BaseRefreshPageCustomCollectionViewController
{
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [super setupLoadMore];
}


- (void)didRequest {
    if( [self isLoadData] ) {
        [self setIsLoadData:NO];
        _pageIndex = 1;
        [self loadMoreView].hidden = YES;
        [self setIsLoadMoreError:NO];
        [self setIsLoadMore:YES];
        [self didRequest:_pageIndex];
    }
}

- (void)didRequest:(NSInteger)pageIndex {
    
}

- (void)didStartLoadMore {
    ++_pageIndex;
    [self didRequest:_pageIndex];
}



- (void)didRequestError:(NSError *)error {
    if (!(_pageIndex == 1) ) {
        --_pageIndex;
        [self errorLoadMore];
    }
    [self setIsLoadData:YES];
    [super didRequestError:error];
}

- (void)didRequestComplete:(id)data {
    
    NSInteger count = [data count];
    if (_pageIndex == 1) {
        _dataArray = [[NSMutableArray alloc] initWithArray:data];
        [self endRefreshing];
    }
    else
    {
        if ( count > 0  ) {
            [self performSelector:@selector(endLoadMore) withObject:nil afterDelay:0.5];
            [_dataArray addObjectsFromArray:data];
            
        }
        else {
            [self performSelector:@selector(notLoadMore) withObject:nil afterDelay:0.5];
        }
    }
    [super didRequestComplete:_dataArray];
    [self setIsLoadData:YES];
}

- (void) dealloc {
    [self removeLoadMore];
}

@end
