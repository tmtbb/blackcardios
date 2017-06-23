//
//  MyAndUserModel.h
//  mgame648
//
//  Created by iMac on 15/11/24.
//  Copyright © 2015年 yaowang. All rights reserved.
//


@interface MyAndUserModel : OEZModel
/**
 *  我的及用户Model 我的主页
 */
@property (nonatomic, strong) NSString *userId;         //用户id
@property (nonatomic, strong) NSString *phoneNum;        //用户账号
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *username;         //真实姓名

@property (nonatomic, strong) NSString *headpic;
@property (nonatomic, strong) NSString *blackCardName;       //黑卡名称
@property (nonatomic) NSInteger blackCardId;         //黑卡id
@property (nonatomic, strong) NSString *blackCardNo;         //黑卡卡号
@property (nonatomic) double blackcardCreditline; //黑卡额度

@property (nonatomic, strong) NSString *blackCardCustomName;    //定制名称



@end





@interface UserDetailModel : OEZModel

@property(copy,nonatomic)NSString  *blackCardNo; //黑卡卡号

@property(copy,nonatomic)NSString  *position;      //职务
@property(copy,nonatomic)NSString  *phoneNum;      //手机号
@property(copy,nonatomic)NSString  *sex;           //性别
@property(copy,nonatomic)NSString  *email;         //email
@property(copy,nonatomic)NSString  *nickName;      //呢称
@property(copy,nonatomic)NSString  *headUrl;       //头像
@property(copy,nonatomic)NSString  *company;       //公司
@property(copy,nonatomic)NSString  *identityCard;  //身份证
@property(copy,nonatomic)NSString  *fullName;      //真实姓名


@end


@interface CheckPayPasswordModel : OEZModel

@property(copy,nonatomic)NSString  *phoneNum;      //手机号
@property(copy,nonatomic)NSString  *codeToken;      //验证码token
@property(copy,nonatomic)NSString  *phoneCode;      //验证码
@property(copy,nonatomic)NSString  *codeType;      //4:修改支付密码

@end



@interface VersionModel : OEZModel
@property(copy,nonatomic)NSString  *describe;      //升级描述
@property(copy,nonatomic)NSString  *url;      //iOS：appstore地址
@property(copy,nonatomic)NSString  *version;      //最新版本
@property(assign,nonatomic)NSInteger  isForce;      //是否强制 1：强制升级
@property(assign,nonatomic)NSInteger  isUpdate;      //是否有更新 1：有更新
@property(assign,nonatomic)NSInteger  versionCode;      //最新版本code


@end


//
///**
// *  第三方登陆 所需参数
// */
@interface UserBandModel : OEZModel
@property (nonatomic, strong) NSString *openId;
@property (nonatomic) NSInteger accountType;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *headpic;
@property (nonatomic, strong) NSString *appType;
@property (nonatomic, strong) NSString *unionid;
@end


