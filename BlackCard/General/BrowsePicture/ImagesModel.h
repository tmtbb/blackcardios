//
//  ImagesModel.h
//  magicbean
//
//  Created by baoxun on 16/4/5.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

@interface ImagesModel : OEZModel
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *size;
@property(nonatomic,strong)UIImage *image;


+(instancetype)imageWithUrl:(NSString *)url size:(NSString *)size image:(UIImage *)image;

@end
