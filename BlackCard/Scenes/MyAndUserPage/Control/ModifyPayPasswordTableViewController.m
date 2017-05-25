//
//  ModifyPayPasswordTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ModifyPayPasswordTableViewController.h"
#import "SendVerifyCodeButton.h"
#import "ValidateHelper.h"
#import "MyAndUserModel.h"
@interface ModifyPayPasswordTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet SendVerifyCodeButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *verificationField;
@property(strong,nonatomic) CheckPayPasswordModel *model;


@end

@implementation ModifyPayPasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _sendButton.maxLastSec = 60;
    
    _model = [[CheckPayPasswordModel alloc]init];
    _model.phoneNum = [CurrentUserHelper shared].myAndUserModel.phoneNum;
    
    _phoneNumberLabel.text = [_model.phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, _model.phoneNum.length - 3) withString:@"********"];
    

}
- (IBAction)sendVerificationAction:(id)sender {
    

        
    [_sendButton startWithCount];
        WEAKSELF
    
    [[AppAPIHelper shared].getMyAndUserAPI sendVerifyCode:_model.phoneNum andType:@"4" complete:^(id data) {
        weakSelf.model.codeToken = data[@"codeToken"];
        [weakSelf showTips:@"验证码已发送"];
    } error:^(NSError *error) {
        [weakSelf showError:error];
        [weakSelf.sendButton stopWithCount];
    }];
    
        
}
- (IBAction)buttonAction:(id)sender {
    NSError *error = nil;
    if (!_model.codeToken) {
        [self showTips:@"请先获取验证码"];
    }else if (![[ValidateHelper shared] checkNumber:_verificationField.text.trim emptyString:@"请输入验证码" errorString:@"请输入正确的验证码" error:&error]){
        [self showError:error];
    }else {
        _model.phoneCode = _verificationField.text.trim;
        WEAKSELF
        [self showLoader:@"验证中..."];
        [[AppAPIHelper shared].getMyAndUserAPI checkVerifyCode:_model.phoneCode phone:_model.phoneNum token:_model.codeToken andType:@"4" complete:^(id data) {
            [weakSelf hiddenProgress];
            [weakSelf pushStoryboardViewControllerIdentifier:@"SetPayPasswordTableViewController" block:^(UIViewController *viewController) {
                
                [viewController setValue:weakSelf.model forKey:@"model"];
            }];
        } error:^(NSError *error) {
            [weakSelf showError:error];
        }];
        
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
