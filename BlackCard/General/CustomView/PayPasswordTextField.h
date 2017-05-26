//
//  PayPasswordTextField.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PayPasswordTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldChanged:(UITextField *)textField;

@end


@interface PayPasswordTextField : UITextField
@property(weak,nonatomic)id<PayPasswordTextFieldDelegate>changedDelegate;
@end
