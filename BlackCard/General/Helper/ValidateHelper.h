//
//  ValidateHelper.h
//  douniwan
//
//  Created by yaobanglin on 15/4/21.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ValidateHelper : NSObject <OEZHelperProtocol>
- (BOOL)checkAccount:(NSString *)account error:(NSError **)error;
- (BOOL)checkCashName:(NSString *)cashName error:(NSError **)error;
- (BOOL) checkCashMoney:(NSString *)cashMoney minMoney:(NSString *)minMoney maxMoney:(NSString*)maxMoney realMoney:(NSString*)realMoney error:(NSError **)error;

/**
 *  检测字符串为非空
 *
 *  @param string   检测字符串
 *  @param error    error输出
 *  @param strError 错误描述
 *
 *  @return 返回是否合法
 */
-(BOOL) checkStringNotEmpty:(NSString *)string error:(NSError**) error strError:(NSString*) strError;
/**
 *  检测用户手机号
 *
 *  @param userPhone 用户手机号
 *  @param error     错误信息
 *
 *  @return 返回是否合法
 */
- (BOOL) checkUserPhone:(NSString*)userPhone error:(NSError **)error ;

- (BOOL) checkEmail:(NSString*)email error:(NSError **)error ;

- (BOOL) checkPersonIdentityNumebr:(NSString*)identityNumber error:(NSError **)error ;

- (BOOL)checkUserPhoneOrQQNumber:(NSString *)userPhone error:(NSError *__autoreleasing *)error;

/**
 *  检测用户密码
 *
 *  @param userPass 用户密码
 *  @param error    错误信息
 *  @param strError 错误描述
 *
 *  @return 返回是否合法
 */
//- (BOOL) checkUserPass:(NSString*)userPass error:(NSError **)error strError:(NSString*) strError;
/**
 *  检测用户密码
 *
 *  @param userPass 用户密码
 *  @param error   错误信息
 *
 *  @return 返回是否合法
 */
- (BOOL) checkUserPass:(NSString*)userPass error:(NSError **)error;
- (BOOL)checkUserPass:(NSString *)userPass emptyString:(NSString *)empty  error:(NSError *__autoreleasing *)error;
/**
 *  检测用户密码（老版只检测长度 兼容老用户密码）
 *
 *  @param userPass <#userPass description#>
 *  @param error    <#error description#>
 *
 *  @return <#return value description#>
 */

//- (BOOL)checkUserPass:(NSString *)userPass error:(NSError **)error;
/**
 *  检测两次密码是否一致
 *
 *  @param userPass  userPass
 *  @param userPass1 userPass1
 *  @param error     错误信息
 *
 *  @return 返回是否合法
 */
- (BOOL) checkUserTowPass:(NSString*)userPass userPass1: (NSString*) userPass1 error:(NSError **)error;
/**
 *  检测用户验证码
 *
 *  @param verifyCode 验证码
 *  @param error      错误信息
 *
 *  @return 返回是否合法
 */
-(BOOL)  checkVerifyCode:(NSString*)verifyCode error:(NSError **)error;
/**
 *  检测用户账号
 *
 *  @param userName 账号
 *  @param error    错误信息
 *
 *  @return 返回是否合法
 */
-(BOOL)  checkUserName:(NSString*) userName error:(NSError **)error;
/**
 *  检测反馈内容
 *
 *  @param feedback  反馈内容
 *  @param error    错误信息
 *
 *  @return 返回是否合法
 */
-(BOOL)  checkFeedback:(NSString*) feedback error:(NSError **)error;

-(BOOL)  isPhoneNumber:(NSString*) phoneNumber;



-(BOOL)checkNumber:(NSString *)number emptyString:(NSString *)empty errorString:(NSString *)errorStr error:(NSError **)error;

- (BOOL)checkDecimalNumber:(NSString *)number emptyString:(NSString *)empty errorString:(NSString *)errorStr error:(NSError **)error;


- (BOOL)checkMoneyIsDecimal:(BOOL)isDecimal money:(NSString *)money error:(NSError **)error ;


/**
 *  <#Description#>
 *
 *  @param number <#number description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) isNumber:(NSString*)number;
/**
 *  <#Description#>
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) isEmoji:(NSString *)string;
/**
 *    检查填写订单上 的 用户名 密码 角色名 是否符合要求
 *  @param string       1- 40 个字符
 *  @param error    <#error description#>
 *  @param strError 错误提示
 *  @param strEmpty 为空的提示
 *
 *  @return <#return value description#>
 */
- (BOOL)checkStringLength:(NSString *)string error:(NSError **)error strError:(NSString *)strError
                 emptyStr:(NSString *)strEmpty;

- (BOOL)checkNumberAndLetter:(NSString *)number emptyString:(NSString *)empty errorString:(NSString *)errorStr error:(NSError *__autoreleasing *)error;
- (BOOL)checkLetter:(NSString *)number emptyString:(NSString *)empty errorString:(NSString *)errorStr error:(NSError *__autoreleasing *)error;
/**
 *  检测自定义正则表达式的结果
 *
 *  @param regular  正则表达式 
 *  @param string   检测字符串
 *  @param error
 *  @param strError 错误提示
 *  @param strEmpty 字符为空的提示
 *
 *  @return <#return value description#>
 */
- (BOOL)checkStringWithRegular:(NSString *)regular checkString:(NSString *)string error:(NSError **)error strError:(NSString *)strError emptyStr:(NSString *)strEmpty;

- (BOOL)checkQQAccount:(NSString *)string error:(NSError **)error;
//判断UITextField最大字符限制-无表情
-(NSString*)textValueChange:(UITextField*)testFiled withWordCount:(int)wordCount;
//判断UITextField最大字符限制-含系统表情
-(NSString*)textValueChange:(UITextField*)testFiled withOrirRemarkName:(NSString*)orirRemarkName withWordCount:(int)wordCount;
-(CGFloat)getTextViewContentH:(UITextView *)textView;

/**
 *  联系客服QQ
 *
 *  @param view 调用界面
 */
//-(void)connectServiceWithQQ:(UIView*)view;
/**
 *  时间nsstring转NSTimeInterval
 *
 *  @param payTime 2015-22-1 23:12:12
 *
 *  @return NSTimeInterval
 */
- (NSTimeInterval) dateConverter:(NSString*)payTime;
/**
 *  json解析
 *
 *  @param jsonString json
 *
 *  @return 字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;




- (NSError*)setNSError:( NSError **)error strError:(NSString *)strError;

@end
