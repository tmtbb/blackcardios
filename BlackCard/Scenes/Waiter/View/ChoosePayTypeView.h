//
//  ChoosePayTypeView.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
#import "PayPasswordTextField.h";

typedef NS_ENUM(NSInteger,ChoosePayTypeViewStatus) {
    
    ChoosePayTypeViewStatus_Close  = 0,
    
    ChoosePayTypeViewStatus_PursePay,
    ChoosePayTypeViewStatus_AliPay,
    ChoosePayTypeViewStatus_WxPay,
    ChoosePayTypeViewStatus_ForgetPassword
    
};


@interface ChoosePayTypeView : OEZNibView
@property (weak, nonatomic) IBOutlet UIView *choosePayView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *currentPurseMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *myPurseButton;
@property (weak, nonatomic) IBOutlet UIButton *alipayButton;
@property (weak, nonatomic) IBOutlet UIButton *wxPayButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordViewBottom;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet PayPasswordTextField *payPasswordField;

- (void)showKeyboard;
-(void)hiddenKeyBoard;

- (void)purseButtonCanUse:(BOOL)canUse;

@end
