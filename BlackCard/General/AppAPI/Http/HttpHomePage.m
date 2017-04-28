//
//  HomePage.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "HttpHomePage.h"

@implementation HttpHomePage

- (void)privilegeListWithComplete:(CompleteBlock)complete withError:(ErrorBlock)error {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@1 forKey:@"isPower"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:error]) {
        
        [self postModelsRequest:kHttpAPIUrl_privilegeList parameters:parameters modelClass:[HomePageModel class] complete:complete error:error];
    }
    
}


- (void)cardListWithComplete:(CompleteBlock)complete withError:(ErrorBlock)error {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@1 forKey:@"isPower"];
    
    [self postModelRequest:kHttpAPIUrl_CardList parameters:parameters modelClass:[CardListModel class] complete:complete error:error];

    
    
}
@end
