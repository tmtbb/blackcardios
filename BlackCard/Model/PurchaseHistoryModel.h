//
//  PurchaseHistoryModel.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/24.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

@interface PurchaseHistoryModel : OEZModel

@property(nonatomic)NSInteger tradeId; //交易id
@property(copy,nonatomic)NSString *tradeNo; //交易编号
@property(nonatomic)NSInteger tradeGoodsId; //交易商品id
@property(copy,nonatomic)NSString *tradeGoodsName; //交易商品名称
@property(copy,nonatomic)NSString *tradeGoodsNo	; //交易商品编号

@property(nonatomic)NSInteger tradeNum; //交易数量

@property(nonatomic)double tradePrice; //交易单价

@property(nonatomic)double tradeTotalPrice; //交易总价

@property(nonatomic)double tradePayPrice;// 交易支付总价


@property(nonatomic)NSInteger tradeStatus; //交易状态
@property(copy,nonatomic)NSString  *tradeTime; //交易时间毫秒



@property(copy,nonatomic)NSString *formatCreateTime;
@property(nonatomic)NSInteger yearMonth;// 格式化取出 年月
@end


@interface  MyPurseDetailModel: OEZModel

@property(nonatomic)double amount;//充值或消费金额
@property(nonatomic)double balance;//原余额

@property(copy,nonatomic)NSString *createTime; //时间
@property(copy,nonatomic)NSString *tradeNo; //交易号
@property(copy,nonatomic)NSString *tradeName; //交易名称

@property(copy,nonatomic)NSString *formatCreateTime;
@property(nonatomic)NSInteger yearMonth;// 格式化取出 年月


@end


