//
//  WaiterViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "WaiterViewController.h"
#import <QYSDK.h>
#import "ChatTools.h"
#import "ValidateHelper.h"

@interface WaiterViewController ()
@property(nonatomic)NSInteger isChat;
@end
static  NSString *OrderReg = @"ydservice\\:\\/\\/app\\.jingyingheika\\.com/service/0/(.+)/pay\\.html";
@implementation WaiterViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
   
    
    
//    QYSource *source = [[QYSource alloc] init];
//    source.title =  @"云巅黑卡iOS";
//    source.urlString = @"https://8.163.com/";
//    
//    
//    [self setQYUserIndfo];

    
    [ChatTools chatViewControllerWithTitle:nil navigation:self.navigationController];
    _isChat = 1;
  
    
    [self qyClickHandle];
}





- (void)viewWillAppear:(BOOL)animated{
    
    if (_isChat == 2) {
     UITabBarController *tab = self.navigationController.tabBarController;
        tab.selectedIndex = 0;
    }else if(_isChat == 1) {
        
        _isChat = 2;
    }
  
    
    
}

//-(void)setQYUserIndfo {
//    MyAndUserModel *model =  [CurrentUserHelper shared].myAndUserModel;
//    QYUserInfo *info = [[QYUserInfo alloc]init];
//    info.userId = model.userId;
//
//    info.data = [NSString stringWithFormat:
//                 @"[{\"key\":\"real_name\", \"value\":\"%@\"},"
//                 "{\"key\":\"mobile_phone\", \"hidden\":true},"
//                 "{\"key\":\"email\", \"hidden\":true},"
//                 "{\"index\":0, \"key\":\"userID\", \"label\":\"用户ID\", \"value\":\"%@\"},"
//                 "{\"index\":1, \"key\":\"blackCardNo\", \"label\":\"黑卡卡号\", \"value\":\"%@\"},"
//                 "{\"index\":2, \"key\":\"blackCard\", \"label\":\"黑卡类型\", \"value\":\"%@\"}]",model.username,model.userId,model.blackCardNo,model.blackCardName];
//    
//    
////    "{\"index\":1, \"key\":\"blackCardNo\", \"label\":\"黑卡卡号\", \"value\":\"%@\"}"
//    
//   //    "{\"index\":0, \"key\":\"userID\", \"label\":\"用户ID\", \"value\":\"%@\"}"
//    
//    
////    "{\"index\":1, \"key\":\"sex\", \"label\":\"性别\", \"value\":\"先生\"},"
////    "{\"index\":5, \"key\":\"reg_date\", \"label\":\"注册日期\", \"value\":\"2015-11-16\"},"
////    
////    
////    "{\"index\":6, \"key\":\"last_login\", \"label\":\"上次登录时间\", \"value\":\"2015-12-22 15:38:54\"}]";
//    [[QYSDK sharedSDK] setUserInfo:info];
//}




- (void)goToChatController {
    
    
    if (self.navigationController.viewControllers.count < 2) {
        
        [ChatTools chatViewControllerWithTitle:nil navigation:self.navigationController];
        _isChat = 2;
    }
   
    
}



- (void)qyClickHandle {
    
    WEAKSELF
    [QYSDK sharedSDK].customActionConfig.linkClickBlock = ^(NSString *linkAddress) {
        
        NSString *orderNum = [[ValidateHelper shared] regularSubStrWithReg:OrderReg useString:linkAddress];
        if (![NSString isEmpty:orderNum]) {
            [weakSelf pushStoryboardViewControllerIdentifier:@"OrderDetailViewController" block:^(UIViewController *viewController) {
                [viewController setValue:orderNum forKey:@"orderNum"];
            }];
        }
    };
    
    
    
}

@end
