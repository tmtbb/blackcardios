//
//  LoginTableViewCell.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

typedef NS_ENUM(NSInteger,LoginTableViewCellType) {
    LoginTableViewCellType_Login        = 100L,
    LoginTableViewCellType_Register,
    LoginTableViewCellType_ReplacePassword
    
};

@protocol LoginTableViewCellAction <NSObject>

- (void)loginTableViewCelldidAction:(NSInteger)action data:(id)data;

@end


@interface LoginTableViewCell : OEZTableViewCell


@property(weak,nonatomic)id<LoginTableViewCellAction>delegate;


@property (weak, nonatomic) IBOutlet UITextField *accountField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *passwordReplaceButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@end
