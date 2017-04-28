//
//  BaseCustomTableViewController.h
//  bluesharktv
//
//  Created by yaowang on 15/12/21.
//  Copyright © 2015年 yaowang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseCustomTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,OEZTableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

- (NSString *) tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath;

- (id) tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willUpdateCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
