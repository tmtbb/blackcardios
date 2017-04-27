//
// Created by yaowang on 16/3/30.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRefreshListCollectionViewController.h"

@class LoadMoreView;


@interface BaseRefreshPageCollectionViewController : BaseRefreshListCollectionViewController
{
@protected
    NSInteger _pageIndex;
}
/**
*  分页请求
*
*  @param pageIndex 页码
*/
- (void)didRequest:(NSInteger)pageIndex;
@end