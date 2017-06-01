//
//  BlackLogHelper.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/31.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlackLogHelper : NSObject<OEZHelperProtocol>

- (void)setPayDic:(NSDictionary *)dic;
- (void)addPayInformation:(NSDictionary *)dic;
- (void)addOtherPayInformationWithPost:(NSDictionary *)dic;

- (void)postPayLogHttp;
- (void)postPayLogHttp:(NSDictionary *)dic;

- (void)theNewDic;
@end
