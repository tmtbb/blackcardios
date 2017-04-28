//
//  MyAndUserTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "MyAndUserTableViewController.h"
#import "MyAndUserModel.h"
@interface MyAndUserTableViewController ()
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
- (void)setUserSetting {
    self.userIconButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
}

- (void)update:(MyAndUserModel *)model {
    [self.userIconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:model.headpic] forState:UIControlStateNormal placeholderImage:nil];
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

@end
