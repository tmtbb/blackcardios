//
//  UIImage+ALinExtension.m
//  圆形图片
//
//  Created by Mac on 17/4/12.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIImage+ALinExtension.h"

@implementation UIImage (ALinExtension)
+(UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    UIGraphicsBeginImageContext(originImage.size);
    UIBezierPath *path =[UIBezierPath bezierPathWithOvalInRect:CGRectMake( 0, 0, originImage.size.width, originImage.size.height)];
    [path addClip];
    [originImage drawAtPoint:CGPointZero];
    originImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return originImage;
    
}

@end
