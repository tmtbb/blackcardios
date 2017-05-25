//
//  SetPasswordTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "SetPasswordTableViewController.h"

@interface SetPasswordTableViewController ()

@end

@implementation SetPasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
            
            [self pushStoryboardViewControllerIdentifier:@"ModifyCardPasswordTableViewController" block:nil];
            break;
        case 1:{
            [self pushStoryboardViewControllerIdentifier:@"ModifyPayPasswordTableViewController" block:nil];
        }
            break;
        default:
            break;
    }
    
    
    
}


@end
