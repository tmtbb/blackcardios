//
//  BaseTableViewController.h
//  douniwan
//
//  Created by yaobanglin on 15/9/1.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpAPI.h"
#import "BaseTableViewController.h"
#import "BaseRequestViewController.h"
#import "BaseRequestTableViewController.h"
#import "UIViewController+RefreshViewController.h"

/**
* TableViewController 带请求下来刷新的基类
*/
@interface BaseRefreshTableViewController : BaseRequestTableViewController
@end
