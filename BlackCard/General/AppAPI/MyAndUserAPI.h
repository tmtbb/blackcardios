//
//  MyAndUserAPI.h
//  mgame648
//
//  Created by iMac on 15/11/24.
//  Copyright © 2015年 yaowang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BaseHttpAPI.h"
#import "MyAndUserModel.h"
/**
 *  我的和用户信息相关API
 */
@protocol MyAndUserAPI <NSObject>


- (void)getDeviceKeyWithComplete:(CompleteBlock)complete withError:(ErrorBlock)error;

- (void)getRegisterDeviceWithComplete:(CompleteBlock)complete withError:(ErrorBlock)error;
/**
 *  用户注册
 *
 *  @param username       用户名
 *  @param password       密码
 *  @param verifyCode     验证码
 *  @param invitationCode 邀请码
 *  @param complete       成功block
 *  @param errorBlock     失败block
 */


- (void)registerWithRegisterModel:(NSDictionary *)dic complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
/**
 *  用户注册
 *  dic
 *  @param token       注册的token（可进行注册支付 注册成功支付失败时使用 单独使用）
 *  @param phoneCode     手机验证码
 *  @param codeToken     手机验证码 token
 *  @param complete       成功block
 *  @param errorBlock     失败block
 */
- (void)registerWithPay:(NSDictionary *)dic complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

/**
 *  用户登录新接口
 *
 *  @param username    用户名
 *  @param password    密码
 *  @param complete    成功block
 *  @param errorBlock  失败block
 */

- (void)loginUserName:(NSString *)username password:(NSString *)password complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


- (void)getUserInfoWithToken:(NSString *)toekn complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


/**
 *  退出
 *
 *  @param complete <#complete description#>
 *  @param error    <#error description#>
 */
- (void)logoutWithComplete:(CompleteBlock)complete withErrer:(ErrorBlock)error;

/**
 *  忘记密码
 *
 *  @param password   新密码
 *  @param cardNum    黑卡卡号
 *  @param code       验证码
 *  @param codeToken  验证token
 *  @param complete   <#complete description#>
 *  @param errorBlock <#errorBlock description#>
 */
- (void)repassword:(NSString *)password cardNum:(NSString *)cardNum verifyCode:(NSString *)code andCodeToken:(NSString *)codeToken complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


- (void)sendBlackCardVerifyCode:(NSString *)code complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

/**
 *  发送手机验证码
 *
 *  @param code     手机号
 *  @param type     0: 注册 3: 注册支付
 *  @param complete   成功block
 *  @param error      失败block
 */

- (void)sendVerifyCode:(NSString *)code andType:(NSString *)type complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

/**
 *  意见反馈
 *
 *  @param content  反馈内容
 *  @param complete <#complete description#>
 *  @param error    <#error description#>
 */
- (void)suggestWithNote:(NSString *)content complete:(CompleteBlock)complete errer:(ErrorBlock)error;

/**
 *  账户余额明细
 *
 *  @param index      <#index description#>
 *  @param complete   <#complete description#>
 *  @param errorBlock <#errorBlock description#>
 */
- (void)detailWithPageIndex:(NSInteger)index complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

/**
 *  监测版本号
 */
- (void)checkVersionWithCheckVersion:(NSString*) channel complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
/**
 *  监测token是否有效
 */
- (void)checkTokenWithComplete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

/**
 *  第三方登录
 *
 *  @param userBandModel 所需参数
 *  @param complete      <#complete description#>
 *  @param errorBlock    <#errorBlock description#>
 */
- (void)userBandWith:(UserBandModel *)userBandModel withComplete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;




@end
