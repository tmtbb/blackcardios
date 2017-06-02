//
//  ChoosePayTypeView.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ChoosePayTypeView.h"
@implementation ChoosePayTypeView


- (void)awakeFromNib {
    
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)update:(NSString *)data {
    self.currentPurseMoneyLabel.text = [NSString stringWithFormat:@"当前可用余额¥%@",data];
    
    
    
}

- (void)purseButtonCanUse:(BOOL)canUse {
    
    _myPurseButton.userInteractionEnabled = canUse;
}




- (IBAction)closeButtonAction:(UIButton *)sender {
    
    [self didAction:ChoosePayTypeViewStatus_Close];
    
}

- (IBAction)payButtonAction:(UIButton *)sender {
    ChoosePayTypeViewStatus status =  ChoosePayTypeViewStatus_PursePay + sender.tag - 100;
  
    [self didAction:status];
    
    
}
- (IBAction)forgetPayPassword:(UIButton *)sender {
    
    [self didAction:ChoosePayTypeViewStatus_ForgetPassword];
}



- (void)didKeyboardShow:(NSNotification *)notification {
    if (_payPasswordField.isFirstResponder) {
        
        
        
        CGFloat height = CGRectGetHeight([[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]);
        WEAKSELF;
        if (height > 0) {
            CGFloat heightTime = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] ;
            [UIView animateWithDuration:heightTime animations:^{
                weakSelf.choosePayView.hidden = YES;
                [weakSelf inputBarChangeHeight:height];
            }];
            
        }
    }
    
    
}

- (void)didKeyboardHide:(NSNotification *)notification {
    if ( _payPasswordField.isFirstResponder)
    {
        NSTimeInterval duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        NSTimeInterval curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] doubleValue];
        WEAKSELF
        
        [UIView animateWithDuration:duration delay:0 options:curve animations:^{
            weakSelf.choosePayView.hidden = NO;
            [weakSelf inputBarChangeHeight:-1];
        } completion:nil];
    }
    
}

- (void)inputBarChangeHeight:(CGFloat )height{
    
    CGFloat payViewHeight = self.passwordView.frameHeight;
    
    if (height <= 0 ) {
        self.passwordViewBottom.constant = -payViewHeight;
    }else {
        
        CGFloat centerHeight = (kMainScreenHeight - height - payViewHeight) / 2.0;
        
        self.passwordViewBottom.constant = height + centerHeight;
        
    }
    
  
    [self layoutIfNeeded];
    
    
}


- (void)showKeyboard {
  [_payPasswordField becomeFirstResponder];
   
    
}

- (void)hiddenKeyBoard {
    
    [_payPasswordField resignFirstResponder];
    _payPasswordField.text = nil;
}

@end
