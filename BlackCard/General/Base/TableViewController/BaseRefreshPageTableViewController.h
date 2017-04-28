//
//  BaseRefreshPageTableViewController.h
//  douniwan
//
//  Created by yaobanglin on 15/9/2.
//  Copyright (c) 2015 yaowang. All rights reserved.
//



#import "BaseTableViewController.h"
#import "BaseRequestTableViewController.h"
#import "BaseRefreshTableViewController.h"
#import "BaseRefreshListTableViewController.h"
#import "LoadMoreView.h"
/**
* TableViewController 带请求、下拉刷新、上拉加载更多 基类
*/
@interface BaseRefreshPageTableViewController : BaseRefreshListTableViewController {
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
