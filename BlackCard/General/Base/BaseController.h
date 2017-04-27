//
// Created by yaobanglin on 15/9/20.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ControllerDelegate;

@interface BaseController : NSObject
@property(weak, nonatomic) id /*<ControllerDelegate>*/ delegate;

- (instancetype)initWithDelegate:(id)delegate;

+ (instancetype)controllerWithDelegate:(id)delegate;
-(UIViewController *) viewController;
@end

@protocol ControllerDelegate<NSObject>
- (UIViewController *) viewController:(BaseController *)controller;

@end