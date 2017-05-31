//
//  PayHelper.m
//  mgame648
//
//  Created by iMac on 16/6/24.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "PayHelper.h"
#import "WXPay.h"

@interface PayHelper ()
@end

@implementation PayHelper

- (instancetype)init{
    self = [super init];
    if (self) {
        [[OEZHandleOpenURLHelper shared] addHandleDelegate:self];
        
    }
    
    return self;
}









- (void)payWithMode:(id)mode {
    //根据需求 可更换使用model种类
}

- (void)payHelperWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data {
    if ([self.delegate respondsToSelector:@selector(payHelperWithType:withPayStatus:withData:)]) {
        [self.delegate payHelperWithType:type withPayStatus:payStatus withData:data];
    }

}

- (BOOL)handleOpenURL:(NSURL *)url {
    return NO;
}

- (NSString *)getKey {
    return nil;
}
@end
