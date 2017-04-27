//
//  UINavigationBar+Category.m
//  mgame648
//
//  Created by yaowang on 15/11/28.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "UINavigationBar+Category.h"
#import <objc/runtime.h>
static char *IsNavigationBarBackgroundImageAlphaKey = "IsNavigationBarBackgroundImageAlphaKey";
@implementation UINavigationController (UINavigationControllerCategory)
- (void) setNavigationBarBackgroundImageAlpha:(CGFloat) alpha {
    [self.navigationBar setBackgroundImageAlpha:alpha];
    objc_setAssociatedObject(self, IsNavigationBarBackgroundImageAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)  isNavigationBarBackgroundImageAlpha {
    id obj =  objc_getAssociatedObject(self, IsNavigationBarBackgroundImageAlphaKey);
    if ( obj != nil ) {
        return  [obj floatValue];
    }
    return 1.0f;
}

- (void)popToPayRootViewControllerAnimated:(BOOL)animated block:(void(^)(UIViewController * viewController))block {
#ifdef MGAME648_STORE
    NSArray *viewControllers = self.viewControllers;
    UIViewController *viewController = nil;
    for (NSInteger i = viewControllers.count - 1 ; i >= 0; --i ) {
        viewController = [viewControllers objectAtIndex:i];
        NSString *className = NSStringFromClass([viewController class]);
        if( [className isEqualToString:@"NewGameHomeTableViewController"]
           || [className isEqualToString:@"AllGameTableViewController"]
           || [className isEqualToString:@"OrderManagerViewController"]
           || [className isEqualToString:@"TheFindCustomTableViewController"]
           ) {
            
            [self popToViewController:viewController animated:animated];
            if (block) {
                block(viewController);
            }
            
            break;
        }
    }
    
#else
    [self popToRootViewControllerAnimated:animated];
    if (block) {
        block(self.visibleViewController);
    }
    
#endif
    
    
}


@end
