//
//  WXPay.h
//  mgame648
//
//  Created by iMac on 16/6/30.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "PayHelper.h"
#import "WXApi.h"
@class WXPayModel;
@interface WXPay : PayHelper<OEZHelperProtocol,WXApiDelegate>
+ (BOOL) isWXAppInstalled;
- (void)payWithWXModel:(WXPayModel *)model;
@end
