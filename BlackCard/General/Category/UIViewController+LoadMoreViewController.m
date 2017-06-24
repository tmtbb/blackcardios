//
// Created by yaowang on 16/4/18.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+LoadMoreViewController.h"
#import "UIViewController+RefreshViewController.h"
#import "LoadMoreView.h"
NSString *const kRefreshContentOffset = @"contentOffset";
NSString *const kRefreshContentSize = @"contentSize";
static char *const kIsLoadData = "kIsLoadData";
static char *const kLoadMoreView = "kLoadMoreView";
static char *const kIsLoadMore = "kIsLoadMore";
static char *const kIsLoadMoreError = "kIsLoadMoreError";
//static char *const kPageIndex = "kPageIndex";


@implementation UIViewController (LoadMoreViewController)

- (BOOL)isOverspreadLoadMore {
    return YES;
}

- (CGFloat)loadMoreOffsetHeight {
    return 40.0f;
}

- (void)setupLoadMore {
    [self.contentScrollView addObserver:self forKeyPath:kRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [self.contentScrollView addObserver:self forKeyPath:kRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
}


- (void)didStartLoadMore {

}

- (void)startLoadMore {
    if( self.isLoadMore ) {
        [self setIsLoadData:NO];
        [self.loadMoreView setHidden:NO];
        [self.loadMoreView startLoadMore];
        [self didStartLoadMore];
    }
}

- (void) didStartLoadMoreView:(LoadMoreView*) view {
    [self setIsLoadMoreError:NO];
    [self startLoadMore];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if( self.contentScrollView != object )
        return;

    if ([kRefreshContentOffset isEqualToString:keyPath])
    {
        CGFloat height = CGRectGetHeight(self.contentScrollView.frame);
        CGFloat contentHeight = self.contentScrollView.contentSize.height;


        if ( [self isLoadMore]  &&
                ( ! self.isOverspreadLoadMore ||
                        contentHeight >= height )
                ) {

            CGFloat distanceFromBottom = contentHeight - self.contentScrollView.contentOffset.y;
            distanceFromBottom -= self.contentScrollView.contentInset.bottom ;
            distanceFromBottom -= self.contentScrollView.contentInset.top ;
            distanceFromBottom -= self.loadMoreOffsetHeight;
            if ( [self isLoadMore]  && distanceFromBottom <= height ) {
                [self startLoadMore];
            }
        }
    }
    else if ([kRefreshContentSize isEqualToString:keyPath] && objc_getAssociatedObject(self, kLoadMoreView) )
    {
        CGRect rect = [self loadMoreView].frame;
        rect.origin.y = self.contentScrollView.contentSize.height;
        [self.loadMoreView setFrame:rect];
    }
}


- (LoadMoreView*)loadMoreView {
    LoadMoreView *view = objc_getAssociatedObject(self, kLoadMoreView);
    if ( view == nil ) {
        view = [LoadMoreView loadFromNib];
        CGRect rect = view.frame;
        rect.size.width = kMainScreenWidth;
        rect.origin.y = self.contentScrollView.contentSize.height;
        UIEdgeInsets edgeInsets = self.contentScrollView.contentInset;
        edgeInsets.bottom += CGRectGetHeight(rect);
        self.contentScrollView.contentInset = edgeInsets;
        [view setFrame:rect];
        [self.contentScrollView addSubview:view];
        view.activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        view.delegate = (id<OEZViewActionProtocol>)self;
         objc_setAssociatedObject(self, kLoadMoreView, view, OBJC_ASSOCIATION_RETAIN);
    }
    return view;
}


- (BOOL) isLoadData {
    return [self isGetAssociated:kIsLoadData default:YES];
}

- (BOOL)isLoadMore {
    return !self.isLoadMoreError && [self isGetAssociated:kIsLoadMore default:YES] && self.isLoadData;
}

- (void)setIsLoadMore:(BOOL) value {
    objc_setAssociatedObject(self, kIsLoadMore, @(value), OBJC_ASSOCIATION_RETAIN);
}


- (void)setIsLoadData:(BOOL) value {
    objc_setAssociatedObject(self, kIsLoadData, @(value), OBJC_ASSOCIATION_RETAIN);
}


- (void)setIsLoadMoreError:(BOOL) value {
    objc_setAssociatedObject(self, kIsLoadMoreError, @(value), OBJC_ASSOCIATION_RETAIN);
}


- (BOOL) isLoadMoreError {
    return [self isGetAssociated:kIsLoadMoreError default:NO];
}

- (BOOL) isGetAssociated:(char*) name default:(BOOL)def {
    if( objc_getAssociatedObject(self, name) ) {
        return [objc_getAssociatedObject(self, name) boolValue];
    }
    return def;
}

- (void)didRequest:(NSInteger)pageIndex {

}

- (void)errorLoadMore {
    [self.loadMoreView errorLoadMore];
    [self setIsLoadMoreError:YES];
}

- (void)endLoadMore {
    [self.loadMoreView endLoadMore];
}


- (void)notLoadMore {
    [self setIsLoadMore:NO];
    [self.loadMoreView notMore];
}

- (void)removeLoadMore {
    [self.contentScrollView removeObserver:self forKeyPath:kRefreshContentOffset context:nil];
    [self.contentScrollView removeObserver:self forKeyPath:kRefreshContentSize context:nil];
}

@end
