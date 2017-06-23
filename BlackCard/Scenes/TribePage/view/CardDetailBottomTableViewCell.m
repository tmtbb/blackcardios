//
//  CardDetailBottomTableViewCell.m
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CardDetailBottomTableViewCell.h"
#import "TribeModel.h"

@implementation CardDetailBottomTableViewCell



- (void)update:(CommentListModel *)data {
    
    [self.headerButton  sd_setImageWithURL:[NSURL URLWithString:data.headUrl] forState:UIControlStateNormal placeholderImage:kUIImage_DefaultIcon];
    
    self.nameLabel.text = data.nickName;
    self.dateLabel.text = data.formatCreateTime;
    self.detailLabel.text = data.comment;
    
    
}


+ (CGFloat)calculateHeightWithData:(CommentListModel *)data {
    
    if (!data.hasHeight) {
        CGSize size = BoundIngRectWithText(data.comment, CGSizeMake(kMainScreenWidth - 100, MAXFLOAT), 14);

        [data setHeigth:55 + size.height + 28];
    }
    
    
    return data.modelHeight;
}
@end
