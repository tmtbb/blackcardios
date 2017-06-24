//
//  TitleView.m
//  magicbean
//
//  Created by cwytm on 16/3/21.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void)imageStateWith:(BOOL)state {
    WEAKSELF
    if (!state) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.titleIV.transform = CGAffineTransformMakeRotation(M_PI/180);
        } completion:nil];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.titleIV.transform = CGAffineTransformMakeRotation(180 * M_PI / 180);
        } completion:nil];
    }
}
@end
