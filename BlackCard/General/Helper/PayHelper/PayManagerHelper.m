//
//  PayManagerHelper.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "PayManagerHelper.h"


@interface PayManagerHelper ()<PayHelperDelegate>

@property(strong,nonatomic)ALiPay *alipay;
@property(strong,nonatomic)WXPay *wxpay;
@property(strong,nonatomic)DefaultPay *defaultPay;
@property(weak,nonatomic)id<PayHelperDelegate> delegate;
@property(nonatomic)BOOL isLazyDelegate;

@end
@implementation PayManagerHelper
HELPER_SHARED(PayManagerHelper)


- (void)setDelegate:(id)delegate {
    _isLazyDelegate = NO;
    _delegate = delegate;
    _wxpay = nil;
    _alipay = nil;
}
- (void)setLazyShowDelegate:(id<PayHelperDelegate>)delegate {
    _isLazyDelegate = YES;
    _delegate = delegate;
    _wxpay = nil;
    _alipay = nil;
    
}

- (ALiPay *)aliPay{
    if (_alipay == nil) {
        _alipay =  [[ALiPay alloc]init];
        _alipay.delegate = self;
        
    }
    return _alipay;
}

-(WXPay *)wxPay {
    
    if (_wxpay == nil) {
        _wxpay = [[WXPay alloc]init];
        _wxpay.delegate = self;
    }
    return _wxpay;
}

- (DefaultPay *)defaultPay {
    if (_defaultPay == nil) {
        _defaultPay = [[DefaultPay alloc]init];
        _defaultPay.delegate = self;
        
    }
    return _defaultPay;
}



- (void)payHelperWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data {
    
    
    if ( [self.delegate respondsToSelector:@selector(payHelperWithType:withPayStatus:withData:)]) {
        [self.delegate payHelperWithType:type withPayStatus:payStatus withData:data];
    }
    
    if (_isLazyDelegate) {
        
        [self lazyShowWithType:type payStatus:payStatus withData:data];
        
        
    }
    
    
}


- (void)lazyShowWithType:(PayType)type payStatus:(PayStatus)payStatus withData:(id)data {
    
    NSString *title,*message;
    switch (payStatus) {
        case PayError: {  //支付失败
            title = @"支付失败";
            message = data ? data : @"请重新支付";
     
        }
            break;
        case PayOK:{ //支付成功
            title = @"支付成功";
            message = nil;
            
        }
            break;
        case PayCancel:{//支付取消
            title = @"支付已取消";
            message = nil;


        }
            break;
        default:{ //处理中
            if ([data isKindOfClass:[NSString class]]) {
                message = data;
            }
            title = @"支付出错";
            
            

        }
            break;
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self.delegate cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
}




@end
