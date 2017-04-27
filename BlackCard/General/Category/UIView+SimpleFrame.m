//
//  UIView+SimpleFrame.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "UIView+SimpleFrame.h"

@implementation UIView (SimpleFrame)


- (CGFloat)frameX {
    return self.frame.origin.x;
}

-(CGFloat)frameY {
    return self.frame.origin.y;
}

- (CGFloat)frameWidth {
    return self.frame.size.width;
}

- (CGFloat)frameHeight {
    return self.frame.size.height;
}

- (void)setFrameX:(CGFloat)framex {
    CGRect rect  = self.frame;
    rect.origin.x = framex;
    self.frame = rect;
    
}

- (void)setFrameY:(CGFloat)framey {
    CGRect rect  = self.frame;
    rect.origin.y = framey;
    self.frame = rect;
}


- (void)setFrameWidth:(CGFloat)frameWidth {
    
    CGRect rect  = self.frame;
    rect.size.width = frameWidth;
    self.frame = rect;
}


- (void)setFrameHeight:(CGFloat)frameheight {
    
    CGRect rect  = self.frame;
    rect.size.height = frameheight;
    self.frame = rect;
}
@end
