//
//  UINavigationBar+AtWillBackgroundColor.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "UINavigationBar+AtWillBackgroundColor.h"
#import <objc/runtime.h>
@implementation UINavigationBar (AtWillBackgroundColor)
static char atWillview;

- (UIView *)atWillView {
    
  return   objc_getAssociatedObject(self, &atWillview);
    
}

- (void)setAtWillView:(UIView *)view {
    
    objc_setAssociatedObject(self, &atWillview, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)atWillSetBackgroundColor:(UIColor *)backgroundColor {
    
    if (!self.atWillView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        // insert an overlay into the view hierarchy
        self.atWillView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20.5)];
        self.atWillView.userInteractionEnabled = NO;
        self.atWillView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self insertSubview:self.atWillView atIndex:0];
    }
    self.atWillView.backgroundColor = backgroundColor;
    
    
}
@end
