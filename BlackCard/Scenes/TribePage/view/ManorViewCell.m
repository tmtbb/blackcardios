//
//  ManorViewCell.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ManorViewCell.h"
#import "TribeModel.h"
@implementation ManorViewCell

- (void)update:(ManorDescribeModel *)data {
    
    
    self.titleViewLabel.text = data.name;
    self.detailLabel.text = data.describe;
    
    
}


+ (CGFloat)calculateHeightWithData:(ManorDescribeModel *)data {
    CGSize size = BoundIngRectWithText(data.describe, CGSizeMake(kMainScreenWidth - 48, MAXFLOAT), 12);
    return 40  +  13 + size.height + 1 + 10 ;
    
}

- (void)changeLeftColor:(UIColor *)color {
    
    self.leftView.backgroundColor = color;
    
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    self.showView.backgroundColor = highlighted ? kUIColorWithRGB(0xd7d7d7) : kUIColorWithRGB(0xffffff);
    
}
@end
