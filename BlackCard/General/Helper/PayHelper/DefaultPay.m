//
//  DefaultPay.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "DefaultPay.h"

@implementation DefaultPay

- (void)payWithDefaultModel:(DefaultModel *)model {
    WEAKSELF
    
   NSMutableDictionary *dic = [@{@"event" : @"service_pay",@"amount" : @(model.money),@"payType":@(0)} mutableCopy];
    
    [[AppAPIHelper shared].getWaiterServiceAPI getPayWithServiceNo:model.serviceNo payType:0 payPassword:model.payPassword Complete:^(PayInfoModel *data) {
        
        [dic setObject:data.tradeNo forKey:@"tradeNo"];
        [dic setObject:@0 forKey:@"returnCode"];
        [dic  setObject:@"成功" forKey:@"returnMsg"];
        [weakSelf payHelperWithType:PayTypeDefaultPay withPayStatus:PayOK withData:@"支付成功"];
        [[AppAPIHelper shared].getMyAndUserAPI doLog:dic complete:nil error:nil];

        
    } withError:^(NSError *error) {
        [dic setObject:model.serviceNo forKey:@"tradeNo"];
        [dic setObject:@2 forKey:@"returnCode"];
          NSString *stringError = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
        [dic  setObject:stringError  forKey:@"returnMsg"];
        
         [weakSelf payHelperWithType:PayTypeDefaultPay withPayStatus:PayError withData:@"支付失败"];
        [[AppAPIHelper shared].getMyAndUserAPI doLog:dic complete:nil error:nil];

    }];
    
 
    
    
}

@end
