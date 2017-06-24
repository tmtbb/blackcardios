//
//  CardTribeDetailViewController.h
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "BaseRefreshPageCustomTableViewController.h"
@class TribeModel;
@protocol CardTribeDetailProcotol<NSObject>



- (void)changeTribeIndexPath:(NSIndexPath *)path model:(TribeModel *)model;
@end
@interface CardTribeDetailViewController : BaseRefreshPageCustomTableViewController
@property(strong,nonatomic)TribeModel *myModel;
@property(strong,nonatomic)NSIndexPath *path;
@property(assign,nonatomic)id<CardTribeDetailProcotol>delegate;
@end
