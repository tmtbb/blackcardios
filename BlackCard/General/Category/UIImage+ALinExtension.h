//
//  UIImage+ALinExtension.h
//  圆形图片
//
//  Created by Mac on 17/4/12.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ALinExtension)
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
