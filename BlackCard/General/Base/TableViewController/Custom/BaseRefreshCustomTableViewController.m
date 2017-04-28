//
//  BaseRefreshCustomTableViewController.m
//  douniwan
//
//  Created by yaobanglin on 15/9/15.
//  Copyright (c) 2015 yaowang. All rights reserved.
//

#import "BaseRefreshCustomTableViewController.h"
#import "UIViewController+Category.h"
#import "UIViewController+RefreshViewController.h"
@interface BaseRefreshCustomTableViewController()
@end
@implementation BaseRefreshCustomTableViewController {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = kUIColorWithRGB(0xF0F0F0);
    self.view.backgroundColor = kUIColorWithRGB(0xF0F0F0);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self setupRefreshControl];
    if ([self.tableView tableFooterView] == nil) {
        UIView *view = [UIView new];
        [self.tableView setTableFooterView:view];
        view.backgroundColor = [UIColor clearColor];
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

- (void)dealloc
{
    [self performSelectorRemoveRefreshControl];
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [self tableView:tableView cellIdentifierForRowAtIndexPath:indexPath];
    if ( cellIdentifier ) {
        Class<OEZTableViewCellProtocol> viewClass = NSClassFromString(cellIdentifier);
        if ( [viewClass respondsToSelector:@selector(calculateHeightWithData:)]) {
            return [viewClass calculateHeightWithData:[self tableView:tableView cellDataForRowAtIndexPath:indexPath]];
        }
    }
    return tableView.rowHeight;
}

- (id)tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self tableView:tableView cellIdentifierForRowAtIndexPath:indexPath];
    if (identifier != nil) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        if ([cell conformsToProtocol:@protocol(OEZUpdateProtocol)]) {
            [self tableView:tableView willUpdateCell:cell forRowAtIndexPath:indexPath];
            id data = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
            [(id <OEZUpdateProtocol>) cell update:data];
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willUpdateCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
