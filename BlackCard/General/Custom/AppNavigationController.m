//
//  MyNavigationController.m
//  douniwan
//
//  Created by yaobanglin on 15/9/1.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "AppNavigationController.h"
#import "UINavigationBar+Category.h"
@interface AppNavigationController () <UINavigationBarDelegate>
{
    
}
@end

@implementation UINavigationController (UINavigationControllerCategory)
@end


@implementation AppNavigationController



+ (void)appearance
{
//    [[UINavigationBar appearance] setBarTintColor:kUIColorWithRGB(0xe43931)];
//    [[UINavigationBar appearance] setTintColor:kUIColorWithRGB(0x434343)];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
//    [[UINavigationBar appearance] setTranslucent:NO];
//    NSShadow *shadow = [[NSShadow alloc] init];
//    [shadow setShadowColor:[UIColor whiteColor]];
//    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
//                                          NSShadowAttributeName : shadow};
//    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
//    //    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    UIImage *backImage = [UIImage imageNamed:@"back_icon"];
//    [[UINavigationBar appearance] setBackIndicatorImage:backImage];
//    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImage];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                         forBarMetrics:UIBarMetricsDefault];
//    
    
    
    
    [[UINavigationBar appearance] setBarTintColor:kUIColorWithRGB(0x434343)];
    [[UINavigationBar appearance] setTintColor:kUIColorWithRGB(0xffffff)];
    //    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //    NSShadow *shadow = [[NSShadow alloc] init];
    ////    [shadow setShadowColor:[UIColor whiteColor]];
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    UIImage *backImage = [UIImage imageNamed:@"icon-back"];
    [[UINavigationBar appearance] setBackIndicatorImage:backImage];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImage];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-100)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [AppNavigationController appearance];
//    self.interactivePopGestureRecognizer.enabled = NO;
}



- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if ([self.topViewController conformsToProtocol:@protocol(UINavigationBarDelegate)]
            && [self.topViewController respondsToSelector:@selector(navigationBar:shouldPopItem:)]) {
        if( ! [(id <UINavigationBarDelegate>) self.topViewController navigationBar:navigationBar shouldPopItem:item] )
            return NO;
    }
    return [super navigationBar:navigationBar shouldPopItem:item];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
}


@end
