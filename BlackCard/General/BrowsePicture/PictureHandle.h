//
//  PictureHandle.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/16.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PictureHandle : NSObject


+ (NSString *)bigImageUrl:(NSString *)url;
+ (BOOL)hasImage:(NSString *)image;
+ (UIImage *)findImgae:(NSString *)image ;
+ (CGSize)imageCalculateSize:(NSString *)size scale:(CGFloat)scale;
+ (CGSize)imageCalculateSize:(CGSize )size;
+(CGSize)imageScreenCalculateSize:(CGSize)size;
@end
