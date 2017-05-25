//
//  RechargeTableViewController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RechargeTableViewControllerDelegate <NSObject>

- (void)rechargeMoney:(CGFloat)money;

@end

@interface RechargeTableViewController : UITableViewController
@property(weak,nonatomic)id<RechargeTableViewControllerDelegate> delegate;
@end
