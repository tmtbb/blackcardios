//
//  ALiPay.m
//  mgame648
//
//  Created by iMac on 16/6/30.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "ALiPay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "NSString+Category.h"
#import "PayModel.h"
#import "BaseHttpAPI.h"
@implementation ALiPay



- (void)payWithAliModel:(AliPayModel *)model {
    
    NSDictionary *dic  = @{@"orderInfo":model.orderInfo,@"nonceStr" : model.nonceStr};
    NSString *sign =  [BaseHttpAPI localSignWithParameters:dic];
    if ([sign isEqualToString:model.paySign]) {
        [self payWithOrder:model.orderInfo];
    }else {
       [self payHelperWithType:PayTypeALiPay withPayStatus:PayError withData:@"支付失败"];
    }
    
    
}
- (void)payWithOrder:(NSString *)order {
    WEAKSELF
    
    [[AlipaySDK defaultService] payOrder:order fromScheme:@"alipayBlackCard123456" callback:^(NSDictionary *resultDic) {
        
        [weakSelf handlePayResultDic:resultDic];
           }];
     
    
    

    
}



- (void)handlePayResultDic:(NSDictionary *)resultDic{
    NSInteger status = [[resultDic objectForKey:@"resultStatus"] intValue];
    NSString *memo = [resultDic objectForKey:@"memo"];
    switch (status) {
        case 9000:{ //订单支付成功
            [self payHelperWithType:PayTypeALiPay withPayStatus:PayOK withData:@"支付成功"];
        }
            
            break;
        case 4000:{ //订单支付失败
            [self payHelperWithType:PayTypeALiPay withPayStatus:PayError withData:@"支付失败"];
        }
            break;
        case 5000:{ //重复请求
            [self payHelperWithType:PayTypeALiPay withPayStatus:PayRePay withData:memo];
        }
            break;
        case 6001:{ //用户中途取消
            [self payHelperWithType:PayTypeALiPay withPayStatus:PayCancel withData:@"支付取消"];
        }
            break;
        case 6002:{ //网络连接出错
            [self payHelperWithType:PayTypeALiPay withPayStatus:PayInternetError withData:memo];
        }
            break;
        case 8000:
        case 6004:{ //支付结果未知（有可能已经支付成功）
            
            [self payHelperWithType:PayTypeALiPay withPayStatus:PayUFO withData:memo];
        }
            break;
        default:{// 其他
            [self payHelperWithType:PayTypeALiPay withPayStatus:PayNone withData:memo];
            
        }
            
            break;
    }

    
    
}

@end
