//
//  HttpTribe.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/15.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "HttpTribe.h"
#import "TribeModel.h"
@implementation HttpTribe
- (void)getTribeListWihtPage:(NSInteger)page circleId:(NSString *)circleId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@(page) forKey:@"page"];
    [parameters setObject:circleId forKey:@"circleId"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelsRequest:kHttpAPIUrl_tribeList parameters:parameters modelClass:[TribeModel class] complete:complete error:errorBlock];
    }
    
}

-(void)postTribeCommentTribeMessageId:(NSString *)tribeMessageId message:(NSString *)message  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:tribeMessageId forKey:@"circleMessageId"];
    [parameters setObject:message forKey:@"comment"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelRequest:kHttpAPIUrl_tribeComment parameters:parameters modelClass:[CommentListModel class ] complete:complete error:errorBlock];
    }
    
}
- (void)getTribeCommentListWihtPage:(NSInteger)page tribeMessageId:(NSString *)tribeMessageId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@(page) forKey:@"page"];
    [parameters setObject:tribeMessageId forKey:@"circleMessageId"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelsRequest:kHttpAPIUrl_tribeCommentList parameters:parameters modelClass:[CommentListModel class] complete:complete error:errorBlock];
    }
}
- (void)doTribePraiseTribeMessageId:(NSString *)tribeMessageId isLike:(BOOL)islike complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:tribeMessageId forKey:@"circleMessageId"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        NSString *url = islike ? kHttpAPIUrl_tribeLikeDel : kHttpAPIUrl_tribeLikeAdd;
        [self postRequest:url parameters:parameters complete:complete error:errorBlock];
    }
    
    
}

-(void)postMessageWithMessage:(NSString *)message imageArray:(NSArray *)imageArray circleId:(NSString *)circleId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:message forKey:@"message"];
    [parameters setObject:circleId forKey:@"circleId"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
 WEAKSELF
        [self uploadFiles:kHttpAPIUrl_tribeAdd parameters:parameters fileDataArray:imageArray complete:^(id data) {
            [weakSelf parseModel:data modelClass:[TribeModel class] complete:complete error:errorBlock];
        } error:errorBlock];
    }
}

- (void)toReportMessageId:(NSString *)tribeMessageId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:tribeMessageId forKey:@"circleMessageId"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_toReport parameters:parameters complete:complete error:errorBlock];
    }

    
}

- (void)getTheArticleListWihtType:(NSString *)type page:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:type forKey:@"categoryId"];
    [parameters setObject:@(page) forKey:@"page"];

    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelsRequest:kHttpAPIUrl_articleList parameters:parameters modelClass:[TheArticleModel class] complete:complete error:errorBlock];
    }
    
    
    
}

- (void)getArticleId:(NSString *)articleId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:articleId forKey:@"articleId"];
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelRequest:kHttpAPIUrl_articleDetail parameters:parameters modelClass:[TheArticleDetailModel class] complete:complete error:errorBlock];
    }
    
}

- (void)getArticleCommentListId:(NSString *)articleId page:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:articleId forKey:@"articleId"];
    [parameters setObject:@(page) forKey:@"page"];

    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelsRequest:kHttpAPIUrl_articleDetailCommentList parameters:parameters modelClass:[CommentListModel class] complete:complete error:errorBlock];
    }
    
    
}

- (void)pushArticleCommentId:(NSString *)articleId comment:(NSString *)comment complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:articleId forKey:@"articleId"];
    [parameters setObject:comment forKey:@"comment"];
    
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        
        [self postModelRequest:kHttpAPIUrl_articleDetailComment parameters:parameters modelClass:[CommentListModel class] complete:complete error:errorBlock];
    }

    
    
}


- (void)getManorDescribeListComplete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];

    
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        
        [self postModelRequest:kHttpAPIUrl_manorDescribeList parameters:parameters modelClass:[ManorModel class] complete:complete error:errorBlock];
    }

    
}


- (void)getManorPersonListTribeId:(NSString *)tribeId page:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:tribeId forKey:@"tribeId"];
    [parameters setObject:@(page) forKey:@"page"];


    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        
        [self postModelsRequest:kHttpAPIUrl_manorPersonList parameters:parameters modelClass:[ManorPersonModel class] complete:complete error:errorBlock];
    }

    
}

- (void)doCreateManorWihtDic:(NSDictionary *)dic complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSData *data = [parameters objectForKey:@"image"];
    [parameters removeObjectForKey:@"image"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self uploadFiles:kHttpAPIUrl_manorCreate parameters:parameters fileDataArray:@[data] complete:complete error:errorBlock];
    }

    
}

- (void)getManorInfoWihtManorId:(NSString *)manorId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setObject:manorId forKey:@"tribeId"];
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        
        [self postModelRequest:kHttpAPIUrl_manorInfo parameters:parameters modelClass:[ManorInfoModel class] complete:complete error:errorBlock];
    }

    
}


- (void)doJoinOrOutManorPerson:(BOOL)inOrOut manorId:(NSString *)manorId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:manorId forKey:@"tribeId"];
   
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        NSString *url = inOrOut ? kHttpAPIUrl_personAddManor : kHttpAPIUrl_personDelManor;
        [self postRequest:url parameters:parameters complete:complete error:errorBlock];
    }
    
}

- (void)doAuditManorPerson:(NSString *)personId type:(NSString *)type complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:personId forKey:@"tribeMemberId"];
    [parameters setObject:type forKey:@"type"];

    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_auditManorPerson parameters:parameters complete:complete error:errorBlock];
    }
    
    
}

- (void)doDeleteCircleWihtId:(NSString *)cricleId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:cricleId forKey:@"circleMessageId"];
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_deleteCircle parameters:parameters complete:complete error:errorBlock];
    }
    
}

- (void)doDeleteCircleWithCommentId:(NSString *)commentId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:commentId forKey:@"commentId"];
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_deleteCircleComment parameters:parameters complete:complete error:errorBlock];
    }
    
}

- (void)doDeleteArticleWithCommentId:(NSString *)commentId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:commentId forKey:@"commentId"];
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_deleteArticleComment parameters:parameters complete:complete error:errorBlock];
    }
    
    
}

@end
