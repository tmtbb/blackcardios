//
//  PictureHandle.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/16.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "PictureHandle.h"
#import <SDImageCache.h>
#define kPictureMaxWidth [UIScreen mainScreen].bounds.size.width
#define kPictureMaxHeight [UIScreen mainScreen].bounds.size.height

#define kPictureScale    (kPictureMaxWidth / (CGFloat)kPictureMaxHeight)
@implementation PictureHandle


+ (NSString *)bigImageUrl:(NSString *)url {
    
    return  [url stringByReplacingOccurrencesOfString:@"_thumb" withString:@""];
}

+(BOOL)hasImage:(NSString *)image {
   return [[SDImageCache sharedImageCache] diskImageExistsWithKey:image];
}

+ (UIImage *)findImgae:(NSString *)image {
    
   return   [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:image];
}



+ (CGSize)imageCalculateSize:(NSString *)size scale:(CGFloat)scale{
    scale = scale <= 0 ? 1 : scale;
    NSArray *array = [size componentsSeparatedByString:@"x"];
    CGFloat width = [array.firstObject floatValue] / scale;
    CGFloat heigth = [array.lastObject floatValue] / scale;
    
    CGSize size1 = CGSizeMake(width, heigth);
    
    return [self imageScreenCalculateSize:size1];
    
    
}


+(CGSize)imageScreenCalculateSize:(CGSize)size {
    CGFloat width = size.width;
    CGFloat heigth = size.height;
    if (width == 0 || width == 0) {
        return CGSizeZero;
    }else {
        
        if (heigth * kMainScreenWidth / width  >= kMainScreenHeight) {
            width =  width * kMainScreenHeight / heigth;
            heigth = kMainScreenHeight;
        }else {
            heigth = heigth * kMainScreenWidth / width;
            width = kMainScreenWidth;
            
        }
        
    }
    
    return CGSizeMake(width, heigth);
    
    
}


+ (CGSize)imageCalculateSize:(CGSize )size{
    
    CGFloat width = size.width;
    CGFloat heigth = size.height;
    if (width == 0 || width == 0) {
        return CGSizeZero;
    }else {
        
        double scale = width / heigth;
        if (scale >= kPictureScale) {
            if (width > kPictureMaxWidth) {
                heigth =   heigth * kPictureMaxWidth / width;
                width = kPictureMaxWidth;
            }
            
            
        }else {
            if (heigth > kPictureMaxHeight) {
                width = width * kPictureMaxHeight / heigth;
                heigth = kPictureMaxHeight;
            }
        }
        
        return  CGSizeMake(width, heigth);
    }

}

@end
