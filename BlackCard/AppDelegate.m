//
//  AppDelegate.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/19.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "WXPay.h"
#import <QYSDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp: kWXAppID];
    [[QYSDK sharedSDK] registerAppId:KQiYuAppKey appName:KQiYuAppName];
    [self getDeviceKey];
    return YES;
}

- (void)getDeviceKey {
    OEZKeychainItemWrapper* keychain = [[OEZKeychainItemWrapper alloc] initWithIdentifier:kAppDevice_key accessGroup:nil];
   NSString  *device_key = [keychain objectForKey:CFBridgingRelease(kSecAttrAccount)];
    if( [NSString isEmpty:device_key] ) {
        
        [[AppAPIHelper shared].getMyAndUserAPI getRegisterDeviceWithComplete:^(id data) {
            NSString *key = data[@"deviceKey"];
            NSString *keyid = [NSString stringWithFormat:@"%@",data[@"deviceKeyId"]];
            if (key && data[@"deviceKeyId"] != nil ) {
                [keychain setObject:key forKey:CFBridgingRelease(kSecAttrAccount)];
                OEZKeychainItemWrapper* keyidchain = [[OEZKeychainItemWrapper alloc] initWithIdentifier:kAppDevice_keyid accessGroup:nil];
                [keyidchain setObject:keyid forKey:CFBridgingRelease(kSecAttrAccount)];
                
            }
            
        } withError:^(NSError *error) {
            
        
        }];
        
    }
    
    
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    //跳转支付宝钱包进行支付，处理支付结果
//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//        APPLOG(@"results = %@",resultDic);
//    }];
    return  [WXApi handleOpenURL:url delegate:[WXPay shared]];//[[OEZHandleOpenURLHelper shared] handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options {
    //跳转支付宝钱包进行支付，处理支付结果
//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//        APPLOG(@"results = %@",resultDic);
//    }];
    return  [WXApi handleOpenURL:url delegate:[WXPay shared]];//[[OEZHandleOpenURLHelper shared] handleOpenURL:url];
}

#pragma mark handleOpenURL
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [WXApi handleOpenURL:url delegate:[WXPay shared]];
//    //跳转支付宝钱包进行支付，处理支付结果
//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//        APPLOG(@"results = %@",resultDic);
//    }];
    return [[OEZHandleOpenURLHelper shared] handleOpenURL:url];
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

@end
