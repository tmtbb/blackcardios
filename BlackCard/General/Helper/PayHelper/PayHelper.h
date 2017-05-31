//
//  PayHelper.h
//  mgame648
//
//  Created by iMac on 16/6/24.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayHelperModel.h"
@protocol PayHelperDelegate;
@interface PayHelper : NSObject <OEZHandleOpenURLDelegate>
@property (nonatomic, weak) id<PayHelperDelegate>delegate;

//支付所需参数model
- (void)payHelperWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data;



@end

@protocol PayHelperDelegate <NSObject>
@optional
- (void)payHelperWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data;//支付代理回掉


@end
