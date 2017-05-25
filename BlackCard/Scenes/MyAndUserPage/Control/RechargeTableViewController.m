//
//  RechargeTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "RechargeTableViewController.h"

#import "PayManagerHelper.h"
#import "ValidateHelper.h"
typedef NS_ENUM(NSInteger,RechargeTableViewControllerPayType){
    kRechargeTable_AliPay   =  2,
    kRechargeTable_WxPay
    
};

@interface RechargeTableViewController ()<PayHelperDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *wxPayCell;
@property (weak, nonatomic) IBOutlet UIImageView *alipayImage;
@property (weak, nonatomic) IBOutlet UIImageView *wxPayImage;
@property(nonatomic)PayType payType;
@property (weak, nonatomic) IBOutlet UITextField *moneyField;
@property(copy,nonatomic)NSString *payMoney;

@end

@implementation RechargeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layerSetting];
    _payType = PayTypeALiPay;
    _moneyField.keyboardType = kAppRechargeMoneyType == 0 ? UIKeyboardTypeDecimalPad : UIKeyboardTypeNumberPad;
    
    [[PayManagerHelper shared] setLazyShowDelegate:self];
}


- (void)layerSetting {
    CALayer *layer = [[CALayer alloc]init];
    layer.backgroundColor = kUIColorWithRGB(0xd7d7d7).CGColor;
    layer.frame = CGRectMake(0, 0, kMainScreenWidth, 0.5);;
    [_wxPayCell.layer addSublayer:layer];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case kRechargeTable_AliPay:{
            self.alipayImage.image = [UIImage imageNamed:@"paySelectIcon"];
            self.wxPayImage.image = [UIImage imageNamed:@"payDefaultIcon"];
            _payType = PayTypeALiPay;
        }
            
            break;
        case kRechargeTable_WxPay:{
            self.alipayImage.image = [UIImage imageNamed:@"payDefaultIcon"];
            self.wxPayImage.image = [UIImage imageNamed:@"paySelectIcon"];
            _payType = PayTypeWeiXinPay;
        }
            break;
        default:
            break;
    }
    
    
}


- (IBAction)payButtonAction:(UIButton *)sender {
    NSError *error;
    
    
    
    NSString *money = _moneyField.text.trim;
    if (money.floatValue == 0) {
        [self showTips:@"请输入要充值的金额"];
        return;
    }
    
    sender.userInteractionEnabled = NO;
    if ([[ValidateHelper shared] checkMoneyIsDecimal:!kAppRechargeMoneyType money:money error:&error]) {
        WEAKSELF
        [self hideKeyboard];
        sender.userInteractionEnabled = YES;
        [weakSelf showLoader:@"支付中..."];
        _payMoney = _moneyField.text;
         [[AppAPIHelper shared].getMyAndUserAPI rechargeMoneyWithPayType:_payType andMoney:_payMoney complete:^(PayInfoModel *data) {
             [weakSelf hiddenProgress];
             switch (weakSelf.payType) {
                 case PayTypeALiPay:
                     [[PayManagerHelper shared].aliPay payWithAliModel:data.aliPayInfo];
                     break;
                case PayTypeWeiXinPay:
                     [[PayManagerHelper shared].wxPay payWithWXModel:data.wxPayInfo];
                     break;
                 default:
                     break;
             }
    
             
             
         } error:^(NSError *error) {
             [weakSelf showError:error];
         }];
        
        
    }else {
        if (error != nil) {
            [self showError:error];
        }
        sender.userInteractionEnabled = YES;
        
    }
    
    
   
    
    
   
    
    
}


- (void)payHelperWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data {
    if (payStatus == PayOK) {
        
        [[CurrentUserActionHelper shared] sender:self didChangeMoney:_payMoney.floatValue];
    }
    
    
}



@end
