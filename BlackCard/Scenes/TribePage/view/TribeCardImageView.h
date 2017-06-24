//
//  TribeCardImageView.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/13.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
@class TribeMessageImgsModel;
@interface TribeCardImageView : OEZNibView



+ (CGFloat)computeImageHeigth:(NSArray<TribeMessageImgsModel*> *)array;
@end



@interface ImageFillButton : UIButton

@end
