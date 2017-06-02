//
//  BlackLogHelper.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/31.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "BlackLogHelper.h"


@interface BlackLogHelper ()
@property(strong,nonatomic)NSMutableDictionary *payLogDic;
@end
@implementation BlackLogHelper

HELPER_SHARED(BlackLogHelper);

- (void)setPayDic:(NSDictionary *)dic {
   
    _payLogDic = [NSMutableDictionary dictionaryWithDictionary:dic];
}


- (void)addPayInformation:(NSDictionary *)dic {
    if (_payLogDic) {
        [_payLogDic addEntriesFromDictionary:dic];
    }else{
        [self setPayDic:dic];
    }
    
}

- (void)addOtherPayInformationWithPost:(NSDictionary *)dic {
    [self addPayInformation:dic];
    [self postPayLogHttp];
}

- (void)postPayLogHttp{
    
    if (_payLogDic) {
        [[AppAPIHelper shared].getMyAndUserAPI doLog:_payLogDic complete:nil error:nil];
        _payLogDic = nil;
    }

}

- (void)postPayLogHttp:(NSDictionary *)dic {
    
    [[AppAPIHelper shared].getMyAndUserAPI doLog:dic complete:nil error:nil];
}

- (void)theNewDic {
    _payLogDic = nil;
}
@end
