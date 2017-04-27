//
//  BaseRefreshCustomTableViewController.h
//  douniwan
//
//  Created by yaobanglin on 15/9/15.
//  Copyright (c) 2015 yaowang. All rights reserved.
//

#import "BaseRequestViewController.h"

@interface BaseRefreshCustomTableViewController : BaseRequestViewController<UITableViewDataSource,UITableViewDelegate,OEZTableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (NSString *) tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath;

- (id) tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willUpdateCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
