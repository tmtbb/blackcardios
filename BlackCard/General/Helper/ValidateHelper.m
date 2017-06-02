//
//  ValidateHelper.m
//  douniwan
//
//  Created by yaobanglin on 15/4/21.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import "ValidateHelper.h"
#import "NSString+Category.h"


@implementation ValidateHelper
HELPER_SHARED(ValidateHelper)

- (BOOL)checkAccount:(NSString *)account error:(NSError **)error {
    BOOL isValidate = [self checkStringNotEmpty:account error:error strError:@"请输入支付宝账号"];
    return isValidate;
}
- (BOOL)checkCashName:(NSString *)cashName error:(NSError **)error {
    BOOL isValidate = [self checkStringNotEmpty:cashName error:error strError:@"请输入真实姓名"];
    return isValidate;
}

- (BOOL) checkCashMoney:(NSString *)cashMoney minMoney:(NSString *)minMoney maxMoney:(NSString*)maxMoney realMoney:(NSString*)realMoney error:(NSError **)error {
    BOOL isValidate = [self checkStringNotEmpty:cashMoney error:error strError:@"请输入提现金额"];
    if (isValidate) {
        if ([cashMoney integerValue] < [minMoney integerValue]) {
            [self setNSError:error strError:[NSString stringWithFormat:@"提取金额不能少于%@",minMoney]];
            isValidate = NO;
        } else if ([cashMoney integerValue] > [realMoney integerValue]) {
            [self setNSError:error strError:[NSString stringWithFormat:@"您的最大提现金额为%@",realMoney]];
            isValidate = NO;
        } else if ([cashMoney integerValue] % 10 != 0 ) {
            [self setNSError:error strError:@"提取金额必须为10的倍数"];
            isValidate = NO;
        } else if ((![maxMoney isEqualToString:@"-1"]) && [cashMoney integerValue] > [maxMoney integerValue]) {
            [self setNSError:error strError:[NSString stringWithFormat:@"单次最高提现%@",maxMoney]];
            isValidate = NO;
        }
    }
    return isValidate;
}

- (BOOL)checkStringLength:(NSString *)string error:(NSError **)error strError:(NSString *)strError
                 emptyStr:(NSString *)strEmpty
{
    BOOL isValidate = [self checkStringNotEmpty:string error:error strError:strEmpty];
    if (isValidate) {
        if (string.length > 40 ) {
            [self setNSError:error strError:strError];
            return NO;
        }
        
    }
    else
        return NO;
    return YES;
}

- (BOOL)checkStringWithRegular:(NSString *)regular checkString:(NSString *)string error:(NSError **)error strError:(NSString *)strError emptyStr:(NSString *)strEmpty{
    
         BOOL isValidate = [self checkStringNotEmpty:string error:error strError:strEmpty];
        if (isValidate ) {
            if (![self RegularExpression:regular andString:string]) {
                [self setNSError:error strError:strError];
                return NO;
            }
        }
    
    
    
    
    return isValidate;
    
}

- (BOOL)checkQQAccount:(NSString *)string error:(NSError *__autoreleasing *)error {
    BOOL isValidate = [self checkStringNotEmpty:string error:error strError:@"账号不能为空"];
    if (isValidate) {
        BOOL isNmuber = [self isNumber:string];
        if (isNmuber) {
            if (string.length < 5 || string.length > 12) {
              [self setNSError:error strError:@"QQ账号长度不符"];
                return NO;
            }
        }
        else {
            [self setNSError:error strError:@"QQ账号格式不符"];
            return NO;
        }
    }
    else
    return NO;
    
    return YES;
}

/**
*  检测字符串为非空
*
*  @param string   检测字符串
*  @param error    error输出
*  @param strError 错误描述
*
*  @return 不为空返回YES 为空返回NO
*/
- (BOOL)checkStringNotEmpty:(NSString *)string error:(NSError **)error strError:(NSString *)strError {
    BOOL isEmpty = [NSString isEmpty:string];
    if (isEmpty)
        [self setNSError:error strError:strError];
    return !isEmpty;
}


- (NSError*)setNSError:( NSError **)error strError:(NSString *)strError {
    if (error != NULL) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:strError forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:kAppNSErrorDomain code:kAppNSErrorCheckDataCode userInfo:userInfo];
        return (*error);
    }
    return nil;
}

- (BOOL)checkUserPass:(NSString *)userPass error:(NSError **)error strError:(NSString *)strError {
    BOOL isValidate = [self checkStringNotEmpty:userPass error:error strError:strError];
    if (isValidate) {
        
        NSString *trimString = [userPass trim];
        if (![trimString isEqualToString:userPass]) {
            [self setNSError:error strError:@"密码中不可使用空格"];
            return NO;
        }
        NSString *pwdrepeat = @"^(?![\\d]+$)(?![a-zA-Z]+$)(?![^\\da-zA-Z]+$).{6,18}$";
        if (![self RegularExpression:pwdrepeat andString:userPass]) {
            [self setNSError:error strError:@"密码应为6-18位数字/字母/符号的组合"];
            isValidate = NO;
        }
        
    }
    return isValidate;
}

- (BOOL)checkOldUserPwd:(NSString *)userPwd error:(NSError **)error strError:(NSString *)strError {
    BOOL isValidate = [self checkStringNotEmpty:userPwd error:error strError:strError];
    if (isValidate) {
        NSString *pwdrepeat = @"^.{6,}$";
        if (![self RegularExpression:pwdrepeat andString:userPwd]) {
            [self setNSError:error strError:@"请输入至少6位的密码"];
            isValidate = NO;
        }
        
    }
    return isValidate;
}


- (BOOL)RegularExpression:(NSString *)Regular andString:(NSString *)string {
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regular];
    return  [pred evaluateWithObject:string];
    
}


//- (BOOL)checkUserPass:(NSString *)userPass error:(NSError *__autoreleasing *)error {
//
//    return [self checkUserPass:userPass error:error strError:@"请输入密码"];
//}

- (BOOL)checkUserPass:(NSString *)userPass error:(NSError *__autoreleasing *)error {
    return [self checkOldUserPwd:userPass error:error strError:@"请输入密码"];
}

- (BOOL)checkUserPass:(NSString *)userPass emptyString:(NSString *)empty  error:(NSError *__autoreleasing *)error {
    return [self checkOldUserPwd:userPass error:error strError:empty];
}


- (BOOL)isPhoneNumber:(NSString *)phoneNumber {
    //^((13[0-9])|(17[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$
    NSString *regex = @"^1\\d{10}$";
//    NSString *regex = @"^[1-9]\\d{4,10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phoneNumber];
}

- (BOOL)checkNumber:(NSString *)number emptyString:(NSString *)empty errorString:(NSString *)errorStr error:(NSError *__autoreleasing *)error {
    
    return [self checkStringWithRegular:@"^[0-9]*$" checkString:number error:error strError:errorStr emptyStr:empty];
    
}


- (BOOL)checkDecimalNumber:(NSString *)number emptyString:(NSString *)empty errorString:(NSString *)errorStr error:(NSError *__autoreleasing *)error  {
    
    return  [self checkStringWithRegular:@"^[0-9]+(\\.[0-9]{1,2})?$" checkString:number error:error strError:errorStr emptyStr:empty];
    
    
    
}


- (BOOL)checkMoneyIsDecimal:(BOOL)isDecimal money:(NSString *)money error:(NSError *__autoreleasing *)error {
    
    if (isDecimal) {
     return    [self checkDecimalNumber:money emptyString:@"请输入金额" errorString:@"请输入正确的金额" error:error];
    }else {
        
     return    [self checkStringWithRegular:@"^-?[1-9]\\d*$" checkString:money error:error strError:@"请输入正确的金额" emptyStr:@"请输入金额"];
    }
    
}


- (BOOL)checkNumberAndLetter:(NSString *)number emptyString:(NSString *)empty errorString:(NSString *)errorStr error:(NSError *__autoreleasing *)error {
    
    return [self checkStringWithRegular:@"^[A-Za-z0-9]+$" checkString:number error:error strError:errorStr emptyStr:empty];
    
}

- (BOOL)checkLetter:(NSString *)number emptyString:(NSString *)empty errorString:(NSString *)errorStr error:(NSError *__autoreleasing *)error {
    
    return [self checkStringWithRegular:@"^[A-Za-z]+$" checkString:number error:error strError:errorStr emptyStr:empty];
    
}

- (BOOL)checkUserPhone:(NSString *)userPhone error:(NSError *__autoreleasing *)error {
    BOOL isValidate = [self checkStringNotEmpty:userPhone error:error strError:@"请输入手机号码"];
    if (isValidate) {
        if (![self isPhoneNumber:userPhone]) {
            [self setNSError:error strError:@"请输入正确的手机号码"];
            return NO;
        }
    }
    return isValidate;
}



- (BOOL)isEmail:(NSString *)email{
    NSString *regex = @"^([a-z0-9A-Z]+[-|.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?.)+[a-zA-Z]{2,}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:email];
    
}
- (BOOL)checkEmail:(NSString *)email error:(NSError *__autoreleasing *)error {
     BOOL isValidate = [self checkStringNotEmpty:email error:error strError:@"请输入电子邮箱"];
    if (isValidate) {
        if (![self isEmail:email]) {
            [self setNSError:error strError:@"请输入正确的电子邮箱"];
            return NO;
        }
    }
    return isValidate;
}

- (BOOL)isPersonIdentityNumebr:(NSString *)identityNumber{
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:identityNumber];
    
}

- (BOOL)checkPersonIdentityNumebr:(NSString *)identityNumber error:(NSError *__autoreleasing *)error {
    
    BOOL isValidate = [self checkStringNotEmpty:identityNumber error:error strError:@"请输入身份证号"];
    if (isValidate) {
        if (![self isPersonIdentityNumebr:identityNumber]) {
            [self setNSError:error strError:@"请输入正确的身份证号"];
            return NO;
        }
    }
    return isValidate;
    
}

- (BOOL)checkUserPhoneOrQQNumber:(NSString *)userPhone error:(NSError *__autoreleasing *)error {
    BOOL isValidate = [self checkStringNotEmpty:userPhone error:error strError:@"请输入手机/QQ号码"];
    if (isValidate) {
        if (![self isPhoneNumber:userPhone]) {
            [self setNSError:error strError:@"请输入正确的手机/QQ号码"];
            return NO;
        }
    }
    return isValidate;
}


- (BOOL)checkVerifyCode:(NSString *)verifyCode error:(NSError *__autoreleasing *)error {
    BOOL isValidate = [self checkStringNotEmpty:verifyCode error:error strError:@"请输入验证码"];
    if (isValidate) {

    }
    return isValidate;
}

- (BOOL)checkUserName:(NSString *)userName error:(NSError **)error {
    BOOL isValidate = [self checkStringNotEmpty:userName error:error strError:@"请输入账号"];
    if (isValidate) {

    }
    return isValidate;
}

- (BOOL)checkFeedback:(NSString *)feedback error:(NSError **)error {
    BOOL isValidate = [self checkStringNotEmpty:feedback error:error strError:@"反馈内容不能为空"];
    if (isValidate) {

    }
    return isValidate;
}

- (BOOL)checkUserTowPass:(NSString *)userPass userPass1:(NSString *)userPass1 error:(NSError **)error {
    if ([[userPass stringByTrim] isEqualToString:[userPass1 stringByTrim]])
        return YES;
    else
        [self setNSError:error strError:@"两次输入密码不同"];
    return NO;
}

-(BOOL) isNumber:(NSString *)number
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


-(BOOL) isCharEmoji:(const unichar) code
{
    static unichar emojiList[] = {0xa9,0xae,0x303d,0x3030,0x2b55,0x2b1c,0x2b1b,0x2b50,0x231a,0x203c,0x2049};
    for(NSInteger i = 0; i < sizeof(emojiList)/ sizeof(unichar);++i)
    {
        if(code == emojiList[i])
            return YES;
    }
    return NO;
}

-(BOOL) isEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             }
             else if([self isCharEmoji:hs])
             {
                 isEomji = YES;
             }
             else if ( substring.length > 1)
             {
                 const unichar ls = [substring characterAtIndex:1];
                 if (ls == 0x20e3) {
                     isEomji = YES;
                 }
                 else if( ls == 0xfe0f)
                 {
                     isEomji = YES;
                 }
             }
         }
     }];
    return isEomji;
    
}

-(NSString*)textValueChange:(UITextField*)testFiled withWordCount:(int)wordCount
{
    NSString * returnS = @"";
    NSString * markName = testFiled.text;
    const char *char_content = [markName UTF8String];
    NSInteger charLen = 0;
    if (strlen(char_content) > wordCount)
    {
        //判断要截取到哪个string的下标
        for (int i =  0; i < markName.length; i ++)
        {
            NSString *s = [markName substringWithRange:NSMakeRange(i, 1)];
            const char *c = [s UTF8String];
            charLen = charLen + (NSInteger)strlen(c);
            if (charLen > wordCount)
            {
                testFiled.text = [markName substringWithRange:NSMakeRange(0, i)];
                returnS = testFiled.text;
                break;
            }
            if (charLen == wordCount)
            {
                testFiled.text = [markName substringWithRange:NSMakeRange(0, i + 1)];
                returnS = testFiled.text;
                break;
            }
        }
    }
    else
    {
        returnS = markName;
    }
    return returnS;
}
//add by caow
-(NSString*)textValueChange:(UITextField*)testFiled withOrirRemarkName:(NSString*)orirRemarkName withWordCount:(int)wordCount
{
    //加入判断系统表情
    NSString * remarkName = testFiled.text;
    BOOL isEmoji = [self isEmoji:remarkName];
    const char *char_content = [remarkName UTF8String];
    NSInteger charLen = 0;
    if (strlen(char_content) > wordCount)
    {
        //strncpy( char_remarName, char_content, 21 );
        // [NSString stringWithUTF8String:char_remarName];
        //testFiled.text = [remarkName substringWithRange:NSMakeRange(0, 6)];
        //判断要截取到哪个string的下标
        for (int i =  0; i < (isEmoji ? 1 : remarkName.length); i ++)
        {
            NSString *s = [remarkName substringWithRange:NSMakeRange(i, 1)];
            if (isEmoji)
            {
                s = remarkName;
            }
            const char *c = [s UTF8String];
            charLen = charLen + strlen(c);
            if (isEmoji)
            {
                if (charLen > wordCount)
                {
                    testFiled.text = orirRemarkName;
                    break;
                }
                else
                {
                    testFiled.text = remarkName;
                    orirRemarkName = remarkName;
                    break;
                }
            }
            if (charLen > wordCount)
            {
                testFiled.text = [remarkName substringWithRange:NSMakeRange(0, i)];
                orirRemarkName = testFiled.text;
                break;
            }
            if (charLen == wordCount)
            {
                testFiled.text = [remarkName substringWithRange:NSMakeRange(0, i + 1)];
                orirRemarkName = testFiled.text;
                break;
            }
        }
    }
    else
    {
        orirRemarkName = remarkName;
    }
    return orirRemarkName;
}

- (CGFloat)getTextViewContentH:(UITextView *)textView
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        return ceilf([textView sizeThatFits:textView.frame.size].height);
    }
    
    else
    {
        return textView.contentSize.height;
    }
}


-(void)connectServiceWithQQ:(UIView*)view
{
//    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
//        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
//        NSString *QQurl = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",kServicesQQ];
//        NSURL *url = [NSURL URLWithString:QQurl];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [webView loadRequest:request];
//        [view addSubview:webView];
//    }
//    else
//    {
//        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"联系客服，请先安装QQ客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alter show];
//    }
}

- (NSTimeInterval) dateConverter:(NSString*)payTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [[NSDate alloc] init];
    // voila!
    date = [dateFormatter dateFromString:payTime];
    //    NSLog(@"dateFromString = %@", date);
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return timeInterval;
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



- (NSString *)regularSubStrWithReg:(NSString *)reg useString:(NSString *)useStr{
    
    NSString *string = nil;
    NSArray<NSTextCheckingResult*> *results = [self regularWithString:reg andDataString:useStr];
    if( results.count > 0 ) {
        NSTextCheckingResult *result = results[0];
        string = [useStr substringWithRange:[result rangeAtIndex:1]];
    }
    return  string;
}

- ( NSArray<NSTextCheckingResult*> *)regularWithString:(NSString *)regex andDataString:(NSString *)dataStr{
    NSRegularExpression *regular =  [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult*> *results = [regular matchesInString:dataStr options:0 range:NSMakeRange(0, dataStr.length)];
    return results;
}

@end
