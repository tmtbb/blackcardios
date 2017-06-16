//
//  ImageBrowseViewCell.h
//  douniwan
//
//  Created by simon on 15/9/23.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
#define IMAGE_ACTION 999
@interface ImageBrowseViewCell : OEZPageViewCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *iScrollView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;


@property (strong, nonatomic)UIImageView *iImageView;


+ (CGRect)calculateIimageViewFrame:(CGSize)size;
//+(UIImageView *)backAnimationWith:(id)data;
+(void)beginAnimationWith:(id)data imageView:(UIImageView *)imageView rect:(void (^)(CGRect rect))myRect;
@end
