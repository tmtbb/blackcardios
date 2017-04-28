#ifndef BlackCard_CONST_H
#define BlackCard_CONST_H
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#pragma mark -  UIColor Const
//const UIColor * KUIColorExample
#pragma mark -  NSString Const

UIKIT_EXTERN NSString *const kAppNSErrorDomain;
UIKIT_EXTERN NSString *const kAppDevice_key;
UIKIT_EXTERN NSString *const kAppDevice_Normal_key;
UIKIT_EXTERN NSString *const kAppDevice_keyid;
UIKIT_EXTERN NSString *const kAppAdvertisingIdentifier;
UIKIT_EXTERN NSString *const kAppDevice_Normal_keyid;

//const NSString * KStringExample
#pragma mark -  CGFloat Const
//const CGFloat  KCGFloatExample
UIKIT_EXTERN NSInteger const kAppNSErrorLoginCode;
UIKIT_EXTERN NSInteger const kAppNSErrorCheckDataCode;
UIKIT_EXTERN NSInteger const kAppNSErrorTokenCode;
UIKIT_EXTERN NSInteger const kAppNSErrorJsonCode;


#define kConstMaxPhoneLength 11
#define kConstMaxVerifyCodeLength 6



#pragma  mark - 统一密钥
const char * signKey();





//支付状态
typedef NS_ENUM(NSInteger, PayStatus){
    PayError = 0,//支付失败
    PayOK = 1,//支付成功
    PayCancel = 2,//支付取消
    PayHandle = 3 //处理中
};

typedef NS_ENUM(NSInteger, PayType) {
    PayTypeDefaultPay,//默认 余额支付
    PayTypeWeiXinPay,//微信支付
    PayTypeALiPay,//支付宝支付
    
};
#endif
