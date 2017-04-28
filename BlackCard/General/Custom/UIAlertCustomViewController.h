//
//  UIAlertCustomViewController.h
//  mgame648
//
//  Created by yaowang on 16/7/12.
//  Copyright © 2016年 ywwl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIAlertCustomViewAnimationType) {
    UIAlertCustomViewAnimationTypeDown = 0,
    UIAlertCustomViewAnimationTypeUp = UIAlertCustomViewAnimationTypeDown + 1,
    UIAlertCustomViewAnimationTypeLeft = UIAlertCustomViewAnimationTypeUp + 1,
    UIAlertCustomViewAnimationTypeRight = UIAlertCustomViewAnimationTypeLeft + 1
};
@class UIAlertCustomViewController;

typedef void (^UIAlertCustomViewControllerBlock)(UIAlertCustomViewController* controller,NSInteger action , id data);

@protocol UIAlertCustomViewControllerDelegate <NSObject>

- (void)alertCustomViewController:(UIAlertCustomViewController*)alertCustomViewController didAction:(NSInteger) action data:(id) data;
@end

@interface UIAlertCustomViewController : UIViewController<OEZViewActionProtocol>
@property (weak, nonatomic) id/*<UIAlertCustomViewControllerDelegate>*/  delegate;
@property (strong,nonatomic) UIAlertCustomViewControllerBlock block;
@property (strong,nonatomic) UIView *customView;
@property (assign,nonatomic) CGFloat animationDelay;
@property (assign,nonatomic) BOOL isModal;
@property (assign,nonatomic) UIAlertCustomViewAnimationType showAnimationType;
@property (assign,nonatomic) UIAlertCustomViewAnimationType hideAnimationType;
- (instancetype)initCustomView:(UIView*)customView;
- (instancetype)initCustomView:(UIView*)customView animationType:(UIAlertCustomViewAnimationType) animationType animationDelay:(CGFloat) animationDelay;
- (instancetype)initCustomView:(UIView*)customView showAnimationType:(UIAlertCustomViewAnimationType) showAnimationType
                hideAnimationType:(UIAlertCustomViewAnimationType) hideAnimationType
                animationDelay:(CGFloat) animationDelay;
- (void)show;
- (void)show:(UIAlertCustomViewControllerBlock) block;
- (void)showAnimation;
- (void)hideAnimation;
@end
