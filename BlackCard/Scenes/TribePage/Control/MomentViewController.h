//
//  MomentViewController.h
//  BlackCard
//
//  Created by xmm on 2017/5/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "BaseWriteTextViewController.h"


@protocol MomentViewControllerDelegate <NSObject>

- (void)pushMomentComplete:(id)data;

@end
@interface MomentViewController : BaseWriteTextViewController

@property(copy,nonatomic)NSString *circleId;
@property(copy,nonatomic)NSString *name;
@property(weak,nonatomic)id<MomentViewControllerDelegate> delegate;
@end
