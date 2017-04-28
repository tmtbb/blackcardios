//
//  CurrentUserHelper.h
//  mgame648
//
//  Created by yaowang on 15/11/25.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyAndUserModel.h"
#import "CurrentUserActionHelper.h"
@interface CurrentUserHelper : NSObject<OEZHelperProtocol,CurrentUserActionDelegate>
@property(nonatomic, readonly, strong) MyAndUserModel *myAndUserModel;
@property(nonatomic, strong) NSString *pushToken;
@property(nonatomic,strong,readonly) NSString *channel;

/**
 * 是否登录
 */
- (BOOL)isLogin;
/**
 * 登录用户token
 */
- (NSString *)token;
/**
 * 登录用户ID
 */
- (NSString *)uid;

- (NSString *)userBlackCardName;

- (NSString *)userLogoImage ;
//- (NSString *)idInt;
/**
 *  用户余额
 *
 *  @return <#return value description#>
 */
//- (NSString *)stock;
/**
 *  保存数据
 */
- (void)saveData;


- (void)saveToken:(NSString *)token;
/**
 *  用户ID
 *
 *  @return <#return value description#>
 */
- (NSString *)userName;
/**
 *  登录用户数据
 *
 *  @param userinfo <#userinfo description#>
 */
- (void)login:(MyAndUserModel *)userinfo;
/**
 *  更新当用用户数据
 *
 *  @param userinfo <#userinfo description#>
 */
- (void)upUserModel:(MyAndUserModel *)userinfo;


/**
 *  退出
 */
- (void)logout:(id)sender;
@end
