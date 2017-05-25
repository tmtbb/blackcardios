//
//  ALiPay.h
//  mgame648
//
//  Created by iMac on 16/6/30.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "PayHelper.h"
@class AliPayModel;
@interface ALiPay : PayHelper
- (void)payWithAliModel:(AliPayModel *)model;

- (void)handlePayResultDic:(NSDictionary *)resultDic;

@end
