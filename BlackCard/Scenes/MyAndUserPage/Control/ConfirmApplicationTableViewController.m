//
//  ConfirmApplicationTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ConfirmApplicationTableViewController.h"
#import "HomePageModel.h"
#import "PayModel.h"
#import "PayManagerHelper.h"
#import "CustomAlertController.h"
#define kButtonRePayAction 999

@interface ConfirmApplicationTableViewController ()<PayHelperDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *customizeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *trueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UIButton *serviceButton;
@property (weak, nonatomic) IBOutlet UIButton *registerPayButton;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;
@property (strong,nonatomic)NSDictionary *tokenDic;
@property(strong,nonatomic)RegisterModel *model;


@end

@implementation ConfirmApplicationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buttonSetting];
    [self contentFillSetting];
    [[PayManagerHelper shared] setDelegate:self];
}


- (void)buttonSetting {
    
    UIFont *font = [UIFont systemFontOfSize:12];
    
    NSMutableAttributedString *baseStr = [[NSMutableAttributedString alloc]initWithString:@"我已经完全阅读并同意" attributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName:kUIColorWithRGB(0xA6A6A6)}];
    [baseStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"《无限黑卡会籍服务章程》" attributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName:kUIColorWithRGB(0xE3A63F)}]];
    [self.serviceButton setAttributedTitle:baseStr forState:UIControlStateNormal];
    
}


- (void)contentFillSetting{
    
    self.cardTypeLabel.text = [NSString stringWithFormat:@"黑卡会籍：%@",_model.cardModel.blackcardName];
    self.customizeNameLabel.text = [NSString stringWithFormat:@"定制姓名：%@",_model.customName];
    self.trueNameLabel.text = [NSString stringWithFormat:@"收件人：%@",_model.fullName];
    self.phoneLabel.text = [NSString stringWithFormat:@"联系电话：%@",_model.phoneNum];
    self.addLabel.text =  [NSString stringWithFormat:@"收件地址：%@-%@-%@",_model.province,_model.city,_model.addr] ;
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"支付金额：" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : kUIColorWithRGB(0x434343)}];
    
    CGFloat payMoney = _model.cardModel.blackcardPrice +  ([NSString isEmpty:_model.customName] ? 0 : 60.0);
    [string appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%.2f",payMoney] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13],NSForegroundColorAttributeName : kUIColorWithRGB(0xE3A63F)}]];
    
    self.payMoneyLabel.attributedText = string;
    [_registerPayButton setTitle:payMoney > 0? @"确认支付": @"立即注册"   forState:UIControlStateNormal];

}
- (IBAction)registerButtonAction:(UIButton *)sender {
    
    if (_tokenDic == nil) {
        [self registerWithHttp];
    }else {
        
        [self payWithDic:_tokenDic];
    }
    
 
    
    
}


- (void)registerWithHttp {
    
    NSError *error = nil;
    NSDictionary *dic = [OEZJsonModelAdapter jsonDictionaryFromModel:_model error:&error];
    [self showLoader:@"注册中..."];
    WEAKSELF
    
    [[AppAPIHelper shared].getMyAndUserAPI registerWithRegisterModel:dic complete:^(id data) {
        
        [weakSelf registerWithData:data];
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
        if (error.code == 10017) {
            [weakSelf lastPayWihtPush];
        }
        
        
    }];
    
}

- (void)registerWithData:(id)data {
    NSInteger isPay = [data[@"isPay"] integerValue];
    if (isPay == 0) {
        [self hiddenProgress];
        CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:@"注册成功" message:@"" preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:@"确定" otherButtonTitles:nil];
        WEAKSELF
        [alert show:self didClicked:^(UIAlertAction * _Nullable action, NSInteger buttonIndex) {
           [weakSelf.navigationController  dismissViewControllerAnimated:YES completion:nil];
        }];
        
    }else if (isPay == 1){
        [self showLoader:@"注册成功,等待支付"];
        self.tokenDic  = data;
        [self payWithDic:data];
        
    }

    
}


- (void)payWithDic:(NSDictionary *)dic {
    WEAKSELF
    if (_tokenDic ) {
        [self showLoader:@"支付中..."];
    }
    
    [[AppAPIHelper shared].getMyAndUserAPI registerWithPay:dic complete:^(PayInfoModel *model) {
        [weakSelf hiddenProgress];
        [[PayManagerHelper shared].wxPay payWithWXModel:model.wxPayInfo];
        [[BlackLogHelper shared] setPayDic:@{@"event" : @"register_pay",@"amount" : @(model.payTotalPrice),@"payType":@(model.payType),@"tradeNo":model.tradeNo}];
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
        [weakSelf payButtonSetting];
    }];
    
    
}

- (void)payButtonSetting {
    self.registerPayButton.tag =  kButtonRePayAction;
    [self.registerPayButton setTitle:@"重新支付" forState:UIControlStateNormal];
    
}



- (void)payHelperWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data {
    [self LogPayStatus:payStatus withData:data];
    NSString *title = @"";
    NSString *message = @"";
    switch (payStatus) {
        case PayError: {  //支付失败
            title = @"支付失败";
            message = @"请重新支付";

        }
            break;
        case PayOK:{ //支付成功
            title = @"支付成功";
        }
            break;
        case PayCancel:{//支付取消
            title = @"支付已取消";
        }
            break;
        default:{
            title = @"支付出错";
            if ([data isKindOfClass:[NSString class]]) {
                message = data;
            }
        }
            break;

    }
   
    CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    if (payStatus == PayOK) {
        WEAKSELF
        [alert show:self didClicked:^(UIAlertAction *action, NSInteger buttonIndex) {
             [weakSelf.navigationController  dismissViewControllerAnimated:YES completion:nil];
        }];
        
    }else {
        [self payButtonSetting];
        [alert show:self];
    }
  
    
}



- (void)lastPayWihtPush {
    
    WEAKSELF
    [self pushStoryboardViewControllerIdentifier:@"ResetPayTableViewController" block:^(UIViewController *viewController) {
         [viewController  setValue:weakSelf.model.phoneNum forKey:@"phoneNum"];
    }];

    
    
    
}
- (IBAction)showWedAction:(UIButton *)sender {
    
    [self pushWithIdentifier:@"WKWebViewController" complete:^(UIViewController *controller) {
        [controller setValue:kHttpAPIUrl_userAgreement forKey:@"url"];
        [controller setValue:@"《无限黑卡会籍服务章程》" forKey:@"webTitle"];
    }];
    
}

- (void)LogPayStatus:(PayStatus)payStatus withData:(id)data{
    
    NSString *returnCode = payStatus == PayOK ? @"0" : @"2";
    returnCode =  payStatus == PayCancel ?  @"1" : returnCode;
    NSString *memo = [data isKindOfClass:[NSString  class]] ? data : @"";
    [[BlackLogHelper shared] addOtherPayInformationWithPost:@{@"returnCode":returnCode,@"returnMsg":memo}];
}

@end
