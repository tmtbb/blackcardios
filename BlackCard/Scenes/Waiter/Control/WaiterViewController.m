//
//  WaiterViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "WaiterViewController.h"
#import <QYSDK.h>
#import <QYSessionViewController.h>
#import <QYPOPSessionViewController.h>


@interface WaiterViewController ()
@property(nonatomic)NSInteger isChat;
@end

@implementation WaiterViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    QYSource *source = [[QYSource alloc] init];
    source.title =  @"云巅黑卡";
    source.urlString = @"https://8.163.com/";
    
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = @"管家";
    sessionViewController.source = source;

    sessionViewController.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:sessionViewController animated:YES];
    [[QYSDK sharedSDK] customUIConfig].bottomMargin = 0;
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






- (void)goToChatController {
    
    
    if (self.navigationController.viewControllers.count < 2) {
        
        QYSource *source = [[QYSource alloc] init];
//        source.title =  @"云巅黑卡";
//        source.urlString = @"https://8.163.com/";
        
        QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
        //设置聊天头像
        [[QYSDK sharedSDK] customUIConfig].customerHeadImageUrl = @"http://cnews.chinadaily.com.cn/img/attachement/jpg/site1/20170314/a41f726b573a1a31f26554.jpg";

        
        
        sessionViewController.sessionTitle = @"管家";
        sessionViewController.source = source;
        sessionViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sessionViewController animated:YES];
        [[QYSDK sharedSDK] customUIConfig].bottomMargin = 0;
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
