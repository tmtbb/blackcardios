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
#import "PurchaseHistoryModel.h"
#import "TribeModel.h"
#import "DeviceKeyHelper.h"
//#import "UIAlertView+Block.h"


@implementation HttpMyAndUser


- (void)getDeviceKeyWithComplete:(CompleteBlock)complete withError:(ErrorBlock)error {
    
        [[AppAPIHelper shared].getMyAndUserAPI getRegisterDeviceWithComplete:^(id data) {
            NSString *key = data[@"deviceKey"];
            NSString *keyid = data[@"deviceKeyId"] ?  [NSString stringWithFormat:@"%@",data[@"deviceKeyId"]] : nil;
            if ( ! [NSString isEmpty:key] && ![NSString isEmpty:keyid]) {
                [[DeviceKeyHelper shared] setDeviceKeyId:keyid];
                [[DeviceKeyHelper shared] setDeviceKey:key];
            }
            if (complete) {
                complete(data);
            }
            
            
        } withError:error];
}

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

- (void)repasswordOldPassword:(NSString *)oldPass andNewPassword:(NSString *)pass complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:oldPass forKey:@"password"];
    [parameters setObject:pass forKey:@"newPassword"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_repassword parameters:parameters complete:complete error:errorBlock];

    }
    
    
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

- (void)checkVerifyCode:(NSString *)code phone:(NSString *)phone token:(NSString *)token  andType:(NSString *)type  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:code forKey:@"phoneCode"];
    [parameters setObject:type forKey:@"codeType"];
    [parameters setObject:phone forKey:@"phoneNum"];
    [parameters setObject:token forKey:@"codeToken"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_checkVerification parameters:parameters complete:complete error:errorBlock];
    }
    
    
}

- (void)changePayPassword:(NSString *)password phone:(NSString *)phone codeToken:(NSString *)codeToken phoneCode:(NSString *)phoneCode complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:password forKey:@"password"];
    [parameters setObject:codeToken forKey:@"codeToken"];
    [parameters setObject:phone forKey:@"phoneNum"];
    [parameters setObject:phoneCode forKey:@"phoneCode"];
    
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_rePayPassword parameters:parameters complete:complete error:errorBlock];
    }
}


- (void)rechargeMoneyWithPayType:(NSInteger)payType andMoney:(NSString *)money complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@(payType) forKey:@"payType"];
    [parameters setObject:money forKey:@"amount"];
    if ([self  addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelRequest:kHttpAPIUrl_rechargeMoney parameters:parameters modelClass:[PayInfoModel class] complete:complete error:errorBlock];
    }
    
    
}



- (void)getMyPurseDetailWihtPage:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@(page) forKey:@"page"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelsRequest:kHttpAPIUrl_myPurseDetail parameters:parameters modelClass:[MyPurseDetailModel class] complete:complete error:errorBlock];
    }
    
}

- (void)getUserShoppingListWihtPage:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@(page) forKey:@"page"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelsRequest:kHttpAPIUrl_userShoppingList parameters:parameters modelClass:[PurchaseHistoryModel class] complete:complete error:errorBlock];
    }
    
}

- (void)getTribeListWihtPage:(NSInteger)page complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@(page) forKey:@"page"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelsRequest:kHttpAPIUrl_tribeList parameters:parameters modelClass:[TribeModel class] complete:complete error:errorBlock];
    }
    
}


- (void)doTribePraiseTribeMessageId:(NSString *)tribeMessageId isLike:(BOOL)islike complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:tribeMessageId forKey:@"tribeMessageId"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        NSString *url = islike ? kHttpAPIUrl_tribeLikeDel : kHttpAPIUrl_tribeLikeAdd;
        [self postRequest:url parameters:parameters complete:complete error:errorBlock];
    }
    
    
}

- (void)getTribeCommentListWihtPage:(NSInteger)page tribeMessageId:(NSString *)tribeMessageId complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@(page) forKey:@"page"];
    [parameters setObject:tribeMessageId forKey:@"tribeMessageId"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postModelsRequest:kHttpAPIUrl_tribeCommentList parameters:parameters modelClass:[CommentListModel class] complete:complete error:errorBlock];
    }
}
-(void)postTribeCommentTribeMessageId:(NSString *)tribeMessageId message:(NSString *)message  complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:tribeMessageId forKey:@"tribeMessageId"];
    [parameters setObject:message forKey:@"comment"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
    [self postRequest:kHttpAPIUrl_tribeComment parameters:parameters complete:complete error:errorBlock];
    }
    
}
- (void)getUserBlanceComplete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self postRequest:kHttpAPIUrl_userBlance parameters:parameters complete:complete error:errorBlock];
    }

    
}


- (void)getUserDetailComplete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        
        [self postModelRequest:kHttpAPIUrl_userDetail parameters:parameters modelClass:[UserDetailModel class] complete:complete error:errorBlock];
    }
    
}


- (void)doChangeUserDetail:(NSDictionary *)dic complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dic];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        
        [self postRequest:kHttpAPIUrl_changeUserDetail parameters:parameters complete:complete error:errorBlock];
    }
    
}

- (void)doUpLoadUserHeaderIcon:(NSData *)image complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        
        [self uploadFiles:kHttpAPIUrl_upLoad parameters:parameters fileDataArray:@[image] complete:complete error:errorBlock];
    }
    
}

-(void)postMessageWithMessage:(NSString *)message imageArray:(NSArray *)imageArray complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:message forKey:@"message"];
    if ([self addCurrentUserToken:parameters isMustToken:YES error:errorBlock]) {
        [self uploadFiles:kHttpAPIUrl_tribeAdd parameters:parameters fileDataArray:imageArray complete:complete error:errorBlock];
    }
}

- (void)doLog:(NSDictionary *)dic complete:(CompleteBlock)complete error:(ErrorBlock)errorBlock {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    [self postRequest:kHttpAPIUrl_log parameters:parameters complete:complete error:errorBlock];
    
    
    
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
