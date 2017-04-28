//
//  HomePageModel.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
@class PrivilegePowerPoint;
@interface HomePageModel : OEZModel

@property (strong,nonatomic)PrivilegePowerPoint *privilegePowerType;
@property (copy,nonatomic)  NSString *privilegeIcon;
@property (strong,nonatomic)NSDictionary *privilegePowers;
@property (copy,nonatomic) NSString *privilegeImgurl;
@property (copy,nonatomic) NSString *privilegeName;
@property (nonatomic)      NSInteger privilegeId;
@property (copy,nonatomic) NSString *privilegeDescribe;


@end


@interface PrivilegePowerPoint : NSObject
@property(nonatomic)NSNumber *type;
@end

@interface  CardListModel : OEZModel

@property (strong,nonatomic)NSArray *blackcards;
@property (strong,nonatomic)NSArray *privileges;


@end



@interface  BlackCardModel : OEZModel

@property (nonatomic) double blackcardPrice;
@property (copy,nonatomic)NSString *blackcardName;
@property (nonatomic)NSInteger blackcardId;
@property (nonatomic)BOOL isChoose;

@end


@interface RegisterModel : OEZModel


@property (     nonatomic)NSInteger blackcardId;  //黑卡id
@property (copy,nonatomic)NSString *phoneNum;     //手机号
@property (copy,nonatomic)NSString *email;        //邮箱
@property (copy,nonatomic)NSString *fullName;     //真实姓名
@property (copy,nonatomic)NSString *customName;   //定制姓名名称为空为不定制
@property (copy,nonatomic)NSString *identityCard; //身份证号
@property (copy,nonatomic)NSString *addr;         //地址
@property (copy,nonatomic)NSString *addr1;        //备用地址
@property (copy,nonatomic)NSString *province;     //省份
@property (copy,nonatomic)NSString *city;         //城市

@property(strong,nonatomic)BlackCardModel  *cardModel;

@end

