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
//#define kHttpAPIUrl_HOST @"http://192.168.104.241:8080"
//#define kRunMode @"debug"
#else
//#define kHttpAPIUrl_HOST @"" //新正式生产环境

#define kHttpAPIUrl_HOST @"https://app.jingyingheika.com"
//#define kHttpAPIUrl_HOST @"http://101.37.82.111:9999"

//#define kHttpAPIUrl_HOST @"" //预发布环境
//#define kHttpAPIUrl_HOST @""
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

#define kHttpAPIUrl_sendBlackCardVerification       kHttpAPIUrl_HOST@"/api/blackcard/sms/code.json"
#define kHttpAPIUrl_sendVerification       kHttpAPIUrl_HOST@"/api/sms/code.json"
#define kHttpAPIUrl_checkVerification       kHttpAPIUrl_HOST@"/api/sms/code/validate.json"
#define kHttpAPIUrl_rechargeMoney      kHttpAPIUrl_HOST@"/api/user/balance/recharge.json"
#define kHttpAPIUrl_repassword      kHttpAPIUrl_HOST@"/api/user/repassword.json"

#define kHttpAPIUrl_rePayPassword      kHttpAPIUrl_HOST@"/api/user/pay/repassword.json"

#define kHttpAPIUrl_myPurseDetail     kHttpAPIUrl_HOST@"/api/user/balance/details.json"
#define kHttpAPIUrl_userBlance    kHttpAPIUrl_HOST@"/api/user/balance.json"
#define kHttpAPIUrl_userShoppingList    kHttpAPIUrl_HOST@"/api/trade/usertrades.json"

#define kHttpAPIUrl_userDetail    kHttpAPIUrl_HOST@"/api/user/detail.json"
#define kHttpAPIUrl_changeUserDetail   kHttpAPIUrl_HOST@"/api/user/edit.json"

#define kHttpAPIUrl_upLoad   kHttpAPIUrl_HOST@"/api/file/upload.json"

#define kHttpAPIUrl_log   kHttpAPIUrl_HOST@"/api/sys/log.josn"

#define kHttpAPIUrl_waiterServiceDetail   kHttpAPIUrl_HOST@"/api/butlerservice/info.json"
#define kHttpAPIUrl_waiterPay   kHttpAPIUrl_HOST@"/api/butlerservice/pay.json"

#define kHttpAPIUrl_resetPassword         kHttpAPIUrl_HOST@"/api/blackcard/repassword.json"



#define kHttpAPIUrl_userAgreement         @"http://app.jingyingheika.com/static/UserAgreement.html"
#define kHttpAPIUrl_aboutMe               @"http://app.jingyingheika.com/static/about.html"
#define kHttpAPIUrl_webCallWaiter         @"http://www.jingyingheika.com/"

//消息列表
#define kHttpAPIUrl_tribeList             kHttpAPIUrl_HOST@"/api/tribe/message/list.json"
//发布评论
#define kHttpAPIUrl_tribeComment         kHttpAPIUrl_HOST@"/api/tribe/message/comment/add.json"
//评论列表
#define kHttpAPIUrl_tribeCommentList     kHttpAPIUrl_HOST@"/api/tribe/message/comment/list.json"
//发布消息
#define kHttpAPIUrl_tribeAdd             kHttpAPIUrl_HOST@"/api/tribe/message/add.json"
//点赞
#define kHttpAPIUrl_tribeLikeAdd         kHttpAPIUrl_HOST@"/api/tribe/message/like/add.json"
//删除点赞
#define kHttpAPIUrl_tribeLikeDel         kHttpAPIUrl_HOST@"/api/tribe/message/like/delete.json"
//点赞列表
#define kHttpAPIUrl_tribeLikeList        kHttpAPIUrl_HOST@"/api/tribe/message/like/list.json"
#endif /* HttpHeader_h */
