//
//  UINavigationBar+Category.m
//  mgame648
//
//  Created by yaowang on 15/11/28.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "UINavigationBar+Category.h"

@implementation UINavigationBar (UINavigationBarCategory)
- (void) setBackgroundImageAlpha:(CGFloat)alpha {
    UIImage *backgroundImage = nil;
   if( alpha < 1) {
      backgroundImage = [self imageWithColor: [self.barTintColor colorWithAlphaComponent:alpha]];
   }
//    APPLOG(@"%@",NSStringFromCGRect(self.frame));
   [self setBackgroundImage:backgroundImage
              forBarMetrics:UIBarMetricsDefault];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
