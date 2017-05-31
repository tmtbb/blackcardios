//
//  DefaultPay.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "PayHelper.h"
#import "PayModel.h"


@interface DefaultPay : PayHelper


- (void)payWithDefaultModel:(DefaultModel *)model;


@end
