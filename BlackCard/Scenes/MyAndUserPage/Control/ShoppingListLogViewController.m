//
//  ShoppingListLogViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ShoppingListLogViewController.h"
#import "ShoppingListLogCell.h"
#import "PurchaseHistoryModel.h"
@interface ShoppingListLogViewController ()

@end

@implementation ShoppingListLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didRequest:(NSInteger)pageIndex {
    
    [[AppAPIHelper shared].getMyAndUserAPI getUserShoppingListWihtPage:pageIndex complete:_completeBlock error:_errorBlock];
}

- (void)didRequestComplete:(id)data {
    
    
    
    [super didRequestComplete:data];
    
}

- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"ShoppingListLogCell";
}

-  (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    PurchaseHistoryModel *model = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
    if (indexPath.row < _dataArray.count - 1) {
        PurchaseHistoryModel *next = [_dataArray objectAtIndex:indexPath.row + 1];
        [((ShoppingListLogCell *)cell) setYearMonth:model.yearMonth != next.yearMonth ? next.yearMonth : 0];
        
    }else if(indexPath.row ==  _dataArray.count - 1){
        
        [((ShoppingListLogCell *)cell) setYearMonth:-1];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PurchaseHistoryModel *model = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
    if (indexPath.row < _dataArray.count - 1) {
        PurchaseHistoryModel *next = [_dataArray objectAtIndex:indexPath.row + 1];
        
        return model.yearMonth != next.yearMonth ? 134 : 69;
        
    }else{
        return 69;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    PurchaseHistoryModel *model = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
    [self pushStoryboardViewControllerIdentifier:@"ShoppingDetailTableViewController" block:^(UIViewController *viewController) {
        [viewController setValue:model forKey:@"model"];
    }];
    
}


@end
