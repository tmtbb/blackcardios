//
//  RegisterCollectionViewCell.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "RegisterCollectionViewCell.h"



@implementation RegisterCollectionViewCell
- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.backgroundColor = kUIColorWithRGB(0xf8f8f8);
    self.layer.borderWidth = 1;
    self.layer.borderColor = kUIColorWithRGB(0xd7d7d7).CGColor;
}


@end
