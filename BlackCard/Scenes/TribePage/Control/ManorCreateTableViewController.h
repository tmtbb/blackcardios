//
//  ManorCreateTableViewController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ManorCreateControllerProcotol <NSObject>

- (void)manorCreateSuccess:(id)data;

@end
@interface ManorCreateTableViewController : UITableViewController

@property(weak,nonatomic)id<ManorCreateControllerProcotol> delegate;
@end
