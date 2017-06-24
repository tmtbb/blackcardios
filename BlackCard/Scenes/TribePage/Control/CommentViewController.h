//
//  CommentViewController.h
//  BlackCard
//
//  Created by xmm on 2017/5/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "BaseWriteTextViewController.h"
#import "TribeModel.h"
@protocol CommentRefresh<NSObject>
-(void)commentRefresh:(NSIndexPath *)path data:(id)data;
@end
@interface CommentViewController : BaseWriteTextViewController
@property(strong,nonatomic)NSIndexPath *path;
@property(strong,nonatomic)TribeModel *myModel;
@property(assign,nonatomic)id<CommentRefresh>delegate;


-(void)publishBtnClicked;
@end
