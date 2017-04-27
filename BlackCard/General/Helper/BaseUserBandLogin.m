//
//  BaseUserBandLogin.m
//  mgame648
//
//  Created by iMac on 16/6/13.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "BaseUserBandLogin.h"
#import "MyAndUserModel.h"

@implementation BaseUserBandLogin

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initRequestBlock];
    }
    
    return self;
}

- (void)initRequestBlock {
    __weak id SELF = self;
    _errorBlock = ^(NSError *error) {
        [SELF didError:error];
    };
    _completeBlock = ^(id data) {
        [SELF didOk:data];

    };
}

- (void)login {
    [self didStart];
}

- (void)didStart {
    if ([self.delegate respondsToSelector:@selector(didLoginStart)])
        [self.delegate didLoginStart];
}

- (void)didOk:(MyAndUserModel *)user {
    if ([self.delegate respondsToSelector:@selector(didLoginOk:)])
        [self.delegate didLoginOk:user];
}

- (void)didError:(NSError *)err {
    if ([self.delegate respondsToSelector:@selector(didLoginError:)])
        [self.delegate didLoginError:err];
}

- (void)didStrError:(NSString *)err {
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:err forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:kAppNSErrorDomain code:kAppNSErrorLoginCode userInfo:userInfo];
    [self didError:error];
}

 
@end

@implementation BaseThirdLogin {
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _userInfo = [[UserBandModel alloc] init];
        [[OEZHandleOpenURLHelper shared] addHandleDelegate:self];
        
        //给第三方 登陆 预留的 推送
        //        NSString *str = [CurrentUserHelper shared].deviceId;
        //        _userInfo.deviceId = str == nil ? @"" : str;
        
    }
    return self;
}

- (void)login {
    [super login];
//    UserBandModel *model = [[UserBandModel alloc] init];
//    [model setOpenId:@"ogfELwx1EsGV2AjhLm9hfRcVMxPU"];
//    [model setAppType:@"1"];
//    [model setChannel:@""];
//    [model setHeadpic:@"http://wx.qlogo.cn/mmopen/WWxicToNQlgy3NLrgd3cwM3mKXIib1vJoQnh33WCJLZadj811mw0nJMNX6XicpVNlYGmOaPeI3XxialgmaTcwz7vnhX5E7rq4JicI/0"];
//    [model setUnionid:@"o1X4bxJ0AcHpwrKwAyBfIQ6TN0kc2180BC4B332156A86044E1B8C0109E28"];
//    [model setNickname:@"无"];
//    [model setAccountType:1];
    
//    [[[AppAPIHelper shared] getMyAndUserAPI] userBandWith:_userInfo withComplete:_completeBlock error:_errorBlock];
}


- (void)didOk:(MyAndUserModel *)user {
//    [[HandleOpenURLHelper shared] removeHandleDelegate:self];
    [super didOk:user];
    [[OEZHandleOpenURLHelper shared] removeHandleDelegate:self];
}

- (void)didError:(NSError *)err {
//    [[HandleOpenURLHelper shared] removeHandleDelegate:self];
    [super didError:err];
    [[OEZHandleOpenURLHelper shared] removeHandleDelegate:self];
}

- (BOOL)handleOpenURL:(NSURL *)url {
    return NO;
}

- (NSString *)getKey {
    return nil;
}

- (void)httpReqeustWithUrl:(NSString *)url parameters:(NSDictionary *)parameters complete:(CompleteBlock)complete {
    BaseHttpAPI *http = [[BaseHttpAPI alloc] init];
    [http getReqeust:url parameters:parameters complete:complete error:_errorBlock];
}
@end
