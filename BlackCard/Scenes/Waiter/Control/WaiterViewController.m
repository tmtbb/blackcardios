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


@interface WaiterViewController ()
@property(nonatomic)NSInteger isChat;
@end

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

    // Do any additional setup after loading the view.
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
