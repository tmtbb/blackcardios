//
//  BaseTableViewController.h
//  douniwan
//
//  Created by yaobanglin on 15/9/1.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpAPI.h"
#import "EveryNoneView.h"

/**
* TableViewController 基类
*/
@interface BaseTableViewController : UITableViewController<OEZTableViewDelegate>

/**
 *  获取 cell Identifier
 *
 *  @param tableView tableView description
 *  @param indexPath indexPath description
 *
 *  @return cell identifier
 */
- (NSString *) tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  获取cell数据
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (id) tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  空数据时显示view
 *
 *  @param content 空数据提示
 */
-(void) showEmptyDataTipsViewWithString:(NSString*) content type:(EveryNoneType)type;
/**
 *  空数据时显示的自定义提示view
 */
-(UIView*) showEmptyDataCustomTipsView;
@end
