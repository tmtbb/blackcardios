//
//  EveryNoneView.m
//  douniwan
//
//  Created by simon on 15/10/19.
//  Copyright © 2015年 yaowang. All rights reserved.
//

#import "EveryNoneView.h"

@implementation EveryNoneView


+(instancetype)everyNoneViewWith:(NSString *)string type:(EveryNoneType)type
{
    EveryNoneView *noneView = [EveryNoneView loadFromNib];
    noneView.titleLabel.text = string;
    CGSize size = CGSizeMake(kMainScreenWidth, MAXFLOAT);
    size = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:noneView.titleLabel.font} context:nil].size;
    
    switch (type) {
        case EveryNoneType_message:{
            noneView.imageIV.image = [UIImage imageNamed:@"everyNone_noMessage_icon"];
            noneView.titleLabel.textColor = kUIColorWithRGB(0x818283);
        }
            break;
        case EveryNoneType_search:{
            noneView.imageIV.image = [UIImage imageNamed:@"everyNone_noSearch_icon"];
            noneView.titleLabel.textColor = kUIColorWithRGB(0xCCCCCC);
        }
            break;
        default:
            break;
    }
    CGSize imageSize = noneView.imageIV.image.size;
    noneView.labelTop.constant = imageSize.height + 12  + 60;
    noneView.frame = CGRectMake(0, 0, kMainScreenWidth, size.height + noneView.labelTop.constant + 10);
 
    return  noneView;
}



@end
