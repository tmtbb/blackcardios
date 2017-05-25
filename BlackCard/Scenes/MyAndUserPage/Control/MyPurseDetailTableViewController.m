//
//  MyPurseDetailTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "MyPurseDetailTableViewController.h"
#import "PurchaseHistoryModel.h"
#import "MyPurseDetailCell.h"
@interface MyPurseDetailTableViewController ()

@end

@implementation MyPurseDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)didRequest:(NSInteger)pageIndex {
    
    [[AppAPIHelper shared].getMyAndUserAPI getMyPurseDetailWihtPage:pageIndex complete:_completeBlock error:_errorBlock];
}

- (void)didRequestComplete:(id)data {
    
    
    
    [super didRequestComplete:data];
    
}

- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"MyPurseDetailCell";
}

-  (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MyPurseDetailModel *model = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
    if (indexPath.row < _dataArray.count - 1) {
        MyPurseDetailModel *next = [_dataArray objectAtIndex:indexPath.row + 1];
    [((MyPurseDetailCell *)cell) setYearMonth:model.yearMonth != next.yearMonth ? next.yearMonth : 0];

    }else if(indexPath.row ==  _dataArray.count - 1){
        
        [((MyPurseDetailCell *)cell) setYearMonth:-1];
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyPurseDetailModel *model = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
    if (indexPath.row < _dataArray.count - 1) {
        MyPurseDetailModel *next = [_dataArray objectAtIndex:indexPath.row + 1];
      
        return model.yearMonth != next.yearMonth ? 134 : 69;
        
    }else{
        return 69;
    }
    
}




@end
