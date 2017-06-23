//
//  MyAndUserTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "MyAndUserTableViewController.h"
#import "MyAndUserModel.h"
#import "UserSetInfoTableViewController.h"
@interface MyAndUserTableViewController ()<UserSetInfoUpdateProcotol>
@property (weak, nonatomic) IBOutlet UIButton *userIconButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userBackImage;
@property (weak, nonatomic) IBOutlet UILabel *userLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *userMoneyLabel;

@end

@implementation MyAndUserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUserSetting];
    
    [self update:[CurrentUserHelper shared].myAndUserModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];;
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)setUserSetting {
    self.userIconButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
}

- (void)update:(MyAndUserModel *)model {
    [self.userIconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.headpic] forState:UIControlStateNormal placeholderImage:kUIImage_DefaultIcon];

    self.userNameLabel.text = model.username;
    self.userLevelLabel.text = model.blackCardName;
    self.userMoneyLabel.text = [NSString stringWithFormat:@"%.2f",model.blackcardCreditline];
        
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 5)];
        
        return  view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return  5;
    }else
        return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 10)];
        
        return  view;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return  10;
    }else
        return 0.1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO ];
    
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 2:
            case 4:{
                [self showTips:@"敬请期待"];                
            }
                break;
            case 1:{
                [self pushStoryboardViewControllerIdentifier:@"ShoppingListLogViewController" block:nil];
            }
                break;
                
            case 3:{
                WEAKSELF
                [self pushStoryboardViewControllerIdentifier:@"UserSetInfoTableViewController" block:^(UIViewController *viewController) {
                    [viewController setValue:weakSelf forKey:@"delegate"];
                }];
            }
                break;
            case 5: {
                
                    [self  presentViewControllerWithIdentifier:@"WebViewController" isNavigation:YES  block:^(UIViewController *viewController) {
                        [viewController setValue:kHttpAPIUrl_aboutMe forKey:@"url"];
                        [viewController setValue:@"关于我们" forKey:@"webTitle"];
                        [viewController setValue:@(YES) forKey:@"needBack"];
                    }];
                
              
     
            }
                
                break;
            
        }
        
    }
    
    
}
- (IBAction)headerButtonAction:(UIButton *)sender {
    WEAKSELF
    [self pushStoryboardViewControllerIdentifier:@"UserSetInfoTableViewController" block:^(UIViewController *viewController) {
        [viewController setValue:weakSelf forKey:@"delegate"];
    }];
    
}

- (void)saveUserInformation:(id )data {
    if (data != nil && [data isKindOfClass:[UIImage class]]) {
        
        [self.userIconButton setBackgroundImage:data forState:UIControlStateNormal];
    }
    
    
//    MyAndUserModel *model = [CurrentUserHelper shared].myAndUserModel;
//    WEAKSELF
//    [[CurrentUserHelper shared] updateWihtToken:model.token update:^(MyAndUserModel *data, CurrentUserHelper *currentUserHelper) {
//        [currentUserHelper upUserModel:data];
//        [weakSelf update:data];
//        
//    } error:nil];
    
    
    
    
    

    
    
}

@end
