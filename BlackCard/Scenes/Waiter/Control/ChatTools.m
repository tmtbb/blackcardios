//
//  ChatTools.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/28.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ChatTools.h"
#import "AppNavigationController.h"
#import "ChtaNavigationController.h"
@implementation ChatTools



+(UIViewController *)chatViewControllerWithTitle:(NSString *)title {
    
    
    QYSource *source = [[QYSource alloc] init];
    source.title =  @"云巅黑卡iOS";
    source.urlString = @"https://8.163.com/";
    
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = title ? title : @"管家";
    sessionViewController.source = source;
    
    //设置聊天头像
    [[QYSDK sharedSDK] customUIConfig].customerHeadImageUrl = [[CurrentUserHelper shared] userLogoImage];
    [[QYSDK sharedSDK]customUIConfig].rightBarButtonItemColorBlackOrWhite = NO;
    
    

    sessionViewController.hidesBottomBarWhenPushed = YES;
    [[QYSDK sharedSDK] customUIConfig].bottomMargin = 0;

    return  sessionViewController;
}

+(UIViewController *)chatViewControllerWithTitle:(NSString *)title  navigation:(UINavigationController *)navigation{
    [self setQYUserIndfoWithPrivilegeName:title];
    
    UIViewController *sessionViewController = [self chatViewControllerWithTitle:title];
    
    if (navigation) {
        [navigation pushViewController:sessionViewController animated:YES];

    }else {
        
        
      UIBarButtonItem * bar =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(onBack:)];
        bar.tintColor = kUIColorWithRGB(0xffffff);
        sessionViewController.navigationItem.leftBarButtonItem = bar;
     
        ChtaNavigationController  *nav =
        [[ChtaNavigationController alloc] initWithRootViewController:sessionViewController];
        bar.target = nav;
        
        
        return nav;
    }
    
    
    
    return  sessionViewController;
}







-(void)setQYUserIndfo {
    MyAndUserModel *model =  [CurrentUserHelper shared].myAndUserModel;
    QYUserInfo *info = [[QYUserInfo alloc]init];
    info.userId = model.userId;
    
    info.data = [NSString stringWithFormat:
                 @"[{\"key\":\"real_name\", \"value\":\"%@\"},"
                 "{\"key\":\"mobile_phone\", \"value\":%@},"
                 "{\"key\":\"email\", \"hidden\":true},"
                 "{\"index\":0, \"key\":\"userID\", \"label\":\"用户ID\", \"value\":\"%@\"},"
                 "{\"index\":1, \"key\":\"blackCardNo\", \"label\":\"黑卡卡号\", \"value\":\"%@\"},"
                 "{\"index\":2, \"key\":\"blackCard\", \"label\":\"黑卡类型\", \"value\":\"%@\"}]",model.username,model.phoneNum,model.userId,model.blackCardNo,model.blackCardName];
    
    
    //    "{\"index\":1, \"key\":\"blackCardNo\", \"label\":\"黑卡卡号\", \"value\":\"%@\"}"
    
    //    "{\"index\":0, \"key\":\"userID\", \"label\":\"用户ID\", \"value\":\"%@\"}"
    
    
    //    "{\"index\":1, \"key\":\"sex\", \"label\":\"性别\", \"value\":\"先生\"},"
    //    "{\"index\":5, \"key\":\"reg_date\", \"label\":\"注册日期\", \"value\":\"2015-11-16\"},"
    //
    //
    //    "{\"index\":6, \"key\":\"last_login\", \"label\":\"上次登录时间\", \"value\":\"2015-12-22 15:38:54\"}]";
    [[QYSDK sharedSDK] setUserInfo:info];
}
+(void)setQYUserIndfoWithPrivilegeName:(NSString *)name {
    
    MyAndUserModel *model =  [CurrentUserHelper shared].myAndUserModel;
    QYUserInfo *info = [[QYUserInfo alloc]init];
    info.userId = model.userId;
    
   NSString  *privilegeName = name ? name : @"默认";
    info.data = [NSString stringWithFormat:
                 @"[{\"key\":\"real_name\", \"value\":\"%@\"},"
                 "{\"key\":\"mobile_phone\", \"value\":%@},"
                 "{\"key\":\"email\", \"hidden\":true},"
                 "{\"index\":0, \"key\":\"userID\", \"label\":\"用户ID\", \"value\":\"%@\"},"
                 "{\"index\":1, \"key\":\"blackCardNo\", \"label\":\"黑卡卡号\", \"value\":\"%@\"},"
                 "{\"index\":2, \"key\":\"blackCard\", \"label\":\"黑卡类型\", \"value\":\"%@\"},"
                 "{\"index\":3, \"key\":\"privilegeName\", \"label\":\"服务类型\", \"value\":\"%@\"}]",model.username,model.phoneNum,model.userId,model.blackCardNo,model.blackCardName,privilegeName];
    
    
    //    "{\"index\":3, \"key\":\"privilegeName\", \"label\":\"服务类型\", \"value\":\"%@\"}"
    
    //    "{\"index\":0, \"key\":\"userID\", \"label\":\"用户ID\", \"value\":\"%@\"}"
    
    
    //    "{\"index\":1, \"key\":\"sex\", \"label\":\"性别\", \"value\":\"先生\"},"
    //    "{\"index\":5, \"key\":\"reg_date\", \"label\":\"注册日期\", \"value\":\"2015-11-16\"},"
    //
    //
    //    "{\"index\":6, \"key\":\"last_login\", \"label\":\"上次登录时间\", \"value\":\"2015-12-22 15:38:54\"}]";
    [[QYSDK sharedSDK] setUserInfo:info];
    
    
    
}
+(void)chatViewControllerWithTitle:(NSString *)title  present:(UIViewController *)viewController {
    
    UIViewController *navi  = [self chatViewControllerWithTitle:title navigation:nil];
    [viewController presentViewController:navi animated:YES completion:nil];

    
}

- (void)customCommodSetting {
    
    
}



@end
