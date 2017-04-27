//
//  BaseTableViewController.m
//  douniwan
//
//  Created by yaobanglin on 15/9/1.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "BaseRefreshTableViewController.h"
#import "UIViewController+Category.h"


@interface BaseRefreshTableViewController ()
@end

@implementation BaseRefreshTableViewController {

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefreshControl];
    if ([self.tableView tableHeaderView] == nil) {
        CGRect rect = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.frame), 0.1f);
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:rect];
    }

    
}

- (void)didRequestComplete:(id)data {
    [self.tableView reloadData];
    [self endRefreshing];

}

- (void)didRequestError:(NSError *)error {
    [super didRequestError:error];
    [self endRefreshing];
}

- (void)dealloc {
    [self performSelector:@selector(performSelectorRemoveRefreshControl)];
}
@end
