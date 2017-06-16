//
//  WaiterServiceAPI.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpAPI.h"


@protocol TribeAPI <NSObject>
//获取消息列表
- (void)getTribeListWihtPage:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
//发表评论
-(void)postTribeCommentTribeMessageId:(NSString *)tribeMessageId message:(NSString *)message  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
//获取评论列表
- (void)getTribeCommentListWihtPage:(NSInteger)page tribeMessageId:(NSString *)tribeMessageId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

//点赞
- (void)doTribePraiseTribeMessageId:(NSString *)tribeMessageId isLike:(BOOL)islike complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
//发布消息
-(void)postMessageWithMessage:(NSString *)message imageArray:(NSArray *)imageArray complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

- (void)toReportMessageId:(NSString *)tribeMessageId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

@end
