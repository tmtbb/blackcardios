//
// Created by yaobanglin on 15/9/1.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "MBProgressHUD.h"


@interface UIViewController (UIViewControllerCategory)<UIAlertViewDelegate>

- (UINavigationBar*) customNavigationBar;



- (void)setMainRootViewController:(NSString *)rootViewController;
@end
