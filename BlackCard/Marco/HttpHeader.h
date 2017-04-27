//
//  HttpHeader.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#ifndef HttpHeader_h
#define HttpHeader_h

#define Development  //开发环境宏,注掉时开启正式 生产环境

/**
 * API host
 */


#ifdef Development

//#define kHttpAPIUrl_HOST @"" //预发布环境
#define kHttpAPIUrl_HOST @"http://101.37.82.111:9999"
//#define kHttpAPIUrl_HOST @"http://192.168.112.231:8080"
//#define kRunMode @"debug"
#else
//#define kHttpAPIUrl_HOST @"" //新正式生产环境
#define kHttpAPIUrl_HOST @"" //预发布环境
#define kHttpAPIUrl_HOST @""
#endif

/**
 *  首页
 *
 *  @return 首页地址
 */
#define kHttpAPIUrl_registerTools      kHttpAPIUrl_HOST@"/api/device/register.json"


#define kHttpAPIUrl_login             kHttpAPIUrl_HOST@"/api/user/login.json"

#define kHttpAPIUrl_userInfo          kHttpAPIUrl_HOST@"/api/user/info.json"


#define kHttpAPIUrl_privilegeList          kHttpAPIUrl_HOST@"/api/privilege/list.json"
#define kHttpAPIUrl_CardList               kHttpAPIUrl_HOST@"/api/blackcard/infos.json"

#define kHttpAPIUrl_checkToken          kHttpAPIUrl_HOST@"/api/user/refreshToken.json"
#define kHttpAPIUrl_userRegister         kHttpAPIUrl_HOST@"/api/blackcard/register.json"
#define kHttpAPIUrl_userRegisterPay         kHttpAPIUrl_HOST@"/api/blackcard/register/pay.json"

#define kHttpAPIUrl_sendVerification       kHttpAPIUrl_HOST@"/api/blackcard/sms/code.json"
#define kHttpAPIUrl_resetPassword         kHttpAPIUrl_HOST@"/api/blackcard/repassword.json"

#endif /* HttpHeader_h */
