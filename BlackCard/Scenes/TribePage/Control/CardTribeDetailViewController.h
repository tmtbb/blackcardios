//
//  CardTribeDetailViewController.h
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TribeModel.h"
#import "BaseRefreshPageTableViewController.h"
@protocol PraiseRresh<NSObject>
-(void)cardTribeRefresh:(NSDictionary *)dict;
@end
@interface CardTribeDetailViewController : UIViewController
@property(strong,nonatomic)TribeModel *myModel;
@property(copy,nonatomic)NSString *id;
@property(assign,nonatomic)id<PraiseRresh>delegate;
@end
