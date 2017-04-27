
//
//  BaseTableViewController.m
//  douniwan
//
//  Created by yaobanglin on 15/9/1.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIViewController+Category.h"
#import "BaseUserBandLogin.h"
@interface  BaseTableViewController()<LoginDelegate>


@end
@implementation BaseTableViewController
-(void) viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = kUIColorWithRGB(0xf5f5f5);
    if ( [self.tableView tableFooterView] == nil ) {
        UIView *view = [UIView new];
        [self.tableView setTableFooterView:view];
        view.backgroundColor = [UIColor clearColor];
    }
}


- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identifier = nil;
//    if (identifier == nil) {
//        identifier = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"Controller" withString:@"Cell"];
//    }
//    return identifier;
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
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}


- (id)tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self tableView:tableView cellIdentifierForRowAtIndexPath:indexPath];
    if (identifier != nil) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        if ([cell conformsToProtocol:@protocol(OEZUpdateProtocol)]) {
            id data = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
            [(id <OEZUpdateProtocol>) cell update:data];
        }
        return cell;
    }

    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(void) showEmptyDataTipsViewWithString:(NSString*) content type:(EveryNoneType)type
{
    UIView *view = [self showEmptyDataCustomTipsView];
    if ( view != nil ) {
        [self.tableView setTableHeaderView:view];
    }
    else if ( content != nil)
    {
        [self.tableView setTableHeaderView:[EveryNoneView everyNoneViewWith:content type:type]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //友盟页面统计
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeMBProgressHUD];
    
    //友盟页面统计
//    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (UIView*)showEmptyDataCustomTipsView {
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UINavigationBar *navigationBar = [self customNavigationBar];
    if ( navigationBar != nil) {
        CGRect rect = navigationBar.frame;
        rect.origin.y = scrollView.contentOffset.y;
        navigationBar.frame = rect;
    }
//    [super scrollViewDidScroll:scrollView];
   
}
@end
