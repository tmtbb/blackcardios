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
/**
 *  修改密码
 *
 *  @param oldPass   旧密码
 *  @param pass      新密码
 *  @param complete   <#complete description#>
 *  @param errorBlock <#errorBlock description#>
 */

- (void)repasswordOldPassword:(NSString *)oldPass andNewPassword:(NSString *)pass complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


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

- (void)checkVerifyCode:(NSString *)code phone:(NSString *)phone token:(NSString *)token  andType:(NSString *)type  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;



- (void)changePayPassword:(NSString *)password  phone:(NSString *)phone codeToken:(NSString *)token  phoneCode:(NSString *)phoneCode  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


/**
 *  充值余额
 *
 *  @param payType     支付类型 (1:微信 2:支付宝)
 *  @param money       支付金额
 *  @param complete   成功block
 *  @param error      失败block
 */
- (void)rechargeMoneyWithPayType:(NSInteger )payType andMoney:(NSString *)money complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


/**
 *  零钱明细
 *
 *  @param page       页码
 *  @param complete   成功block
 *  @param error      失败block
 */

- (void)getMyPurseDetailWihtPage:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

/**
 *  交易明细
 *
 *  @param page       页码
 *  @param complete   成功block
 *  @param error      失败block
 */
- (void)getUserShoppingListWihtPage:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

- (void)getUserBlanceComplete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


- (void)getUserDetailComplete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


- (void)doChangeUserDetail:(NSDictionary *)dic complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

- (void)doUpLoadUserHeaderIcon:(NSData *)data  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;


-(void)doLog:(NSDictionary *)dic complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

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
//获取消息列表
- (void)getTribeListWihtPage:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
//发表评论
-(void)postTribeCommentTribeMessageId:(NSString *)tribeMessageId message:(NSString *)message  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
//获取评论列表
- (void)getTribeCommentListWihtPage:(NSInteger)page tribeMessageId:(NSString *)tribeMessageId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;

//点赞
- (void)doTribePraiseTribeMessageId:(NSString *)tribeMessageId isLike:(BOOL)islike complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
//发布消息
-(void)postMessageWithMessage:(NSString *)message imageArray:(NSArray *)imageArray complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock;
@end
