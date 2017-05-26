//
//  SetPayPasswordTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "SetPayPasswordTableViewController.h"
#import "PayPasswordTextField.h"
#import "MyAndUserModel.h"
@interface SetPayPasswordTableViewController ()<PayPasswordTextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet PayPasswordTextField *passwordField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payPasswordWidth;
@property (weak, nonatomic) IBOutlet UIButton *overButton;

@property(copy,nonatomic)NSString *password;
@property(copy,nonatomic)NSString *passwordAgain;


@property(strong,nonatomic)CheckPayPasswordModel *model ;


@end

@implementation SetPayPasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFieldWidth];
    self.passwordField.changedDelegate = self;
    [self.passwordField becomeFirstResponder];
}

- (void)textFieldChanged:(UITextField *)textField {
    
    if (textField.text.length >= 6) {
        NSString *pw = [textField.text substringToIndex:6];
        if (_password) {
            _passwordAgain = pw;
            [textField resignFirstResponder];
            self.overButton.hidden = NO;
        }else {
            [textField resignFirstResponder];
            [self performSelector:@selector(againPasswordSetting:) withObject:pw afterDelay:0.5];
        }
        
        
    }
    
    
}

-(void)againPasswordSetting:(NSString *)pw {
    _password = pw;
    self.passwordField.text = nil;
    self.titleNameLabel.text = @"再次输入支付密码";
    [self.passwordField becomeFirstResponder];
}




- (void)setFieldWidth {
    _payPasswordWidth.constant = _payPasswordWidth.constant > kMainScreenWidth ? kMainScreenWidth - 40 : _payPasswordWidth.constant;
    
}
- (IBAction)buttonAction:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    if ([_password isEqualToString:_passwordAgain]) {
        
        WEAKSELF
        [self showLoader:@"设置中..."];
        [[AppAPIHelper shared].getMyAndUserAPI changePayPassword:_password phone:_model.phoneNum codeToken:_model.codeToken phoneCode:_model.phoneCode complete:^(id data) {
            [weakSelf showTips:@"设置成功"];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        } error:^(NSError *error) {
            [weakSelf showError:error];
        }];
        
        
    }else {
        [self showTips:@"两次输入的密码不一致"];
        _password = nil;
        self.passwordField.text = nil;
        self.titleNameLabel.text = @"请输入支付密码";
        self.overButton.hidden = YES;
        [self.passwordField becomeFirstResponder];
        
    }
    sender.userInteractionEnabled = YES;
}
- (IBAction)leftBarButtonAction:(id)sender {
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否退出设置支付密码" delegate:sender cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        WEAKSELF
     [alert showWithCompleteBlock:^(NSInteger buttonIndex) {
         if (alert.cancelButtonIndex !=  buttonIndex) {
              [weakSelf.passwordField resignFirstResponder];
             [weakSelf performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
         }
     }];
    
    
}

- (void)popViewController{
   __block BOOL isFind = NO;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isMemberOfClass:NSClassFromString(@"SetPasswordTableViewController")]) {
            [self.navigationController  popToViewController:obj animated:YES];
            isFind = YES;
            *stop = YES;
        }
    }];
    if (!isFind) {
      [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

@end
