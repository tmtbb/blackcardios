//
//  MyNavigationController.h
//  douniwan
//
//  Created by yaobanglin on 15/9/1.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UINavigationController (UINavigationControllerCategory)
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item;
@end
@interface AppNavigationController : UINavigationController
+ (void)appearance;
@end
