//
//  TribeNavigationController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/14.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TribeNavigationController.h"

@interface TribeNavigationController ()

@end

@implementation TribeNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if ([self.topViewController isMemberOfClass:NSClassFromString(@"TribeViewController")]) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}

//- (UIViewController *)childViewControllerForStatusBarStyle {
//    
//    return self.topViewController;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
