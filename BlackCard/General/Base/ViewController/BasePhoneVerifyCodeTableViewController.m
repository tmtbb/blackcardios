//
//  BasePhoneVerifyCodeTableViewController.m
//  douniwan
//
//  Created by yaobanglin on 15/9/8.
//  Copyright (c) 2015 yaowang. All rights reserved.
//

#import "BasePhoneVerifyCodeTableViewController.h"
#import "SendVerifyCodeButton.h"
//#import "AppAPIHelper.h"
#import "ValidateHelper.h"
#import "UIViewController+Category.h"
#import "NSString+Category.h"

@implementation BasePhoneVerifyCodeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phone.delegate = self;
    self.verifyCode.delegate = self;
}

- (IBAction)didOk:(id)sender {
    [self hideKeyboard];
    if ([self isValidateData]) {
        [self didRequest];
    }
}

- (BOOL)isValidateData {
    NSError __autoreleasing *error = nil;
    if ([[ValidateHelper shared] checkUserPhone:_phone.text error:&error]
            && [[ValidateHelper shared] checkVerifyCode:_verifyCode.text error:&error]) {
        return YES;
    }
    [self showError:error];
    return NO;
}

- (IBAction)didSendVerifyCode:(id)sender {
    [self hideKeyboard];
    NSError *error = nil;
    if (![[ValidateHelper shared] checkUserPhone:_phone.text error:&error]) {
        [self showError:error];
    }
    else {
        [self showLoader:@""];
        [_sendButton startWithCount];
        __weak typeof(self) SELF = self;
//        [[[AppAPIHelper shared] getMyAndUserAPI] sendPhoneVerifyCode:_phone.text
//                                                           type:self.getVerifyCodeType
//                                                       complete:^(id data) {
//                                                           [SELF showTips:@"短信已成功发送"];
//                                                       }
//                                                          error:^(NSError *error) {
//                                                              [SELF.sendButton stopWithCount];
//                                                              [SELF didRequestError:error];
//                                                          }];
    }
}

- (NSInteger)getVerifyCodeType {
    return 0;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ( ! [NSString  isStringEmpty:string])
    {
        int maxLength = 0;
        if (textField == self.phone) {
            maxLength = kConstMaxPhoneLength;
        }
        else if (textField == self.verifyCode) {
            maxLength = kConstMaxVerifyCodeLength;
        }
        if (maxLength > 0 && [textField.text stringByTrim].length >= maxLength)
        {
            return NO;
        }
    }
    return YES;
}

@end
