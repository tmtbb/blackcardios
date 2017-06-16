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
- (void)getTribeListWihtPage:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@(page) forKey:@"page"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelsRequest:kHttpAPIUrl_tribeList parameters:parameters modelClass:[TribeModel class] complete:complete error:errorBlock];
    }
    
}

-(void)postTribeCommentTribeMessageId:(NSString *)tribeMessageId message:(NSString *)message  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:tribeMessageId forKey:@"tribeMessageId"];
    [parameters setObject:message forKey:@"comment"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_tribeComment parameters:parameters complete:complete error:errorBlock];
    }
    
}
- (void)getTribeCommentListWihtPage:(NSInteger)page tribeMessageId:(NSString *)tribeMessageId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@(page) forKey:@"page"];
    [parameters setObject:tribeMessageId forKey:@"tribeMessageId"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelsRequest:kHttpAPIUrl_tribeCommentList parameters:parameters modelClass:[CommentListModel class] complete:complete error:errorBlock];
    }
}
- (void)doTribePraiseTribeMessageId:(NSString *)tribeMessageId isLike:(BOOL)islike complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:tribeMessageId forKey:@"tribeMessageId"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        NSString *url = islike ? kHttpAPIUrl_tribeLikeDel : kHttpAPIUrl_tribeLikeAdd;
        [self postRequest:url parameters:parameters complete:complete error:errorBlock];
    }
    
    
}

-(void)postMessageWithMessage:(NSString *)message imageArray:(NSArray *)imageArray complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:message forKey:@"message"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self uploadFiles:kHttpAPIUrl_tribeAdd parameters:parameters fileDataArray:imageArray complete:complete error:errorBlock];
    }
}

- (void)toReportMessageId:(NSString *)tribeMessageId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:tribeMessageId forKey:@"tribeMessageId"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_toReport parameters:parameters complete:complete error:errorBlock];
    }

    
}
@end
