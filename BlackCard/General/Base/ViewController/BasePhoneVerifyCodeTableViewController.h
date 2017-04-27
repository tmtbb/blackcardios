//
//  BasePhoneVerifyCodeTableViewController.h
//  douniwan
//
//  Created by yaobanglin on 15/9/8.
//  Copyright (c) 2015 yaowang. All rights reserved.
//



#import "BaseRequestTableViewController.h"

@class SendVerifyCodeButton;

@interface BasePhoneVerifyCodeTableViewController : BaseRequestTableViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet SendVerifyCodeButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;
-(IBAction) didSendVerifyCode:(id) sender;
-(IBAction) didOk:(id) sender;
-(NSInteger) getVerifyCodeType;
-(BOOL) isValidateData;
@end
