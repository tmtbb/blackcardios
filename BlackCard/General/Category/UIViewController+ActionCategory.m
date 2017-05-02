//
// Created by yaobanglin on 15/9/8.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import "UIViewController+ActionCategory.h"
#import "AppNavigationController.h"
#import "CurrentUserHelper.h"
#import "UIAlertCustomViewController.h"
#import "MyAndUserModel.h"
//#import "DiamondModelPopView.h"


typedef NS_ENUM(NSInteger, Type) {
    TYPE = 1,
    URL
};

@implementation UIViewController (UIViewControllerActionCategory)


//- (BOOL)userIsLoginNeedAlert:(BOOL)needAlert {
//    if (![[CurrentUserHelper shared]isLogin]) {
//        if (needAlert)
//            [self alertLoginVC];
//        else
//            [self presentLoginViewController:^(UIViewController *viewController) {
//                
//            }];
//    }
//    return [[CurrentUserHelper shared]isLogin];
//}

//- (void)alertLoginVC {
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您还未登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
//    WEAKSELF
//    [alertView showWithCompleteBlock:^(NSInteger buttonIndex) {
//        if( buttonIndex != alertView.cancelButtonIndex)
//        {
//            [weakSelf presentLoginViewController:^(UIViewController *viewController) {
//                
//            }];
//        }
//        [[CurrentUserHelper shared] logout];
//    }];
//}


- (void)presentViewControllerWithIdentifier:(NSString *)identifier block:(void (^)(UIViewController *viewController))block {
    [self presentViewControllerWithIdentifier:identifier isNavigation:NO block:block];
}

-(void) presentViewControllerWithIdentifier:(NSString*)  identifier  isNavigation:(BOOL) isNavigation block:(void(^)(UIViewController* viewController)) block {
    
    UIViewController *present = self.navigationController;
    if( present == nil)
    {
        present = self;
    }
    UIViewController *viewController = [[NSClassFromString(identifier) alloc]init];
    
    if (block != nil) {
        block(viewController);
    }
    if( isNavigation)
    {
        viewController = [[AppNavigationController alloc] initWithRootViewController:viewController];
    }
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (void) presentStoryboardViewControllerIdentifier:(NSString *)identifier isNavigation:(BOOL)isNavigation block:(void (^)(UIViewController * viewController))block {
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:identifier];
    if (block != nil) {
        block(viewController);
    }
    if(isNavigation)
    {
        viewController = [[AppNavigationController alloc] initWithRootViewController:viewController];
    }
    [self presentViewController:viewController animated:YES completion:nil];
}

//
//- (void)pushViewControllerWithIdentifier:(NSString *)identifier block:(void (^)(UIViewController *viewController))block {
//
//    [self pushViewControllerWithIdentifier:identifier animated:YES block:block];
//}
//
//
//- (void)pushViewControllerWithIdentifier:(NSString *)identifier animated:(BOOL)animated block:(void (^)(UIViewController *viewController))block
//{
//    
//    UIViewController *viewController = [self instantiateViewControllerWithIdentifier:identifier storyboard:self.storyboard block:block];
//    if( viewController == nil)
//    {
//        viewController = [self instantiateViewControllerWithIdentifier:identifier storyboard:self.navigationController.storyboard block:block];
//    }
//    [self.navigationController pushViewController:viewController animated:animated];
//    
//
//}


- (void)pushStoryboardViewControllerIdentifier:(NSString *)identifier  animated:(BOOL)animated block:(void (^)(UIViewController * viewController))block {
    [self pushViewControllerWithStoryboard:nil Identifier:identifier animated:animated block:block];
}

- (void)pushStoryboardViewControllerIdentifier:(NSString *)identifier  block:(void (^)(UIViewController * viewController))block {
    [self pushStoryboardViewControllerIdentifier:identifier animated:YES block:block];
}

- (void)pushStoryboardViewControllerIdentifier:(NSString *)identifier checkLogin:(BOOL)checkLogin block:(void (^)(UIViewController * viewController))block {
    [self pushViewControllerWithStoryboard:nil Identifier:identifier checkLogin:checkLogin block:block];
}



- (void)pushViewControllerWithStoryboard:(NSString *)storyBoardName Identifier:(NSString *)identifier  animated:(BOOL)animated block:(void (^)(UIViewController * viewController))block {

    
    UIStoryboard * storyBoard ;
    if (storyBoardName)
        storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    else
        storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *controller = [self instantiateViewControllerWithIdentifier:identifier storyboard:storyBoard block:block];
    if( controller ) {
       [self.navigationController setValue:storyBoard forKey:@"storyboard"];
    }
    [self basePushViewController:controller animated:animated];
    
    
}
- (void)pushViewControllerWithStoryboard:(NSString *)storyBoardName Identifier:(NSString *)identifier block:(void (^)(UIViewController * viewController))block {
    [self pushViewControllerWithStoryboard:storyBoardName Identifier:identifier animated:YES block:block];
}

- (void)pushViewControllerWithStoryboard:(NSString *)storyBoardName Identifier:(NSString *)identifier checkLogin:(BOOL)checkLogin block:(void (^)(UIViewController * viewController))block {
    if (!checkLogin ||[self isLogin]) {
        [self pushViewControllerWithStoryboard:storyBoardName Identifier:identifier animated:YES block:block];
    }
    
}

- (UIViewController*) instantiateViewControllerWithIdentifier:(NSString *)identifier storyboard:(UIStoryboard *) storyboard block:(void (^)(UIViewController *viewController))block {
    UIViewController *viewController = nil;
    @try {
        viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
        if (block != nil && viewController != nil ) {
            block(viewController);
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    return viewController;
}
- (void)basePushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if( viewController != nil ) {
        if ( [ self isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController*)self pushViewController:viewController animated:animated];
        }else {
            [self.navigationController pushViewController:viewController animated:animated];
        }
    }
}
- (void)presentLoginViewController:(void(^)(UIViewController* viewController)) block
{
    [self presentStoryboardViewControllerIdentifier:@"LoginTableViewController"  isNavigation:YES block:nil];
}





//是否登陆状态
- (BOOL)isLogin {
    if ([[CurrentUserHelper shared] isLogin]) {
        return YES;
    }
    [self showAlertLoginView];
    return NO;
}

- (void)pushWithIdentifier:(NSString *)identifier complete:(void(^)(UIViewController *controller))complete {
    UIViewController *controller;
    
    @try {
        
        controller =  [[NSClassFromString(identifier) alloc]init];
        
        if (complete != nil && controller != nil ) {
            complete(controller);
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    [self.navigationController pushViewController:controller animated:YES];
}



- (void)showAlertLoginView {
    
    
//    LoginChooseView *loginChooseView = [LoginChooseView loadFromNib];
//    UIAlertCustomViewController *vc = [[UIAlertCustomViewController alloc] initCustomView:loginChooseView animationType:UIAlertCustomViewAnimationTypeDown animationDelay:0.3];
//    vc.delegate = self;
//    loginChooseView.delegate = vc;
//    [vc show];
}





//
//- (void)showUpDataView:(MySettingCheckVersion *)model {
//    UpDataView *upDataView = [UpDataView loadFromNib];
//    [upDataView update:model];
//    UIAlertCustomViewController *vc = [[UIAlertCustomViewController alloc] initCustomView:upDataView animationType:UIAlertCustomViewAnimationTypeDown animationDelay:0.4];
//    vc.isModal  = YES;
//    upDataView.delegate = vc;
//    WEAKSELF
//    [vc show:^(UIAlertCustomViewController *controller, NSInteger action, id data) {
//        if (![NSString isEmpty:data]) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data]];
//            exit(0);
//        }
//        else {
//            if ([weakSelf respondsToSelector:@selector(upDataCallBack)]) {
//                
//                [weakSelf performSelector:@selector(upDataCallBack) withObject:nil afterDelay:0.6];
//            }
//        }
//    }];
//}



- (void)showDiamondModelPopView {
//    DiamondModelPopView *diamondModelPopView = [DiamondModelPopView loadFromNib];
//    UIAlertCustomViewController *vc = [[UIAlertCustomViewController alloc] initCustomView:diamondModelPopView animationType:UIAlertCustomViewAnimationTypeUp animationDelay:0.4];
//    diamondModelPopView.delegate = vc;
//    [vc show];
}






#pragma  mark -LoginDelegate
- (void)didLoginStart {
    [self showLoader:@"登录中..."];
}

- (void)didLoginOk:(id)data {
     [self removeMBProgressHUD];
    [[CurrentUserHelper shared] login:data];
    

}

- (void)didLoginError:(NSError *)err {
    [self showError:err];
}



@end
