//
//  EliteLifeViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TheArticleTableViewController.h"
#import "TribeModel.h"

@interface TheArticleTableViewController ()

@end

@implementation TheArticleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)didRequest:(NSInteger)pageIndex {
    
    [[AppAPIHelper shared].getTribeAPI getTheArticleListWihtType:@"1" page:pageIndex complete:_completeBlock error:_errorBlock];
    
}

- (void)didRequestComplete:(id)data {
    
    [super didRequestComplete:data];
}

- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"TheArticleTableViewCell";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TheArticleModel *model = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
    [self pushStoryboardViewControllerIdentifier:@"TheArticleDetailViewController" block:^(UIViewController *viewController) {
        [viewController setValue:model forKey:@"articleModel"];
    }];
}




@end
