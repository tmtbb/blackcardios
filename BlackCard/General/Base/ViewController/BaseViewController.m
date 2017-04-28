//
//  BaseViewController.m
//  douniwan
//
//  Created by yaobanglin on 15/9/1.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+Category.h"
#import "BaseViewController.h"
#import "BaseUserBandLogin.h"
@interface  BaseViewController()<LoginDelegate>


@end
@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:NSStringFromClass([self class])];
}


@end
