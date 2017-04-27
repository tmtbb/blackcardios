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
- (void)didPayStart;//支付开始
- (void)didPayError:(NSError *)error;//支付错误信息
- (void)didPayStrError:(NSString *)err;//支付错误字符串
//支付所需参数model
- (void)payWithModel:(PayHelperModel *)model;
- (void)payHelperWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data;
- (void)orderPayWithOrderModel:(PayHelperModel*)model payType:(NSInteger)payType complete:(CompleteBlock)complete error:(ErrorBlock)error;
@end

@protocol PayHelperDelegate <NSObject>
- (void)payHelperWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data;//支付代理回掉
- (void)payStart;//支付开始回调
- (void)payError:(NSString *)error;//支付错误信息代理回调
@end