//
//  HttpMyAndUser.m
//  mgame648
//
//  Created by iMac on 15/11/24.
//  Copyright © 2015年 yaowang. All rights reserved.
//

#import "HttpMyAndUser.h"
#import "MyAndUserModel.h"
#import "PayModel.h"
//#import "UIAlertView+Block.h"


@implementation HttpMyAndUser

- (void)getRegisterDeviceWithComplete:(CompleteBlock)complete withError:(ErrorBlock)error {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    
    [parameters setObject:[BaseHttpAPI advertisingIdentifier] forKey:@"deviceId"];
    [parameters setObject:[[UIDevice currentDevice] systemVersion] forKey:@"osVersion"];
    [parameters setObject:[BaseHttpAPI getDeviceName] forKey:@"deviceModel"];
    [parameters setObject:[UIDevice currentDevice].name forKey:@"deviceName"];
    NSString *screenScale = [NSString stringWithFormat:@"%@×%@",@(kMainScreenWidth * 2),@(kMainScreenHeight * 2)];
    [parameters setObject:screenScale forKey:@"deviceResolution"];
    [self postRequest:kHttpAPIUrl_registerTools parameters:parameters complete:complete error:error];

    
    
    
}





- (void)registerWithRegisterModel:(NSDictionary *)dic complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [self postRequest:kHttpAPIUrl_userRegister parameters:parameters complete:complete error:errorBlock];


}


- (void)registerWithPay:(NSDictionary *)dic complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [self postModelRequest:kHttpAPIUrl_userRegisterPay parameters:parameters modelClass:[PayInfoModel class] complete:complete error:errorBlock];
    
}

- (void) setPushToken:(NSMutableDictionary*) parameters {
    NSString *pushToken = [[CurrentUserHelper shared] pushToken];
    if ( pushToken != nil ) {
        [parameters setObject:pushToken forKey:@"deviceId"];
    }
}

- (void)loginUserName:(NSString *)username password:(NSString *)password  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:username forKey:@"phoneNum"];
    [parameters setObject:password forKey:@"password"];
    [self postRequest:kHttpAPIUrl_login parameters:parameters complete:complete error:errorBlock];

}

- (void)getUserInfoWithToken:(NSString *)toekn complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:toekn forKey:@"token"];
    
    [self postModelRequest:kHttpAPIUrl_userInfo parameters:parameters modelClass:[MyAndUserModel class] complete:complete error:errorBlock];
   
    
    
}


- (void)logoutWithComplete:(CompleteBlock)complete withErrer:(ErrorBlock)error
{
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    if ([self addCurrentUserToken:parameters isMustToken:YES error:error]) {
//        [self postRequest:kHttpAPIUrl_logout parameters:parameters complete:complete error:error];
//    }
}


- (void)repassword:(NSString *)password cardNum:(NSString *)cardNum verifyCode:(NSString *)code andCodeToken:(NSString *)codeToken complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        [parameters setObject:cardNum forKey:@"blackcardNo"];
        [parameters setObject:code forKey:@"phoneCode"];
        [parameters setObject:codeToken forKey:@"codeToken"];
        [parameters setObject:password forKey:@"password"];
    
    [self postRequest:kHttpAPIUrl_resetPassword parameters:parameters complete:complete error:errorBlock];

    
}
- (void)resetPwd:(NSString *)telphone withCode:(NSString *)code withPwd:(NSString *)pwd complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock
{
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [parameters setObject:telphone forKey:@"telphone"];
//    [parameters setObject:code forKey:@"code"];
//    [parameters setObject:pwd forKey:@"pwd"];
//    [self setPushToken:parameters];
//    [self postModelRequest:kHttpAPIUrl_resetPwd parameters:parameters modelClass:[MyAndUserModel class] complete:complete error:errorBlock];
}

- (void)sendBlackCardVerifyCode:(NSString *)code  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:code forKey:@"blackcardNo"];
    [self postRequest:kHttpAPIUrl_sendBlackCardVerification parameters:parameters complete:complete error:errorBlock];
}

- (void)sendVerifyCode:(NSString *)code andType:(NSString *)type complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:code forKey:@"phoneNum"];
     [parameters setObject:type forKey:@"codeType"];
    [self postRequest:kHttpAPIUrl_sendVerification parameters:parameters complete:complete error:errorBlock];
    
}

- (void)suggestWithNote:(NSString *)content complete:(CompleteBlock)complete errer:(ErrorBlock)error
{
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [parameters setObject:content forKey:@"content"];
//    if ([self addCurrentUserToken:parameters isMustToken:NO error:error]) {
//        [self postRequest:kHttpAPIUrl_suggest parameters:parameters complete:complete error:error];
//    }
    
}

- (void)detailWithPageIndex:(NSInteger)index complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock
{
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [parameters setObject:@(index) forKey:@"pageIndex"];
//    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
//        [self postModelsRequest:kHttpAPIUrl_detail parameters:parameters modelClass:[MyAccountModel class] complete:complete error:errorBlock];
//    }
}



- (void)checkVersionWithCheckVersion:(NSString*) channel complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock
{
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [parameters setObject:channel forKey:@"identityCode"];
//    
//#ifdef MGAME648_STORE
//    [parameters setObject:@"2" forKey:@"vtype"];
//#else
//    [parameters setObject:@"1" forKey:@"vtype"];
//#endif
//    [self addCurrentUserToken:parameters isMustToken:NO error:errorBlock];
//    [self postModelRequest:kHttpAPIUrl_checkVersion parameters:parameters modelClass:[MySettingCheckVersion class] complete:complete error:errorBlock];
}

- (void)checkTokenWithComplete:(CompleteBlock)complete error:(ErrorBlock)errorBlock
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_checkToken parameters:parameters complete:complete error:errorBlock];
    }
}



- (void)userBandWith:(UserBandModel *)userBandModel withComplete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
//    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
//    [parameters setObject:userBandModel.openId forKey:@"openId"];
//    [parameters setObject:@(userBandModel.accountType).stringValue forKey:@"accountType"];
//    
//#ifndef MGAME648_STORE
//    [parameters setObject:userBandModel.channel forKey:@"identityCode"];
//    [parameters setObject:@"" forKey:@"channel"];
//#endif
//    [parameters setObject:userBandModel.nickname forKey:@"nickname"];
//    [parameters setObject:userBandModel.headpic forKey:@"headpic"];
//    [parameters setObject:userBandModel.appType forKey:@"appType"];
//    [parameters setObject:userBandModel.unionid forKey:@"unionId"];
//    [self setPushToken:parameters];
//    [self postModelRequest:kHttpAPIUrl_userBand parameters:parameters modelClass:[MyAndUserModel class] complete:complete error:errorBlock];
}




@end
