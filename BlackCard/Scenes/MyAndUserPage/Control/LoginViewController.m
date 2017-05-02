//
//  LoginViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginTableViewCell.h"
#import "ValidateHelper.h"
#import "UIViewController+Category.h"
@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource,LoginTableViewCellAction>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if ([[CurrentUserHelper shared] isLogin]) {
        WEAKSELF
        [self showLoader:@"登录中..."];
   
        
    [[AppAPIHelper shared].getMyAndUserAPI checkTokenWithComplete:^(id data) {
        [weakSelf hiddenProgress];
        NSString * token = data[@"token"];
        if (![NSString isEmpty:token]) {
            [[CurrentUserHelper shared] saveToken:token];
            [weakSelf setMainRootViewController:@"MainTabBarViewController"];
        }
        
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
        
        
    }
    
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return kMainScreenHeight < 667 ? 568 : kMainScreenHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoginTableViewCell"];
    if ([cell respondsToSelector:@selector(delegate)]) {
        [cell setValue:self forKey:@"delegate"];
    }
    
    return cell;
    
}
- (void)loginTableViewCelldidAction:(NSInteger)action data:(id)data {
    switch (action) {
        case LoginTableViewCellType_Login:{
            
            [self checkPasswordAndAccount:data];
            
        }
            break;
            
        case LoginTableViewCellType_Register: {
            [self presentStoryboardViewControllerIdentifier:@"RegisterTableViewController" isNavigation:YES block:nil];
            
          
            
            
        }
            
            break;
        case LoginTableViewCellType_ReplacePassword: {
            [self presentStoryboardViewControllerIdentifier:@"ResetPasswordTableViewController" isNavigation:YES block:nil];

            
        }
            
            break;
    }
    
    
}


- (void)checkPasswordAndAccount:(NSArray *)array {
    NSString *account = array.firstObject;
    NSString *password = array.lastObject;
    NSError *error = nil;
    if (![[ValidateHelper shared]checkUserPhone:account error:&error]) {
        [self showError:error];
        return;
    }
    if (![[ValidateHelper shared] checkUserPass:password error:&error]) {
        [self showError:error];
        return;
    }
    
    
    [self loginWihtAccount:account password:password];
    
    
}



- (void)loginWihtAccount:(NSString *)account password:(NSString *)password {
    WEAKSELF
    
    [self showLoader:@"登录中..."];
    [[AppAPIHelper shared].getMyAndUserAPI loginUserName:account password:password complete:^(id data) {
        NSString *token = data[@"token"];
        [[AppAPIHelper shared].getMyAndUserAPI getUserInfoWithToken:token complete:^(MyAndUserModel *userInfo) {
            [weakSelf hiddenProgress];
            userInfo.token = token;
            [[CurrentUserHelper shared] login:userInfo];
            

             [weakSelf setMainRootViewController:@"MainTabBarViewController"];
            
        } error:^(NSError *error) {
            [weakSelf showError:error];
        }];
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
    
    
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
