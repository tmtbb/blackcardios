//
//  BaseRefreshPageCustomTableViewController.h
//  mgame648
//
//  Created by yaowang on 16/1/18.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "BaseRefreshListCustomTableViewController.h"
#import "LoadMoreView.h"
@interface BaseRefreshPageCustomTableViewController : BaseRefreshListCustomTableViewController{
    /**
     * 列表数据
     */
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
