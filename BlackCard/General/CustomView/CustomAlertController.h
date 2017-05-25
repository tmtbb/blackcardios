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


- (void)addCancleButton:(NSString *_Nullable)cancle otherButtonTitles:(NSString *_Nullable)title,... ;



- (void)didClickedButtonWithHandler:(void (^ __nullable)(UIAlertAction * _Nullable action,NSInteger buttonIndex))handler;

@end
