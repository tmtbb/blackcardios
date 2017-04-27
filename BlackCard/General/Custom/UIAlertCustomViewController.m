//
//  UIAlertCustomViewController.m
//  mgame648
//
//  Created by yaowang on 16/7/12.
//  Copyright © 2016年 ywwl. All rights reserved.
//

#import "UIAlertCustomViewController.h"

@implementation UIAlertCustomViewController

- (instancetype)initCustomView:(UIView*)customView {
    return [self initCustomView:customView showAnimationType:UIAlertCustomViewAnimationTypeDown hideAnimationType:UIAlertCustomViewAnimationTypeUp animationDelay:0.5];
}

- (instancetype)initCustomView:(UIView*)customView animationType:(UIAlertCustomViewAnimationType) animationType animationDelay:(CGFloat) animationDelay {
    return [self initCustomView:customView showAnimationType:animationType hideAnimationType:animationDelay animationDelay:animationDelay];
}

- (instancetype)initCustomView:(UIView*)customView showAnimationType:(UIAlertCustomViewAnimationType) showAnimationType
             hideAnimationType:(UIAlertCustomViewAnimationType) hideAnimationType
                animationDelay:(CGFloat) animationDelay {
    self = [super init];
    if (self) {
        self.customView = customView;
        self.showAnimationType = showAnimationType;
        self.hideAnimationType = hideAnimationType;
        self.animationDelay = animationDelay;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.view.backgroundColor = kUIColorWithRGBAlpha(0x000000, 0.5);
    if ( !self.isModal ) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
        [tapGestureRecognizer addTarget:self action:@selector(dismissViewControllerAnimated:)];
        [self.view addGestureRecognizer:tapGestureRecognizer];
    }
    [self.customView setCenter:CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2)];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if( ! [self.view.subviews containsObject:self.customView] ) {
        [self.view addSubview:self.customView];
        [self showAnimation];
    }
}

- (void) dismissViewControllerAnimated:(id) action {
    [self hideAnimation];
    [self didAction:0 data:nil];
}

- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion {
    
    [self hideAnimation];
}

- (void)show {
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [rootViewController presentViewController:self animated:NO  completion:nil];
}

- (void)show:(UIAlertCustomViewControllerBlock) block {
    self.block = block;
    [self show];
}

- (void)showAnimation {
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0,0);
    switch (self.showAnimationType) {
        case UIAlertCustomViewAnimationTypeDown:
            transform = CGAffineTransformMakeTranslation(0, -kMainScreenHeight);
            break;
        case UIAlertCustomViewAnimationTypeUp:
            transform = CGAffineTransformMakeTranslation(0, kMainScreenHeight);
            break;
        case UIAlertCustomViewAnimationTypeLeft:
            transform = CGAffineTransformMakeTranslation(-kMainScreenWidth,0);
            break;
        case UIAlertCustomViewAnimationTypeRight:
            transform = CGAffineTransformMakeTranslation(kMainScreenWidth,0);
            break;
    }
    self.customView.transform = transform;
    WEAKSELF
    [UIView animateWithDuration:self.animationDelay animations:^{
        weakSelf.customView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}


- (void)hideAnimation {
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0,0);
    switch (self.hideAnimationType) {
        case UIAlertCustomViewAnimationTypeDown:
            transform = CGAffineTransformMakeTranslation(0, kMainScreenHeight);
            break;
        case UIAlertCustomViewAnimationTypeUp:
            transform = CGAffineTransformMakeTranslation(0, -kMainScreenHeight);
            break;
        case UIAlertCustomViewAnimationTypeLeft:
            transform = CGAffineTransformMakeTranslation(kMainScreenWidth,0);
            break;
        case UIAlertCustomViewAnimationTypeRight:
            transform = CGAffineTransformMakeTranslation(kMainScreenWidth,0);
            break;
    }
    WEAKSELF
    [UIView animateWithDuration:self.animationDelay animations:^{
        weakSelf.customView.transform = transform;
        weakSelf.view.alpha = 0.5;
    } completion:^(BOOL finished) {
        [weakSelf.customView removeFromSuperview];
        weakSelf.customView = nil;
        [super dismissViewControllerAnimated:NO completion:nil];
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didAction:(NSInteger)action data:(id)data {
    if( self.block ) {
        self.block(self,action,data);
    }
    [self.delegate alertCustomViewController:self didAction:action data:data];
}

- (void)view:(UIView *)view didAction:(NSInteger)action data:(id)data {
    [self hideAnimation];
    [self didAction:action data:data];
}


@end
