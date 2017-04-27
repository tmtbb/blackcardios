//
//  ResetPasswordTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ResetPasswordTableViewController.h"
#import "SendVerifyCodeButton.h"
#import "ValidateHelper.h"
@interface ResetPasswordTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cardCodeField;
@property (weak, nonatomic) IBOutlet SendVerifyCodeButton *verifyCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFied;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgainField;
@property (copy,nonatomic)  NSString *verifyToken;

@end

@implementation ResetPasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self verifycodeButtonSetting];

}

- (void)verifycodeButtonSetting {
    _verifyCodeButton.maxLastSec = 60;
    
}
- (IBAction)getCodeAction:(UIButton *)sender {
    
    NSError *error = nil;
    if (![[ValidateHelper shared] checkNumber:_cardCodeField.text emptyString:@"请输入黑卡卡号" errorString:@"请输入正确的黑卡卡号" error:&error]) {
        [self showError:error];
    }else {
        
        [_verifyCodeButton startWithCount];
        WEAKSELF
        NSString *cardNum = _cardCodeField.text;
        [[AppAPIHelper shared].getMyAndUserAPI sendVerifyCode:cardNum complete:^(id data) {
            weakSelf.verifyToken = data[@"codeToken"];
            [weakSelf showTips:@"验证码已发送"];
            weakSelf.cardCodeField.enabled = NO;
            weakSelf.cardCodeField.text = cardNum;
        } error:^(NSError *error) {
            [weakSelf showError:error];
        }];
        
    }
    
    
    
   
}
- (IBAction)resetPasswordAction:(UIButton *)sender {
    
    if (![self checkMessage]) {
        return;
    }
    
    [self showLoader:@"提交中..."];
    WEAKSELF
    [[AppAPIHelper shared].getMyAndUserAPI repassword:_passwordAgainField.text cardNum:_cardCodeField.text verifyCode:_verifyCodeField.text andCodeToken:_verifyToken complete:^(id data) {
        [weakSelf showTips:@"重置成功,请重新登录"];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
    
    
    
}

- (BOOL)checkMessage {
    NSError *error = nil;
    
    if (![[ValidateHelper shared] checkNumber:_cardCodeField.text emptyString:@"请输入黑卡卡号" errorString:@"请输入正确的黑卡卡号" error:&error]) {
        [self showError:error];
    }else if (!_verifyToken) {
        [self showTips:@"请先获取验证码"];
    }else if (![[ValidateHelper shared] checkNumber:_verifyCodeField.text emptyString:@"请输入验证码" errorString:@"请输入正确的验证码" error:&error]){
        [self showError:error];
    }else if (![[ValidateHelper shared] checkUserPass:_passwordFied.text error:&error]) {
        [self showError:error];
    }else if (![_passwordAgainField.text isEqualToString:_passwordFied.text]){
        
        [self showTips:@"两次输入的密码不相同"];
    }else {
        
        return YES;
    }
    return NO;
}

- (IBAction)backButtonAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    switch (textField.tag) {
        case 100:
        case 103:
            return [textField resignFirstResponder];
        case 101:
        case 102: {
            UITextField *field = [self.tableView viewWithTag:textField.tag + 1];
          return   [field becomeFirstResponder];
            
        }
       
    }
    
    return YES;
}

@end
