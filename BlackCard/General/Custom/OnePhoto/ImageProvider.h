//
//  ImageFromIphone.h
//  WanziTG
//
//  Created by TaeYoona on 15/4/9.
//  Copyright (c) 2015年 wanzi. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 主要是将UploadImageCommonVC的内容独立出来.
 * 
 * 选择全景图有问题
 */

@protocol ImageProvider_delegate <NSObject>

@optional
- (void)hasSelectImage:(UIImage *)editedImage;
- (void)desSelectImage;

@end

@interface ImageProvider : NSObject
@property(nonatomic)BOOL isAutoImageFrame;
@property(nonatomic)CGRect editPhotoFrame;


- (void)setImageDelegate:(id)oneDelegate;

/**
 @abstract 使用相册
 */
- (void)selectPhotoFromPhotoLibrary;

/**
 @abstract 使用相机
 */
- (void)selectPhotoFromCamera;

@end
