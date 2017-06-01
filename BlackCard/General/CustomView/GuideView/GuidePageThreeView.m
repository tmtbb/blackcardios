//
//  GuidePageThreeView.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/31.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "GuidePageThreeView.h"

@implementation GuidePageThreeView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.buttonBottom.constant = 85 * kMainScreenWidth/ 375.0;
    [self choosePage:2];

}


@end
