//
//  PictureShowViewController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/16.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagesModel.h"
@interface PictureShowViewController : UIViewController

- (instancetype)initWithImageArray:(NSArray<ImagesModel *>*)imageArray rectArray:(NSArray<NSString *>*)rectArray index:(NSNumber *)index;



+ (void)showInControl:(UIViewController *)control imageArray:(NSArray<ImagesModel *>*)imageArray rectArray:(NSArray<NSString *>*)rectArray index:(NSNumber *)index;
@end
