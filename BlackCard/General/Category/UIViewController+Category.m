//
// Created by yaobanglin on 15/9/1.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+Category.h"
//#import "UIAlertView+Block.h"
#import "UINavigationController+Category.h"
#import "UIViewController+ActionCategory.h"
#import "CustomAlertController.h"
//#import "LoginChooseView.h"
//#import "NoServerView.h"
//#import "UIAlertCustomViewController.h"
#define kTipsDefaultDelay 1

@implementation UIViewController (UIViewControllerCategory)

static char *CustomNavigationBarKey = "CustomNavigationBarKey";


- (void) tokenExpired {
    
}

- (void)showError:(NSError *)error {
    NSString *stringError = [[error userInfo] objectForKey:NSLocalizedDescriptionKey];
    
    switch (error.code) {
        case 10002: {
            
            [self logoutWithErrorCode];
            
            
        }
            return;
        case 10005:
        case 10006:
        case 10010:
        case 10011:
        case 10012:
        case 10013:
        case 10014:
        case 10015:
        case 10017:{
            
            [self showTips:stringError afterDelay:1.5];
            
        }
            return;
        case 10020:{
            CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:@"提示" message:@"您尚未设置支付密码,是否立即设置" preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            WEAKSELF
            [alert didClickedButtonWithHandler:^(UIAlertAction * _Nullable action, NSInteger buttonIndex) {
                if (action.style != UIAlertActionStyleCancel) {
                    
                    [weakSelf pushStoryboardViewControllerIdentifier:@"ModifyPayPasswordTableViewController" block:nil];
                }
                
            }];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
            return;
        case 10001:
        case 10003:
        case 10004:{
#ifndef DEBUG
            stringError =  @"服务器异常，请稍后再试";
#endif
        }
            break;
            
        default: {

            stringError = [NSString isEmpty:stringError] ? @"网络不给力，请稍后再试!" : stringError;
            
            
        }
            break;
    }
    
    
    
    [self showTips:stringError afterDelay:1.5];
    
    
   
    
    
    
//    if (error.code == 502) {//服务器维护
//        [self showNoServer];
//        return;
//    }
//    
//    if (error.code == -3) {//用户被锁定
//        [[CurrentUserHelper shared] logout:self];
//    }
//    else if( [self filterError:error] ) {
//       //由filterError内处理
//        return ;
//    }
//#ifndef DEBUG
//    else if(  error.code == -1 ) {
//         stringError = @"服务器异常，请稍后再试";
//    }
//    else if (error.code != 0 &&  error.code != kAppNSErrorCheckDataCode && error.code != kAppNSErrorLoginCode) {
//        stringError = @"网络不给力，请稍后再试";
//    }
//#endif
//    [self showTips:stringError afterDelay:1.5];
}

- (BOOL)filterError:(NSError*) error {
    if( error.code == -1009 //网络受限
       || error.code == -1005 //无网络
       || error.code == -1001 //连接超时
       ) {
        return [self filterNetworkError:error];
    }
    return NO;
}

- (void)logoutWithErrorCode {
    
    [[CurrentUserHelper shared] logout:self];
    [self removeMBProgressHUD];
//    if ( [self respondsToSelector:@selector(tokenExpired)] ) {
//        [self performSelector:@selector(tokenExpired)];
//    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账号在别处登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
    WEAKSELF
    [alertView showWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex != alertView.cancelButtonIndex) {
            //                [self pushMainStoryboardViewControllerIdentifier:@"LoginTableViewController" checkLogin:NO block:nil];
            if (![weakSelf.view.window.rootViewController isMemberOfClass:NSClassFromString(@"LoginViewController")]) {
                [weakSelf setMainRootViewController:@"LoginViewController"];
            }
            
        }
    }];

    
    
    
}


- (BOOL)filterNetworkError:(NSError*) error {
    return NO;
}

- (void)showNoServer {
    
//    NoServerView *serverView = [NoServerView loadFromNib];
//    UIAlertCustomViewController *alert =   [[UIAlertCustomViewController alloc]initCustomView:serverView animationType:UIAlertCustomViewAnimationTypeDown animationDelay:0.5];
//    serverView.delegate = alert;
//    alert.isModal = YES;
//    [alert show:^(UIAlertCustomViewController *controller, NSInteger action, id data) {
//        if (action != 0) {
//            
//        }
//        
//    }];
}

- (UINavigationBar*) customNavigationBar {
    UINavigationBar *navigationBar = objc_getAssociatedObject(self, CustomNavigationBarKey);
    if ( navigationBar == nil
        && [self.navigationController respondsToSelector:@selector(isNavigationBarBackgroundImageAlpha)]
        && [self.navigationController isNavigationBarBackgroundImageAlpha] < 1 ) {
        navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
        [navigationBar setUserInteractionEnabled:NO];
        [navigationBar setBarTintColor:self.navigationController.navigationBar.barTintColor];
        [self.view addSubview:navigationBar];
        objc_setAssociatedObject(self, CustomNavigationBarKey, navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return navigationBar;
}


- (void)setMainRootViewController:(NSString *)rootViewController {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller;
    
    controller = [sb instantiateViewControllerWithIdentifier:rootViewController];
    self.view.window.rootViewController = controller;
    
}




@end
