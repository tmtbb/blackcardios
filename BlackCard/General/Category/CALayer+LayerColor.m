//
//  CALayer+LayerColor.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CALayer+LayerColor.h"

@implementation CALayer (LayerColor)

- (void)setBorderRGBColor:(UIColor *)borderColor {
   self.borderColor = borderColor.CGColor;

}
@end
