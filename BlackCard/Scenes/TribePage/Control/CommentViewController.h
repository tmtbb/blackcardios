//
//  CommentViewController.h
//  BlackCard
//
//  Created by xmm on 2017/5/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TribeModel.h"
@protocol CommentRefresh<NSObject>
-(void)refresh:(NSDictionary *)dict;
@end
@interface CommentViewController : UIViewController
@property(copy,nonatomic)NSString *id;
@property(strong,nonatomic)TribeModel *myModel;
@property(assign,nonatomic)id<CommentRefresh>delegate;
@end
