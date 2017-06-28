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
- (void)getTribeListWihtPage:(NSInteger)page circleId:(NSString *)circleId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
//发表评论
-(void)postTribeCommentTribeMessageId:(NSString *)tribeMessageId message:(NSString *)message  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
//获取评论列表
- (void)getTribeCommentListWihtPage:(NSInteger)page tribeMessageId:(NSString *)tribeMessageId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

//点赞
- (void)doTribePraiseTribeMessageId:(NSString *)tribeMessageId isLike:(BOOL)islike complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
//发布消息
-(void)postMessageWithMessage:(NSString *)message imageArray:(NSArray *)imageArray circleId:(NSString *)circleId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

- (void)toReportMessageId:(NSString *)tribeMessageId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


- (void)getTheArticleListWihtType:(NSString *)type page:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

- (void)getArticleId:(NSString *)articleId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

- (void)getArticleCommentListId:(NSString *)articleId page:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


- (void)pushArticleCommentId:(NSString *)articleId comment:(NSString *)comment complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


// 部落列表
- (void)getManorDescribeListComplete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
//成员列表
- (void)getManorPersonListTribeId:(NSString *)tribeId page:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

//创建部落
/*
token	是	string	登录获得的token
name	是	string	部落名称
industry	是	string	行业
province	是	string	省份
city	是	string	城市
description	是	string	描述
file	是	stream	图片流
 */
- (void)doCreateManorWihtDic:(NSDictionary*)dic complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
// 部落信息
- (void)getManorInfoWihtManorId:(NSString *)manorId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
// 加入退出部落
- (void)doJoinOrOutManorPerson:(BOOL)inOrOut manorId:(NSString *)manorId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
// 管理成员
- (void)doAuditManorPerson:(NSString *)personId type:(NSString *)type complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

// 圈子删除发布

- (void)doDeleteCircleWihtId:(NSString *)cricleId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

// 圈子删除评论

-(void)doDeleteCircleWithCommentId:(NSString *)commentId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

// 文章删除评论
- (void)doDeleteArticleWithCommentId:(NSString *)commentId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
@end
