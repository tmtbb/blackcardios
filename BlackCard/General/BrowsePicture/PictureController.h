//
//  PictureController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/16.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesModel.h"

typedef NS_ENUM(NSInteger,PictureControllerType){
    PictureType_Dismiss,
    
    
};

@protocol PictureControllerProcotol <NSObject>

-(void)pictureDidAction:(PictureControllerType )type data:(id)data;

@end
@interface PictureController : UIViewController

@property(nonatomic)NSInteger tag;
@property(weak,nonatomic)id delegate;



- (instancetype)initWithModel:(ImagesModel *)model;
+ (instancetype)pictureWithModel:(ImagesModel *)model;
- (void)imageShow:(ImagesModel *)model;
@end
