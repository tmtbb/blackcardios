//
//  ShoppingDetailTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ShoppingDetailTableViewController.h"
#import "PurchaseHistoryModel.h"
@interface ShoppingDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;


@property(strong,nonatomic)PurchaseHistoryModel *model;
@end

@implementation ShoppingDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self settingView];
}

- (void)settingView {
    self.orderTypeLabel.text = _model.tradeGoodsName;
    self.orderNumLabel.text = _model.tradeNo;
    self.orderMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",_model.tradeTotalPrice];
    self.payMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",_model.tradePayPrice];
    
    self.orderTime.text = _model.formatCreateTime;
    
    self.orderStatusLabel.text = @"";
    
}


@end
