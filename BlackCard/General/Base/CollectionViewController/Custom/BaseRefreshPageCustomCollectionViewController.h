//
//  BaseRefreshPageCustomCollectionViewController.h
//  magicbean
//
//  Created by yaowang on 16/4/12.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "BaseRefreshListCustomCollectionViewController.h"

@class LoadMoreView;

@interface BaseRefreshPageCustomCollectionViewController : BaseRefreshListCustomCollectionViewController
{
@protected
    NSInteger _pageIndex;
    LoadMoreView *_loadView;
}

//@property (nonatomic) BOOL autoLoadMore;
/**
 *  分页请求
 *
 *  @param pageIndex 页码
 */
- (void)didRequest:(NSInteger)pageIndex;

@end
