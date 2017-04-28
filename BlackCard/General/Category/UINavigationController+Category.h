//
//  UINavigationBar+Category.h
//  mgame648
//
//  Created by yaowang on 15/11/28.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationController (UINavigationControllerCategory)
- (void)setNavigationBarBackgroundImageAlpha:(CGFloat) alpha;
- (CGFloat)  isNavigationBarBackgroundImageAlpha;
- (void)popToPayRootViewControllerAnimated:(BOOL)animated block:(void(^)(UIViewController * viewController))block;
@end
