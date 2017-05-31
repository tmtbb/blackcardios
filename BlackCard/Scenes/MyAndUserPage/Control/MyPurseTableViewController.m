//
//  MyPurseTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "MyPurseTableViewController.h"

@interface MyPurseTableViewController ()<UIActionSheetDelegate,CurrentUserActionDelegate>
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property(nonatomic)double currentMoney;
@end

@implementation MyPurseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包";
    [[CurrentUserActionHelper shared] registerDelegate:self];
}

- (void)dealloc {
    [[CurrentUserActionHelper shared] removeDelegate:self];
}
- (void)didRequest {
    [[AppAPIHelper shared].getMyAndUserAPI getUserBlanceComplete:_completeBlock error:_errorBlock];
    
}

- (void)didRequestComplete:(id)data {
    [super didRequestComplete:data];
    _currentMoney = [data[@"balance"] doubleValue];
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",_currentMoney];
        
    
}



- (IBAction)moneyDetailbuttonAction:(id)sender {

    [self pushStoryboardViewControllerIdentifier:@"MyPurseDetailTableViewController" block:nil];
}




- (IBAction)rechargeButtonAction:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    [self pushStoryboardViewControllerIdentifier:@"RechargeTableViewController" block:nil];
    sender.userInteractionEnabled = YES;
}

- (void)sender:(id)sender didChangeMoney:(CGFloat)money {
    WEAKSELF
    __weak ErrorBlock errorBlock = _errorBlock;

     [[AppAPIHelper shared].getMyAndUserAPI getUserBlanceComplete:_completeBlock error:^(NSError *error) {
         weakSelf.currentMoney += money;
          weakSelf.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",weakSelf.currentMoney];
         
         errorBlock(error);
     }];
    
}



@end
