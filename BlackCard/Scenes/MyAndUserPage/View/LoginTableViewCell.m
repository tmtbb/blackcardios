//
//  LoginTableViewCell.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "LoginTableViewCell.h"

@interface LoginTableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTop;


@end
@implementation LoginTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:kUIColorWithRGB(0xf4f4f4)};
    NSAttributedString *account = [[NSAttributedString alloc]initWithString:@"请输入您的手机号码" attributes:dic];
    NSAttributedString *password = [[NSAttributedString alloc]initWithString:@"请输入您的登录密码" attributes:dic];
    self.accountField.attributedPlaceholder = account;
    self.passwordField.attributedPlaceholder = password;
    
    
    if (kMainScreenHeight < 667) {
        _headerTop.constant = 44;
    }
    
    
    
}


- (IBAction)buttonAction:(UIButton *)sender {
    NSInteger tag = 0;
    if (sender == self.loginButton) {
        tag = LoginTableViewCellType_Login;
        
        [self delegateDidAction:tag andData:@[self.accountField.text ? self.accountField.text : @"",self.passwordField.text ? self.passwordField.text : @""]];
        return;
    }else if (sender == self.registerButton) {
        tag= LoginTableViewCellType_Register;
    }else if (sender == self.passwordReplaceButton){
        tag = LoginTableViewCellType_ReplacePassword;
    }
    
    [self delegateDidAction:tag andData:nil];
}

- (void)delegateDidAction:(NSInteger)tag andData:(id)data {
    if ([self.delegate respondsToSelector:@selector(loginTableViewCelldidAction:data:)]) {
        [self.delegate  loginTableViewCelldidAction:tag data:data];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.accountField) {
        [self.passwordField becomeFirstResponder];
    }else if (textField == self.passwordField) {
        
        return [textField resignFirstResponder];
    }
    
    return YES;
}


@end
