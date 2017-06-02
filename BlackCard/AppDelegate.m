//
//  AppDelegate.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/19.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "PayManagerHelper.h"
#import <QYSDK.h>
#import <AlipaySDK/AlipaySDK.h>
#import "GuideViewController.h"
@interface AppDelegate ()<GuideViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp: kWXAppID];
    [[QYSDK sharedSDK] registerAppId:KQiYuAppKey appName:KQiYuAppName];
    [[AppAPIHelper shared].getMyAndUserAPI getDeviceKeyWithComplete:nil withError:nil];
    [self registerUserNotificationSettings];
   
    [self guidePageView];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {

    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[PayManagerHelper shared].aliPay handlePayResultDic:resultDic];
            
        }];
    }
    
    
    
    return  [WXApi handleOpenURL:url delegate:[PayManagerHelper shared].wxPay];//[[OEZHandleOpenURLHelper shared] handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[PayManagerHelper shared].aliPay handlePayResultDic:resultDic];
            
            
        }];
    }
    
    
    
    
    return  [WXApi handleOpenURL:url delegate:[PayManagerHelper shared].wxPay];//[[OEZHandleOpenURLHelper shared] handleOpenURL:url];
}

#pragma mark handleOpenURL
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [WXApi handleOpenURL:url delegate:[PayManagerHelper shared].wxPay];
//    //跳转支付宝钱包进行支付，处理支付结果
//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//        APPLOG(@"results = %@",resultDic);
//    }];
    return [[OEZHandleOpenURLHelper shared] handleOpenURL:url];
}



- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}


- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

     [[QYSDK sharedSDK] updateApnsToken:deviceToken];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark RemoteNotification
- (void)registerUserNotificationSettings {
    //消息推送注册
    if ( kSystemVersion < 8.0 ) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge];
    }
    else{
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void) guidePageView {//引导页
    
    if (kMainScreenHeight <= 480) {
        return;
    }
    
    
    NSUserDefaults *fistInstallation = [NSUserDefaults standardUserDefaults];
    NSString *first = [fistInstallation  valueForKey:@"fistInstallation"];
    if (![first isEqualToString:kAppVersion]) {
        GuideViewController  *controller = [[GuideViewController alloc]init];
        controller.delegate= self;
        self.window.rootViewController = controller;
        [fistInstallation setObject:kAppVersion forKey:@"fistInstallation"];
    }
}

- (void)guideViewClose {
    
    NSString *storyboardName = @"Main";
    NSString *identifier = @"LoginViewController";
    UIStoryboard *storyboard= [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    UIViewController *gpVC = [storyboard instantiateViewControllerWithIdentifier:identifier];
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    window.rootViewController = gpVC;
    
}


@end
