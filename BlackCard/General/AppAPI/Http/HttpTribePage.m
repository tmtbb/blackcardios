//
//  HttpTribePage.m
//  BlackCard
//
//  Created by xmm on 2017/5/29.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "HttpTribePage.h"
#import "TribeModel.h"

@implementation HttpTribePage
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
    [parameters setObject:message forKey:@"message"];
    [self postRequest:kHttpAPIUrl_tribeComment parameters:parameters complete:complete error:errorBlock];
    
}
@end
