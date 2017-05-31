//
//  CardTribeDetailTabelViewController.h
//  BlackCard
//
//  Created by xmm on 2017/5/31.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRefreshPageTableViewController.h"
#import "TribeModel.h"

@interface CardTribeDetailTabelViewController : BaseRefreshPageTableViewController
@property(strong,nonatomic)TribeModel *myModel;
@end
