//
//  PayHelper.m
//  mgame648
//
//  Created by iMac on 16/6/24.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "PayHelper.h"
#import "WXPay.h"

@interface PayHelper ()
@end

@implementation PayHelper

- (instancetype)init{
    self = [super init];
    if (self) {
        [[OEZHandleOpenURLHelper shared] addHandleDelegate:self];
        
    }
    
    return self;
}

- (void)payWithModel:(PayHelperModel *)model {
    if( model ) {
        [self didPayStart];
    }
}



- (void)orderPayWithOrderModel:(PayHelperModel*)model payType:(NSInteger)payType complete:(CompleteBlock)complete error:(ErrorBlock)error {
    NSString *orderNo = nil;
    NSString *orderBatchNo = nil;
    if(model.isMore) {
        orderBatchNo = model.orderBatchNo;
    }
    else {
        orderNo = model.orderNo;
    }
//    [[[AppAPIHelper shared] getOrderAPI] orderPayWithOrderNo:orderNo orderBatchNo:orderBatchNo payType:payType complete:complete error:error];
    
}


- (void)didPayStart {
    if ([self.delegate respondsToSelector:@selector(payStart)]) {
        [self.delegate payStart];
    }
}

- (void)didPayError:(NSError *)error {
    [[OEZHandleOpenURLHelper shared] removeHandleDelegate:self];
    if ([self.delegate respondsToSelector:@selector(payError:)]) {
        NSString *stringError = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
        [self.delegate payError:stringError];
    }
}

- (void)didPayStrError:(NSString *)err {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:err forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:kAppNSErrorDomain code:kAppNSErrorLoginCode userInfo:userInfo];
    [self didPayError:error];
}

- (void)payWithMode:(id)mode {
    //根据需求 可更换使用model种类
}

- (void)payHelperWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data {
    if ([self.delegate respondsToSelector:@selector(payHelperWithType:withPayStatus:withData:)]) {
        [self.delegate payHelperWithType:type withPayStatus:payStatus withData:data];
    }

}

- (BOOL)handleOpenURL:(NSURL *)url {
    return NO;
}

- (NSString *)getKey {
    return nil;
}
@end
