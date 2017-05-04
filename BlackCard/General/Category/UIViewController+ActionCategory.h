//
// Created by yaobanglin on 15/9/8.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAlertCustomViewController.h"
@interface UIViewController (UIViewControllerActionCategory)




//present 纯代码contro
- (void)presentViewControllerWithIdentifier:(NSString*)  identifier  isNavigation:(BOOL) isNavigation block:(void(^)(UIViewController* viewController)) block;
- (void)presentViewControllerWithIdentifier:(NSString *)identifier block:(void (^)(UIViewController *viewController))block;
//present  sb控制器
- (void)presentStoryboardViewControllerIdentifier:(NSString *)identifier isNavigation:(BOOL)isNavigation block:(void (^)(UIViewController * viewController))block;




// push 不同的 sb
- (void)pushViewControllerWithStoryboard:(NSString *)storyBoardName Identifier:(NSString *)identifier block:(void (^)(UIViewController * viewController))block;
- (void)pushViewControllerWithStoryboard:(NSString *)storyBoardName Identifier:(NSString *)identifier  animated:(BOOL)animated block:(void (^)(UIViewController * viewController))block ;
- (void)pushViewControllerWithStoryboard:(NSString *)storyBoardName Identifier:(NSString *)identifier checkLogin:(BOOL)checkLogin block:(void (^)(UIViewController * viewController))block;




//- (void)pushViewControllerWithIdentifier:(NSString *)identifier block:(void (^)(UIViewController *viewController))block;
//
//- (void)pushViewControllerWithIdentifier:(NSString *)identifier animated:(BOOL)animated block:(void (^)(UIViewController *viewController))block;


- (void)pushStoryboardViewControllerIdentifier:(NSString *)identifier  animated:(BOOL)animated block:(void (^)(UIViewController * viewController))block;

- (void)pushStoryboardViewControllerIdentifier:(NSString *)identifier  block:(void (^)(UIViewController * viewController))block;
- (void)pushStoryboardViewControllerIdentifier:(NSString *)identifier checkLogin:(BOOL)checkLogin block:(void (^)(UIViewController * viewController))block;



// push 纯代码
- (void)pushWithIdentifier:(NSString *)identifier complete:(void(^)(UIViewController *controller))complete ;


- (BOOL)isLogin;

//- (void)showAlertLoginView;
//
//- (void)showUpDataView:(MySettingCheckVersion *)model;

//- (void)upDataCallBack;
//- (BOOL)userIsLoginNeedAlert:(BOOL)needAlert;
//- (void)pushWeiXinInvitationSystemModalView;


@end
