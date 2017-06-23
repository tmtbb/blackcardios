//
//  ImagesModel.m
//  magicbean
//
//  Created by baoxun on 16/4/5.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "ImagesModel.h"

@implementation ImagesModel

- (instancetype)initWithUrl:(NSString *)url size:(NSString *)size image:(UIImage *)image {
    self = [super init];
    if (self) {
        self.url = url;
        self.size = size;
        self.image = image;
    }
    
    return self;
}

+ (instancetype)imageWithUrl:(NSString *)url size:(NSString *)size image:(UIImage *)image {
    
    return [ImagesModel imageWithUrl:url size:size image:image];
}
@end
