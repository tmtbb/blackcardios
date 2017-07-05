//
//  CustomAlertController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertController : UIAlertController

- (void)addButtonTitles:(NSString *_Nullable)title,...;

- (void)addCancleButton:(NSString *_Nullable)title;
- (void)addButtonWithTitle:(NSString *_Nonnull)title andStyle:(UIAlertActionStyle)style;

- (void)addCancleButton:(NSString *_Nullable)cancle otherButtonTitles:(NSString *_Nullable)title,... ;


+ (instancetype _Nullable )alertControllerWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message preferredStyle:(UIAlertControllerStyle)preferredStyle cancelButtonTitle:(nullable NSString *)cancelButton otherButtonTitles:(nullable NSString *)otherButton, ...;

- (void)didClickedButtonWithHandler:(void (^ __nullable)(UIAlertAction * _Nullable action,NSInteger buttonIndex))handler;

- (void)show:(UIViewController *_Nullable)control didClicked:(void (^ __nullable)(UIAlertAction * _Nullable action,NSInteger buttonIndex))handler;

- (void)show:(UIViewController *_Nullable)control;
@end
