//
//  BaseCustomTableViewController.m
//  bluesharktv
//
//  Created by yaowang on 15/12/21.
//  Copyright © 2015年 yaowang. All rights reserved.
//

#import "BaseCustomTableViewController.h"

@interface BaseCustomTableViewController ()
@end

@implementation BaseCustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = kAppBackgroundColor;
    // Do any additional setup after loading the view.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
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

- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


- (id)tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_dataArray objectAtIndex:indexPath.row];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
