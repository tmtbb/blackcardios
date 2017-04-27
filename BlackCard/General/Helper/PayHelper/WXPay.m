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
HELPER_SHARED(WXPay);
- (void)payWithModel:(PayHelperModel *)model {

    if ([WXPay isWXAppInstalled]) {
        [self weixinpay:model];
    }else {
        [self didPayStrError:@"未安装微信"];
    }
}

- (void)payWithWXModel:(WXPayModel *)model {
    
    if ([WXPay isWXAppInstalled]) {
        [self weiXinPayWithWXPayModel:model];
    }else {
        [self didPayStrError:@"未安装微信"];
    }
}

- (void)weixinpay:(PayHelperModel *)model {
    [super payWithModel:model];
    [self orderPayWithOrderModel:model payType:PayTypeALiPay complete:nil error:nil];
//    WEAKSELF
    
    
//    [[[AppAPIHelper shared] getOrderAPI] getWechatpayWithBatchNo:[model payOrderNo] complete:^(id data) {
//        WXPayModel *weChatPayModel = (WXPayModel *)data;
//        [weakSelf weiXinPayWithWXPayModel:weChatPayModel];
//            [weakSelf weiXinPayWithPrepayId:weChatPayModel.prepayid withNonceStr:weChatPayModel.noncestr withTimeStamp:weChatPayModel.timestamp withPackage:weChatPayModel.package withSign:weChatPayModel.sign];
//    } error:^(NSError *error) {
//        [weakSelf didPayError:error];
//    }];
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
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PayRespNotification:) name:kPayRespNotification object:nil];
    
    
}

- (void)weiXinPayWithPrepayId:(NSString *)prepayId
                 withNonceStr:(NSString *)nonceStr
                withTimeStamp:(NSString *)timeStamp
                  withPackage:(NSString *)package
                     withSign:(NSString *)sign {
    //注册微信APPID
    [WXApi registerApp:kWXAppID];
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = kWXMcId;
    request.prepayId= prepayId;
    request.package = package;
    request.nonceStr= nonceStr;
    request.timeStamp = timeStamp.intValue;
    request.sign= sign;
    //    [WXApi sendReq:request];
//    APPLOG(@"kWXAppID＝%@",kWXAppID);
    [WXApi safeSendReq:request];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PayRespNotification:) name:kPayRespNotification object:nil];
}

- (void)PayRespNotification:(NSNotification*)notification {
    NSDictionary *response = [notification userInfo];
    BaseResp *req = [response valueForKey:@"response"];
    [self onResp:req];
}
-(void) onResp:(BaseResp *)resp {
    switch (resp.errCode) {
        case WXSuccess://支付成功
            [self payHelperWithType:PayTypeWeiXinPay withPayStatus:PayOK withData:@""];
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
