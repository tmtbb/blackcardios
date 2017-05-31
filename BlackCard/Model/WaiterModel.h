//
//  WaiterModel.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

@interface WaiterModel : OEZModel

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;



@end

@interface WaiterServiceMDetailModel : OEZModel

@property (copy,nonatomic) NSString *createTime;         //创建时间
@property (copy,nonatomic) NSString *serviceStartTime;   //服务开始时间 可能为空
@property (copy,nonatomic) NSString *serviceEndTime;     //服务结束时间 可能为空

@property (copy,nonatomic) NSString *serviceStatusTitle; //状态描述
@property (     nonatomic) NSInteger serviceStatus;     //状态 0: 待支付(只有这状态时才能支付)
@property (copy,nonatomic) NSString *serviceDetails;    //服务描述


@property (copy,nonatomic) NSString *serviceUserTel;     //联系电话
@property (     nonatomic) double serviceAmount;        //服务价格
@property (copy,nonatomic) NSString *serviceName;        //服务名称

@property (copy,nonatomic) NSString *serviceNo;         //服务编号


@end
