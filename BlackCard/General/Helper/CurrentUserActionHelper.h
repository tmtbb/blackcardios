//
//  CurrentUserActionHelper.h
//  mgame648
//
//  Created by yaowang on 15/11/27.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyAndUserModel.h"

@protocol CurrentUserActionDelegate <NSObject>

@optional
/**
 *  登录成功通知
 *
 *  @param sender
 *  @param user   登录返回的用户信息
 */
- (void)sender:(id) sender didLogin:(id) user;
/**
 *  退出登录通知
 *
 *  @param sender <#sender description#>
 */
- (void)didLogoutSender:(id) sender;
/**
 * 更新数据
 */
- (void)sender:(id)sender didUpdate:( MyAndUserModel *)userinfo;
/**
 *  账号余额变动通知
 *
 *  @param sender <#sender description#>
 *  @param money  正数为充值、负数为消费
 */
- (void) sender:(id)sender didChangeMoney:(CGFloat) money;
/**
 *  订单状态变更
 *
 *  @param sender  sender description
 *  @param status  变更后状态
 *  @param orderId 订单ID
 */
- (void)sender:(id)sender didChangeOrderStauts:(NSInteger) status orderId:(NSString*) orderId;

/**
 *  指定跳转订单列表进入订单详情
 *
 *  @param sender  sender description
 *  @param index   index description
 *  @param orderId 订单ID
 */
- (void)sender:(id)sender didFeedBackOrderId:(NSString *)orderId;


/**
 *  是否弹出邀请码弹框
 *
 *  @param sender  <#sender description#>
 *  @param isFirst <#isFirst description#>
 */
- (void)sender:(id)sender didModalWeiXinInvitation:(id)isFirst;
#pragma mark - 动态
/**
 *  发布动态操作
 *
 *  @param dyamic     发布的动态
 */
- (void)sender:(id)sender didPublishDynamic:(id)dynamic;

/**
 *  发布动态成功 更新model
 *
 *  @param dyamic     服务器返回的动态model
 */
- (void)sender:(id)sender didRefreshDynamic:(id)dynamic;

/**
 *  代言人状态更新
 *
 *  @param sender   <#sender description#>
 *  @param isSpread <#isSpread description#>
 */
- (void)sender:(id)sender didIsSpread:(id)isSpread;

/**
 *  删除发布图片通知
 *
 *  @param sender   <#sender description#>
 *  @param isDelete <#isDelete description#>
 */
- (void)sender:(id)sender didIsDelete:(id)isDelete;

/**
 *  消息推送
 *
 *  @param sender <#sender description#>
 *  @param url    <#url description#>
 */
- (void)messagesPraiseHelper:(id)sender withHeadImageUrl:(NSString *)url ;

/**
 *  有消息时红点是否显示
 *
 *  @param sender   <#sender description#>
 *  @param isHidden <#isHidden description#>
 */
- (void)messagesRedMessagesHelper:(id)sender withHidden:(BOOL)isHidden;
@end

@interface CurrentUserActionHelper : NSObject<OEZHelperProtocol,CurrentUserActionDelegate>
/**
 *  注册监听代理
 *
 *  @param delegate <#delegate description#>
 */
- (void)registerDelegate:(id<CurrentUserActionDelegate>) delegate;

/**
 *  移除监听代理
 *
 *  @param delegate <#delegate description#>
 */
- (void)removeDelegate:(id<CurrentUserActionDelegate>) delegate;
@end

