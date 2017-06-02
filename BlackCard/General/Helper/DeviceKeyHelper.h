//
//  DeviceKeyHelper.h
//  BlackCard
//
//  Created by yaowang on 2017/6/2.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceKeyHelper : NSObject<OEZHelperProtocol>

@property(nonatomic, strong) NSString *deviceKey;
@property(nonatomic, strong) NSString *deviceKeyId;

@end
