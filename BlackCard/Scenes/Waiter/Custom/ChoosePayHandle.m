//
//  ChoosePayHandle.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ChoosePayHandle.h"
#import "ChoosePayTypeView.h"
#import "PayManagerHelper.h"
#import "WaiterModel.h"
@interface ChoosePayHandle ()<OEZViewActionProtocol,PayPasswordTextFieldDelegate,PayHelperDelegate>
@property(strong,nonatomic)ChoosePayTypeView *payTypeView;
@property(weak,nonatomic)UIViewController *controller;
@property(strong,nonatomic)WaiterServiceMDetailModel *model;
@end
@implementation ChoosePayHandle

- (instancetype)init {
    self = [super init];
    if (self) {
        [[PayManagerHelper shared] setDelegate:self];
    }
    return self;
}

- (instancetype)initWithController:(UIViewController *)controller andModel:(id)model{
    
    self = [self init];
    if (self) {
        
        _controller = controller;
        _model = model;
        
    }
    return self;
}

- (void)upDate:(id)data {
    
    _model = data;
}
- (ChoosePayTypeView *)payTypeView {
    if (_payTypeView == nil) {
        _payTypeView = [ChoosePayTypeView loadFromNib];
        _payTypeView.frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
        _payTypeView.delegate = self;
        _payTypeView.payPasswordField.changedDelegate = self;
    }
    
    return _payTypeView;
}

- (void)handleShow {
    if (self.payTypeView.superview == nil) {
         [_controller.view.window addSubview:self.payTypeView];
        
        [self showWithDefaultPay];
        
    }
}

- (void)showWithDefaultPay {
    WEAKSELF
    [[AppAPIHelper shared].getMyAndUserAPI getUserBlanceComplete:^(id data) {
        double myBalance = [data[@"balance"] doubleValue];
        NSString *money = [NSString stringWithFormat:@"%.2f",myBalance];
        
        [weakSelf.payTypeView update:money];
        
        [weakSelf.payTypeView purseButtonCanUse:myBalance > weakSelf.model.serviceAmount];
    } error:nil];
    
}



- (void)view:(UIView *)view didAction:(NSInteger)action data:(id)data {
    
    switch (action) {
        case ChoosePayTypeViewStatus_Close:{
            [self.payTypeView removeFromSuperview];
        }
            break;
        case ChoosePayTypeViewStatus_ForgetPassword:{
            [self.payTypeView removeFromSuperview];
            [_controller pushStoryboardViewControllerIdentifier:@"ModifyPayPasswordTableViewController" block:nil];
            
            
        }
            break;
        case ChoosePayTypeViewStatus_PursePay:{
            [self.payTypeView showKeyboard];

        }
            break;
        case ChoosePayTypeViewStatus_AliPay:
        case ChoosePayTypeViewStatus_WxPay: {
            
            NSInteger payType =  action == ChoosePayTypeViewStatus_AliPay ? PayTypeALiPay : PayTypeWeiXinPay;
            WEAKSELF
            [_controller showLoader:@"支付中..."];
            [[AppAPIHelper shared].getWaiterServiceAPI getPayWithServiceNo:_model.serviceNo payType:payType payPassword:nil Complete:^(PayInfoModel *data) {
                [weakSelf.controller hiddenProgress];
                switch (payType) {
                    case PayTypeALiPay:
                        [[PayManagerHelper shared].aliPay payWithAliModel:data.aliPayInfo];
                        break;
                    case PayTypeWeiXinPay:
                        [[PayManagerHelper shared].wxPay payWithWXModel:data.wxPayInfo];
                        break;
                }
                
                [[BlackLogHelper shared] setPayDic: @{@"event" : @"butlerservice_pay",
                                    @"amount" : @(weakSelf.model.serviceAmount),
                                    @"payType":@(1),
                                    @"tradeNo":data.tradeNo}];
                
                
            } withError:^(NSError *error) {
                [weakSelf.controller showError:error];
                
            }];
            
            
            
        }
            break;
    }
    
    
    
    
    
}

- (void)textFieldChanged:(UITextField *)textField {
    if (textField.text.length == 6) {
        
        DefaultModel *model = [[DefaultModel alloc]init];
        model.money = _model.serviceAmount;
        model.serviceNo = _model.serviceNo;
        model.payPassword = textField.text;
        
        [self.payTypeView hiddenKeyBoard];
        [self.payTypeView removeFromSuperview];
        
        [_controller showLoader:@"支付中..."];
        [[PayManagerHelper shared].defaultPay payWithDefaultModel:model];
    }
    
}

- (void)payHelperWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data {
    [_controller hiddenProgress];
    [self.payTypeView removeFromSuperview];
    
    switch (payStatus) {
        case PayError: {  //支付失败
            [self alertError:type withData:data];
        }
            break;
        case PayOK:{ //支付成功
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"支付成功" message:@"" delegate:_controller cancelButtonTitle:@"确定" otherButtonTitles: nil];
            WEAKSELF
            [alert showWithCompleteBlock:^(NSInteger buttonIndex) {
                
             [weakSelf.controller.navigationController  popViewControllerAnimated:YES];
            }];
        }
            break;
        case PayCancel:{//支付取消
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"支付已取消" message:@"" delegate:_controller cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
            break;
        default:{
            if ([data isKindOfClass:[NSString class]]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"支付出错" message:data delegate:_controller cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
        }
            break;
    }
    [self myPayWithType:type withPayStatus:payStatus withData:data];
    
    if (type != PayTypeDefaultPay) {
        [self LogPayStatus:payStatus withData:data];
    }
    
    
    
}

- (void)alertError:(PayType)type withData:(id)data {
    NSString *errorStr = @"请重新支付";
    if (type == PayTypeDefaultPay) {
        NSError *error = data;
        if (error.code == 10020) {
            [_controller showError:error];
            return;
        }
        errorStr = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"支付失败" message:errorStr delegate:_controller cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    
}


- (void)myPayWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data{
    
    if ([self.delegate respondsToSelector:@selector(choosePayHandleWithType:withPayStatus:withData:)]) {
        [self.delegate choosePayHandleWithType:type withPayStatus:payStatus withData:data];
    }
}


- (void)LogPayStatus:(PayStatus)payStatus withData:(id)data{
    
    
    NSString *returnCode = payStatus == PayOK ? @"0" : @"2";
    returnCode =  payStatus == PayCancel ?  @"1" : returnCode;
    NSString *memo = [data isKindOfClass:[NSString  class]] ? data : @"";
    
    [[BlackLogHelper shared] addOtherPayInformationWithPost:@{@"returnCode":returnCode,@"returnMsg":memo}];

   
}



@end
