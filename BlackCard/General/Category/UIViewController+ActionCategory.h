//
// Created by yaobanglin on 15/9/8.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAlertCustomViewController.h"
@interface UIViewController (UIViewControllerActionCategory)

- (void)pushViewControllerWithIdentifier:(NSString *)identifier block:(void (^)(UIViewController *viewController))block;
- (void)presentViewControllerWithIdentifier:(NSString*)  identifier  isNavigation:(BOOL) isNavigation block:(void(^)(UIViewController* viewController)) block;
- (void)presentStoreStoryboardViewControllerIdentifier:(NSString *)identifier isNavigation:(BOOL)isNavigation block:(void (^)(UIViewController * viewController))block;

- (void)pushViewControllerWithIdentifier:(NSString *)identifier animated:(BOOL)animated block:(void (^)(UIViewController *viewController))block;

- (void)presentLoginViewController:(void(^)(UIViewController* viewController)) block;

- (void)presentRegisteredViewController:(void(^)(UIViewController* viewController)) block;

- (void)pushViewControllerWithStoryboard:(NSString *)storyBoardName Identifier:(NSString *)identifier block:(void (^)(UIViewController * viewController))block;
- (void)pushViewControllerWithStoryboard:(NSString *)storyBoardName Identifier:(NSString *)identifier  animated:(BOOL)animated block:(void (^)(UIViewController * viewController))block ;
- (void)pushViewControllerWithStoryboard:(NSString *)storyBoardName Identifier:(NSString *)identifier checkLogin:(BOOL)checkLogin block:(void (^)(UIViewController * viewController))block;


- (void)pushMainStoryboardViewControllerIdentifier:(NSString *)identifier  animated:(BOOL)animated block:(void (^)(UIViewController * viewController))block;
- (void)pushMainStoryboardViewControllerIdentifier:(NSString *)identifier  block:(void (^)(UIViewController * viewController))block;
- (void)pushMainStoryboardViewControllerIdentifier:(NSString *)identifier checkLogin:(BOOL)checkLogin block:(void (^)(UIViewController * viewController))block;




- (BOOL)isLogin;

//- (void)showAlertLoginView;
//
//- (void)showUpDataView:(MySettingCheckVersion *)model;

//- (void)upDataCallBack;
//- (BOOL)userIsLoginNeedAlert:(BOOL)needAlert;
//- (void)pushWeiXinInvitationSystemModalView;


@end
