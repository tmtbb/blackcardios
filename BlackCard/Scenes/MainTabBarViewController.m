//
//  MainTabBarViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "WaiterViewController.h"
#import <QYSDK.h>
#define kChatIndex  1
@interface MainTabBarViewController ()<UITabBarControllerDelegate,CurrentUserActionDelegate,QYConversationManagerDelegate>

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [[CurrentUserActionHelper shared] registerDelegate:self];
    // Do any additional setup after loading the view.
    
   
    [self settingTabBarImage];
   
   
   [self unReadCount:[QYSDK sharedSDK].conversationManager.allUnreadCount];
    [[QYSDK sharedSDK].conversationManager setDelegate:self];
   
   

   
}





-(void)unReadCount:(NSInteger)count {
  
   if (count == 0) {
      self.tabBar.items[kChatIndex].badgeValue = nil;
   }else {
      
     self.tabBar.items[kChatIndex].badgeValue = count > 99 ? @"99+" : @(count).stringValue;
   }
   
   
}


- (void)sender:(id)sender didLogin:(id)user {
    
}


- (void)didLogoutSender:(id)sender {
    [[QYSDK sharedSDK]logout:^{
        
    }];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (tabBarController.selectedIndex == kChatIndex) {
        
        WaiterViewController *waiter = ((UINavigationController *)viewController).viewControllers.firstObject;
        if (waiter.isViewLoaded) {
             [waiter goToChatController];
        }

    }
   
    
    
    
}


- (void)settingTabBarImage {
   
   
//   NSArray *selectedImages = @[@"tabbarBalckCardSel",@"tabbarWaiterSel",@"tabbarTribeSel",@"tabbarMySel"];
//   NSArray *images =    @[@"tabbarBalckCardNone",@"tabbarWaiterNone",@"tabbarTribeNon",@"tabbarMySel-1"];
   UITabBar *tabBar = self.tabBar;
   NSMutableArray *imageArr = [NSMutableArray arrayWithArray:
                               @[@[@"tabbarBalckCardSel",@"tabbarBalckCardNone"],
                                 @[@"tabbarWaiterSel",@"tabbarWaiterNone"],
                                 @[@"tabbarMySel",@"tabbarMySel-1"]]];
   if (tabBar.items.count == 4) {
      [imageArr insertObject:@[@"tabbarTribeSel",@"tabbarTribeNon"] atIndex:2];
   }
   
   
   [imageArr enumerateObjectsUsingBlock:^(NSArray    * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      UITabBarItem *item = [tabBar.items objectAtIndex:idx];
      item.selectedImage = [[UIImage imageNamed:obj.firstObject] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
      item.image = [[UIImage imageNamed:obj.lastObject] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   }];
   

    UIColor *titleHighlightedColor = kUIColorWithRGB(0x070707);
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: titleHighlightedColor,NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    titleHighlightedColor = kUIColorWithRGB(0x434343);
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
   
   UITabBarItem *item = [tabBar.items objectAtIndex:kChatIndex];
   item.badgeColor = [UIColor redColor];
    
}


- (void)onUnreadCountChanged:(NSInteger)count{
    
   [self unReadCount:count];
   
    
}


@end
