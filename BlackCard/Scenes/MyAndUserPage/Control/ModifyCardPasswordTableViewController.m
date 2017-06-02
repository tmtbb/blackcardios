//
//  ModifyCardPasswordTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ModifyCardPasswordTableViewController.h"
#import "ValidateHelper.h"
@interface ModifyCardPasswordTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldPassworldField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *againPasswordField;

@end

@implementation ModifyCardPasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 102) {
     return   [textField resignFirstResponder];
    }else {
        [[self.view viewWithTag:textField.tag + 1] becomeFirstResponder];
    }
    return YES;
}
- (IBAction)buttonAction:(UIButton*)sender {
    NSError *error = nil;
    sender.userInteractionEnabled = NO;
    
    
    NSString *oldPass = _oldPassworldField.text.trim;
    NSString *pass = _passwordField.text.trim;
    NSString *againPass = _againPasswordField.text.trim;
    
    
    if (![[ValidateHelper shared] checkUserPass:oldPass emptyString:@"请输入原密码" error:&error]) {
        
        [self showError:error];
    }else if(![[ValidateHelper shared] checkUserPass:pass emptyString:@"请输入新密码" error:&error]){
        [self showError:error];
    }else if([oldPass isEqualToString:pass]){
        [self showTips:@"原密码与新密码不能相同"];
    }else if (![againPass isEqualToString:pass]){
        [self showTips:@"新密码两次输入不相同"];
    }else {
        WEAKSELF
        
        [[AppAPIHelper shared].getMyAndUserAPI  repasswordOldPassword:oldPass andNewPassword:againPass complete:^(id data) {
            [weakSelf showTips:@"修改成功"];
            [weakSelf performSelector:@selector(popViewController) withObject:nil afterDelay:0.5];
            
        } error:^(NSError *error) {
            sender.userInteractionEnabled = YES;
            [weakSelf showError:error];
        }];
       
        return;
        
    }
    sender.userInteractionEnabled  = YES;
    
}

- (void)popViewController {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
