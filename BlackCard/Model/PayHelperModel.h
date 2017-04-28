//
//  PayHelperModel.h
//  mgame648
//
//  Created by yaowang on 16/7/9.
//  Copyright © 2016年 ywwl. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
#import "PayModel.h"

@interface PayHelperModel : OEZModel

//@property(copy,nonatomic)NSString *orderId;
@property(nonatomic, copy)NSString *orderNo;
@property(nonatomic,copy)NSString *orderBatchNo;
@property(copy,nonatomic)NSString *productName;
@property(copy,nonatomic)NSString *descriptionName;
@property(assign,nonatomic) BOOL isMore;
@property(nonatomic)double moneys;

@property(strong,nonatomic)PayModel *payModel;



/**
 *  设置未付款交易的超时时间，一旦超时，该笔交易就会自动被关闭。当用户输入支付密码、点击确认付款后（即创建支付宝交易后）开始计时。取值范围：1m～15d，或者使用绝对时间（示例格式：2014-06-13 16:00:00）。m-分钟，h-小时，d-天，1c-当天（1c-当天的情况下，无论交易何时创建，都在0点关闭）。该参数数值不接受小数点，如1.5h，可转换为90m。
 *  小与60s 传1m
 */
@property (nonatomic)NSInteger timeout;
/**
 *  支付订单号
 *
 *  @return 返回支付订单号
 */
- (NSString*)payOrderNo;
@end

