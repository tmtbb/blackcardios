//
//  BaseRefreshListCustomTableViewController.h
//  mgame648
//
//  Created by yaowang on 15/12/2.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "BaseRefreshCustomTableViewController.h"
#import "EveryNoneView.h"
@interface BaseRefreshListCustomTableViewController : BaseRefreshCustomTableViewController
{
    /** 
     * 列表数据
     */
@protected
    NSMutableArray *_dataArray;
}

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
/**
 *  重设FooterView 控制是否空数据
 */
- (void)checkShowEmptyDataTipsView;
@end
