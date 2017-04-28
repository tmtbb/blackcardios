//
// Created by yaobanglin on 15/9/9.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRefreshTableViewController.h"
#import "EveryNoneView.h"

@interface BaseRefreshListTableViewController : BaseRefreshTableViewController {
    /**
    * 列表数据
    */
@protected
    NSMutableArray *_dataArray;
}

-(NSString*) emptyDataTipsContent;

- (EveryNoneType) emptyImageType;
@end