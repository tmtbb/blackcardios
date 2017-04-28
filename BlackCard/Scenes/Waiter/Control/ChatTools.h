//
//  ChatTools.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/28.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QYSDK.h>
@interface ChatTools : NSObject
+(UIViewController *)chatViewControllerWithTitle:(NSString *)title;
+(UIViewController *)chatViewControllerWithTitle:(NSString *)title  navigation:(UINavigationController *)navigation;
+(void)chatViewControllerWithTitle:(NSString *)title  present:(UIViewController *)viewController ;


+(void)setQYUserIndfoWithPrivilegeName:(NSString *)name;

@end
