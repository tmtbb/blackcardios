//
// Created by yaowang on 16/4/18.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LoadMoreView;
@interface UIViewController (LoadMoreViewController)
- (BOOL)isOverspreadLoadMore;
- (CGFloat)loadMoreOffsetHeight;

- (void)setupLoadMore;
- (void)removeLoadMore;

- (void)didStartLoadMore;

- (void)didRequest:(NSInteger)pageIndex;

- (void)setIsLoadMore:(BOOL) value;

- (void)setIsLoadMoreError:(BOOL) value;

- (void)setIsLoadData:(BOOL) value;

- (BOOL)isLoadData;

- (void)errorLoadMore;

- (void)endLoadMore;

- (void)notLoadMore;

- (LoadMoreView*)loadMoreView;

@end