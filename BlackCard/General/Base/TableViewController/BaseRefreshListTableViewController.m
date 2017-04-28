//
// Created by yaobanglin on 15/9/9.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import "BaseRefreshListTableViewController.h"
#import "LoadMoreView.h"
#import "UIViewController+LoadMoreViewController.h"
@implementation BaseRefreshListTableViewController {

}

- (void)didRequestComplete:(id)data {
    _dataArray = data;
    [super didRequestComplete:data];
    [self checkShowEmptyDataTipsView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}


- (id)tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_dataArray objectAtIndex:indexPath.row];
}

-(void) checkShowEmptyDataTipsView
{
    
    if( [_dataArray count] == 0 )
    {
        [self showEmptyDataTipsViewWithString:[self emptyDataTipsContent] type:[self emptyImageType]];
    }
    else if([self.tableView.tableHeaderView isKindOfClass:[EveryNoneView class]])
    {
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    }
}

-(void) checkShowEmptyDataTipsView:(BOOL)isSearch {
    if (isSearch) {
        [self checkShowEmptyDataTipsView];
    }
    else {
        [self.tableView setTableFooterView:[[UIView alloc] init]];
    }
}

- (NSString*) emptyDataBtnContent {
    return @"";
}

-(NSString*) emptyDataTipsContent {
    return nil;
}

- (EveryNoneType) emptyImageType {
    return EveryNoneType_message;
}

@end