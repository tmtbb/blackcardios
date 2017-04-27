//
// Created by yaowang on 16/4/18.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+RefreshViewController.h"
#import <MJRefresh/MJRefresh.h>

@implementation UIViewController (RefreshViewController)

static char* KRefreshHeaderView = "KRefreshHeaderView";
static char* kContentScrollView = "kContentScrollView";

- (void)setupRefreshControl {
    [self refreshHeaderView];
    if( self.autoRefreshLoad ) {
        [self beginRefreshing];
    }
}
- (BOOL)autoRefreshLoad {
    return YES;
}

- (BOOL)refreshWhiteMode {
    return NO;
}

- (void)removeRefreshControl {
    [self performSelector:@selector(performSelectorRemoveRefreshControl) withObject:nil afterDelay:0.5];
}

- (void)beginRefreshing {
    [[self refreshHeaderView] performSelector:@selector(beginRefreshing) withObject:nil afterDelay:0.2];
}

- (void)endRefreshing {
    if( [self refreshWhiteMode]) {
        [[self refreshHeaderView] endRefreshing];
    }
    else {
        [[self refreshHeaderView] performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.2];
    }
}

- (UIScrollView *)contentScrollView {
    UIScrollView *contentView = objc_getAssociatedObject(self, kContentScrollView);
    if( contentView ) {
        return contentView;
    }
    if([self isKindOfClass:[UITableViewController class] ] ) {
        contentView = ((UITableViewController*)self).tableView;
    }
    else if([self isKindOfClass:[UICollectionViewController class] ] ) {
        contentView = ((UICollectionViewController*)self).collectionView;
    }
    else if( [self respondsToSelector:@selector(tableView)]) {
        contentView = [self valueForKey:@"tableView"];
    }
    else if( [self respondsToSelector:@selector(collectionView)]) {
        contentView = [self valueForKey:@"collectionView"];
    }
    else if( [self respondsToSelector:NSSelectorFromString(@"webView")]) {
        contentView = [[self valueForKey:@"webView"] valueForKey:@"scrollView"];
    }
    else if( [self respondsToSelector:@selector(contentView)]) {
        contentView = [self valueForKey:@"contentView"];
    }
    objc_setAssociatedObject(self, kContentScrollView, contentView, OBJC_ASSOCIATION_RETAIN);
    return  contentView;
}

- (MJRefreshNormalHeader*)refreshHeaderView {
    MJRefreshNormalHeader *headerView = objc_getAssociatedObject(self, KRefreshHeaderView);
    UIScrollView *contentView = [self contentScrollView];
    if( headerView == nil && contentView ) {
        headerView = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(didRequest)];
        //        headerView.scrollView = self.contentScrollView;
        self.contentScrollView.mj_header = headerView;
        //        headerView.delegate = (id<MJRefreshBaseViewDelegate>)self;
        //        if( [self refreshWhiteMode] )
        //            [headerView setWhiteMode];
        objc_setAssociatedObject(self, KRefreshHeaderView, headerView, OBJC_ASSOCIATION_RETAIN);
    }
    return headerView;
}

-(void) performSelectorRemoveRefreshControl
{
    if( objc_getAssociatedObject(self, KRefreshHeaderView) ) {
        [[self refreshHeaderView ] removeFromSuperview];
//        [[self refreshHeaderView] free];
        UIEdgeInsets contentInset = self.contentScrollView.contentInset;
        if( contentInset.top != 0 ) {
            contentInset.top = 0;
            self.contentScrollView.contentInset = contentInset;
        }
        objc_setAssociatedObject(self, KRefreshHeaderView, nil, OBJC_ASSOCIATION_RETAIN);
        
    }
}


- (void)refreshViewBeginRefreshing:(MJRefreshComponent *)refreshView {
    [self didRequest];
}

- (void)didRequest {

}

    
@end
