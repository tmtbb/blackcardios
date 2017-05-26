//
//  WXPay.m
//  mgame648
//
//  Created by iMac on 16/6/30.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "WXPay.h"
#import "PayModel.h"
#import "WXApiObject.h"

@interface WXPay () <WXApiDelegate>
@end

@implementation WXPay

- (void)payWithWXModel:(WXPayModel *)model {
    
    if ([WXPay isWXAppInstalled]) {
        [self weiXinPayWithWXPayModel:model];
    }else {
//        [self didPayStrError:@"未安装微信"];
         [self payHelperWithType:PayTypeWeiXinPay withPayStatus:PayError withData:@"支付失败"];

    }
}



- (void)weiXinPayWithWXPayModel:(WXPayModel *)payModel {
    
    //注册微信APPID
    [WXApi registerApp: payModel.appid];
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = payModel.partnerid;
    request.prepayId= payModel.prepayid;
    request.package = payModel.package;
    request.nonceStr= payModel.noncestr;
    request.timeStamp = payModel.timestamp.intValue;
    request.sign= payModel.sign;
    //    [WXApi sendReq:request];
    //    APPLOG(@"kWXAppID＝%@",kWXAppID);
    [WXApi safeSendReq:request];

    
    
}



- (void)PayRespNotification:(NSNotification*)notification {
    NSDictionary *response = [notification userInfo];
    BaseResp *req = [response valueForKey:@"response"];
    [self onResp:req];
}
-(void) onResp:(BaseResp *)resp {
    switch (resp.errCode) {
        case WXSuccess://支付成功
            [self payHelperWithType:PayTypeWeiXinPay withPayStatus:PayOK withData:@"支付成功"];
            break;
        case WXErrCodeUserCancel://取消
            [self payHelperWithType:PayTypeWeiXinPay withPayStatus:PayCancel withData:@"支付取消"];
            break;
        default: {//失败
            NSString *strError = [resp errStr];
            if ([NSString isEmpty:strError]) {
                strError = @"支付异常";
            }
            [self payHelperWithType:PayTypeWeiXinPay withPayStatus:PayError withData:strError];
        }
            break;
    }
    [[OEZHandleOpenURLHelper shared] removeHandleDelegate:self];
}

+ (BOOL) isWXAppInstalled {
    return [WXApi isWXAppInstalled];
}


- (BOOL) handleOpenURL:(NSURL *)url {
    BOOL ret = [WXApi handleOpenURL:url delegate:self];
    return ret;
}

@end
