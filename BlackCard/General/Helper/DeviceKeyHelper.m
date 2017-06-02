//
//  DeviceKeyHelper.m
//  BlackCard
//
//  Created by yaowang on 2017/6/2.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "DeviceKeyHelper.h"

NSString *const kAppDevice_key                    = @"com.youdian.blackcard.ios.appDevice_key";
NSString *const kAppDevice_keyid                  = @"com.youdian.blackcard.ios.appDevice_id";
NSString *const kAppDevice_Normal_key             = @"24BFA1509B794899834AA9E24B447322";
NSString *const kAppDevice_Normal_keyid           = @"34474661562457";

@implementation DeviceKeyHelper

HELPER_SHARED(DeviceKeyHelper);

- (instancetype)init {
    self = [super init];
    if( self ) {
        _deviceKeyId = [self getDeviceKeyValue:kAppDevice_keyid];
        _deviceKey = [self getDeviceKeyValue:kAppDevice_key];
        if( [NSString isEmpty:_deviceKeyId] ||  [NSString isEmpty:_deviceKey] ) {
            _deviceKeyId = kAppDevice_Normal_keyid;
            _deviceKey = kAppDevice_Normal_key;
        }
    }
    return self;
}

- (NSString*)getDeviceKeyValue:(NSString*) key {
    OEZKeychainItemWrapper* keyidchain = [[OEZKeychainItemWrapper alloc] initWithIdentifier:key accessGroup:nil];
    NSString *value = [keyidchain objectForKey:CFBridgingRelease(kSecAttrAccount)];
    
    return value;
}


- (void)setDeviceKeyValue:(NSString*) key value:(NSString*) value {
   
    if( ! [NSString isEmpty:value] ) {
         OEZKeychainItemWrapper* keyidchain = [[OEZKeychainItemWrapper alloc] initWithIdentifier:key accessGroup:nil];
        [keyidchain setObject:value forKey:CFBridgingRelease(kSecAttrAccount)];
    }
}

- (void) setDeviceKey:(NSString *)deviceKey {
    if( ! [NSString isEmpty:_deviceKeyId] ) {
        _deviceKey = deviceKey;
        [self setDeviceKeyValue:kAppDevice_key value:deviceKey];
    }
    
}

- (void) setDeviceKeyId:(NSString *)deviceKeyId {
    
    if( ! [NSString isEmpty:_deviceKeyId] ) {
        _deviceKeyId = deviceKeyId;
        [self setDeviceKeyValue:kAppDevice_keyid value:deviceKeyId];
    }
    
}

@end
