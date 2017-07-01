//
//  TribeCardDetailHeaderTableViewCell.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/19.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TribeCardDetailHeaderTableViewCell.h"
#import "TribeModel.h"
#import "TribeCardImageView.h"
@implementation TribeCardDetailHeaderTableViewCell

+ (CGFloat)calculateHeightWithData:(TribeModel *)data {
    
    if (data) {
        CGFloat imagesHeight = [TribeCardImageView computeImageHeigth:data.circleMessageImgs];
        imagesHeight  = imagesHeight == 0 ? 0 : imagesHeight + 10;
        CGFloat messageHeight = [self detailHeight:data];
        CGFloat height = 62 + 39 + messageHeight + imagesHeight;
        return height ;
    }else {
        return 0;
    }
    
}

+ (CGFloat)detailHeight:(TribeModel *)data {
    NSString *detail = data.message.trim;
    CGFloat messageHeight = 9;
    if ([NSString isEmpty:detail]) {
        messageHeight = 0;
    }else {
        CGSize size = BoundIngRectWithText(detail, CGSizeMake(kMainScreenWidth - 100, MAXFLOAT), 14);
        messageHeight += size.height + 1;
    }
    
    return messageHeight;
}

@end
