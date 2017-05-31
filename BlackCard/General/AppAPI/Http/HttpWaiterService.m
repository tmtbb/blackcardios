//
//  #import "BaseHttpAPI.h" HttpWaiterService.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import"HttpWaiterService.h"
#import "WaiterModel.h"
#import "PayModel.h"
@implementation HttpWaiterService

- (void)getWaiterServiceDetailWithServiceNum:(NSString *)num Complete:(CompleteBlock)complete withError:(ErrorBlock)error {
     NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:num forKey:@"serviceNo"];
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:error]) {
        
        [self postModelRequest:kHttpAPIUrl_waiterServiceDetail parameters:parameters modelClass:[WaiterServiceMDetailModel class] complete:complete error:error];
    }
    
}

- (void)getPayWithServiceNo:(NSString *)serviceNo payType:(NSInteger)payType payPassword:(NSString *)payPassword Complete:(CompleteBlock)complete withError:(ErrorBlock)error {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:serviceNo forKey:@"serviceNo"];
     [parameters setObject:@(payType) forKey:@"payType"];
    if (payPassword ) {
     [parameters setObject:payPassword forKey:@"payPassword"];
    }
    
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:error]) {
        
        [self postModelRequest:kHttpAPIUrl_waiterPay parameters:parameters modelClass:[PayInfoModel class] complete:complete error:error];
    }
    
    
}

@end
