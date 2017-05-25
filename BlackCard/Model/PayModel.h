//
//  PayModel.h
//  mgame648
//
//  Created by simon on 15/11/24.
//  Copyright © 2015年 yaowang. All rights reserved.
//
@class WXPayModel;
@class PayInfoModel;
@class AliPayModel;
@interface PayModel : OEZModel

@property(nonatomic,copy)NSString  *token;
@property(nonatomic,strong)PayInfoModel *payInfo;
@end



@interface PayInfoModel : OEZModel
@property(copy,nonatomic)NSString *sign;  //订单信息不包含wxPayInfo的sign
@property(copy,nonatomic)NSString *tradeNo;//订单号
@property(strong,nonatomic)WXPayModel *wxPayInfo;
@property(strong,nonatomic)AliPayModel *aliPayInfo;
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

@interface AliPayModel : OEZModel
@property(nonatomic,copy)NSString *orderInfo;
@property(nonatomic,copy)NSString *paySign;
@property(nonatomic,copy)NSString *nonceStr;
@end




