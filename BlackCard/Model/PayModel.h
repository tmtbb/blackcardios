//
//  PayModel.h
//  mgame648
//
//  Created by simon on 15/11/24.
//  Copyright © 2015年 yaowang. All rights reserved.
//
@class WXPayModel;
@class PayInfoModel;

@interface PayModel : OEZModel

@property(nonatomic,copy)NSString  *token;
@property(nonatomic,strong)PayInfoModel *payInfo;
@end

/**
 *  微信支付
 *
 *  @param prepayId  预支付订单
 *  @param nonceStr  随机数
 *  @param timeStamp 时间戳
 *  @param package   商家根据财付通文档填写的数据和签名
 *  @param sign      商家根据微信开放平台文档对数据做的签名
 *  @param viewController 所在viewController
 */
@interface PayInfoModel : OEZModel
@property(copy,nonatomic)NSString *sign;  //订单信息不包含wxPayInfo的sign
@property(copy,nonatomic)NSString *tradeNo;//订单号
@property(strong,nonatomic)WXPayModel *wxPayInfo;
@property(nonatomic)NSInteger payType;        //payType
@property(nonatomic)double payTotalPrice;    //支付价格
@property(copy,nonatomic)NSString *goodsName;        //交易商品信息


@end


@interface WXPayModel : OEZModel

@property(nonatomic,copy)NSString *appid;
@property(nonatomic,copy)NSString *partnerid; // 商户号
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *appsecret;

@end




