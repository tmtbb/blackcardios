//
//  UIView+SimpleFrame.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SimpleFrame)

- (CGFloat)frameX;
- (CGFloat)frameY;

- (CGFloat)frameWidth;

- (CGFloat)frameHeight;

- (void)setFrameX:(CGFloat)framex;
- (void)setFrameY:(CGFloat)framey;
- (void)setFrameWidth:(CGFloat)frameWidth;
- (void)setFrameHeight:(CGFloat)frameheight;
@end
