//
//  PhotosCollectionViewCell.m
//  BlackCard
//
//  Created by xmm on 2017/6/4.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "PhotosCollectionViewCell.h"

@implementation PhotosCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        self.clipsToBounds = YES;
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        _deleteBtn.frame = CGRectMake(self.frame.size.width - 30, 0, 30, 30);
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
        _deleteBtn.alpha = 0.6;
        [self addSubview:_deleteBtn];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}
@end
