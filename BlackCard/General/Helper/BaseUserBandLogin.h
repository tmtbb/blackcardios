//
//  BaseUserBandLogin.h
//  mgame648
//
//  Created by iMac on 16/6/13.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpAPI.h"
#import "MyAndUserModel.h"
typedef NS_ENUM(NSInteger, LoginType) {
    LoginTypePlatform = 0,
    LoginTypeWX = 1,
    LoginTypeWeibo = 3,
    LoginTypeQQ = 2
};

@protocol LoginDelegate <NSObject>
- (void)didLoginStart;

- (void)didLoginOk:(MyAndUserModel *)user;

- (void)didLoginError:(NSError *)err;

@end




@interface BaseUserBandLogin : NSObject {
    /**
     * 请求失败block
     */
@protected
    ErrorBlock _errorBlock;
    /**
     * 请求成功 block
     */
@protected
    CompleteBlock _completeBlock;
}
@property(weak,nonatomic) id <LoginDelegate> delegate;

- (void)login;

- (void)didStart;

- (void)didOk:(MyAndUserModel *)user;

- (void)didError:(NSError *)err;

- (void)didStrError:(NSString *)err;
@end

@interface BaseThirdLogin : BaseUserBandLogin <OEZHandleOpenURLDelegate> {
@protected
    UserBandModel *_userInfo;
}
- (void)httpReqeustWithUrl:(NSString *)url parameters:(NSDictionary *)parameters complete:(CompleteBlock)complete;
@end
