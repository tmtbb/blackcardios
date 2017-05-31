//
//  PayManagerHelper.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALiPay.h"
#import "WXPay.h"

@interface PayManagerHelper : NSObject<OEZHelperProtocol>


-(void)setDelegate:(id<PayHelperDelegate>)delegate;

-(void)setLazyShowDelegate:(id<PayHelperDelegate>)delegate;

- (ALiPay *)aliPay;

- (WXPay *)wxPay;


@end
