//
//  EliteLifeTableViewCell.m
//  BlackCard
//
//  Created by xmm on 2017/5/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TheArticleTableViewCell.h"
#import "TribeModel.h"
#define kMaxDetailHeight  (kFontHeigt(14) * 3)

@implementation TheArticleTableViewCell

- (void)update:(TheArticleModel *)data {
    self.titleNameLabel.text = data.title;
    self.dateLabel.text = data.formatCreateTime;
    self.detailLabel.text = data.summary;
    
    if ([NSString isEmpty:data.coverUrl] ) {
        self.imageTopToLabelCenter.constant = 5.5;
        self.imageLabel.hidden = YES;
    }else {
        [self.imageLabel sd_setImageWithURL:[NSURL URLWithString:data.coverUrl]];
        self.imageLabel.hidden = NO;
        self.imageTopToLabelCenter.constant = 20.5;

    }
    
}




+ (CGFloat)calculateHeightWithData:(TheArticleModel *)data {
    if (![data hasHeight]) {
        CGFloat imageHeight = [NSString isEmpty:data.coverUrl] ? 5.5 : (kMainScreenWidth - 48) / 2.0 + 20.5;
        CGSize size = BoundIngRectWithText(data.summary, CGSizeMake(kMainScreenWidth - 48, kMaxDetailHeight), 14);
        CGFloat detailHeight = size.height + 1 + 26;
        detailHeight = [NSString isEmpty:data.summary] ? 26 : detailHeight;
        
        [ data setHeigth:43.5 + imageHeight + 45  +  detailHeight + 20];
    }

    return data.modelHeight;
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
    self.showView.backgroundColor =  highlighted ? kUIColorWithRGB(0xd7d7d7) : kUIColorWithRGB(0xffffff);
    
}

@end
