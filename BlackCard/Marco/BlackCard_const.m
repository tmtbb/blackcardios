#import "BlackCard_const.h"
#pragma mark -  UIColor Const
//const UIColor * KUIColorExample = [UIColor redColor]
#pragma mark -  NSString Const
//const NSString * KStringExample = @"KStringExample"
#pragma mark -  CGFloat Const
//const CGFloat  KCGFloatExample = 320.0f
#pragma mark -  UIColor Const
//const UIColor * KUIColorExample = [UIColor redColor]
#pragma mark -  NSString Const
//const NSString * KStringExample = @"KStringExample"
#pragma mark -  CGFloat Const
//const CGFloat  KCGFloatExample = 320.0f


NSString *const kAppNSErrorDomain                 = @"com.youdian.blackcard.ios";

NSString *const kAppAdvertisingIdentifier         = @"com.youdian.blackcard.ios.advertisingIdentifier";




NSInteger const kAppNSErrorLoginCode      =  1000L;
NSInteger const kAppNSErrorCheckDataCode  = kAppNSErrorLoginCode+ 1;

NSInteger const kAppNSErrorTokenCode      = kAppNSErrorCheckDataCode +1;
NSInteger const kAppNSErrorJsonCode       = kAppNSErrorTokenCode+ 1;

NSInteger const kAppRechargeMoneyType     = 0;// 0 可充值非整数，1整数

const char * signKey(){
    static char signKey[1000] = {'\0',};
    if( signKey[0] == '\0' )
    {
        char *pBuffer = signKey;
        NSInteger num = 4;
         for (NSInteger i = 0; i < num * num; ++i) {
            memcpy(pBuffer, "2180", num);
            memcpy(pBuffer += num, "BC4B", num);
            memcpy(pBuffer += num, "3321", num);
            memcpy(pBuffer += num, "56A8", num);
            memcpy(pBuffer += num, "6044", num);
            memcpy(pBuffer += num, "E1B8", num);
            memcpy(pBuffer += num, "C010", num);
            memcpy(pBuffer += num, "9E28", num);
            pBuffer += num;
        }
        signKey[num*8] = '\0';
    }
    return (const char * )signKey;
}
