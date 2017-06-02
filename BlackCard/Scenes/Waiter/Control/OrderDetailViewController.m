//
//  OrderDetailViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "WaiterModel.h"
#import "ChoosePayHandle.h"
@interface OrderDetailViewController ()<ChoosePayHandlePayStatusDelegate>

@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumlabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *myFootView;
@property(nonatomic)CGFloat orderDetailHeight;
@property(strong,nonatomic)WaiterServiceMDetailModel *model;

@property(strong,nonatomic)ChoosePayHandle *handle;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _orderDetailHeight = 45;
    _myFootView.hidden = YES;
    
    
    
    // Do any additional setup after loading the view.
}


- (void)didRequest {

    [[AppAPIHelper shared].getWaiterServiceAPI getWaiterServiceDetailWithServiceNum:_orderNum Complete:_completeBlock withError:_errorBlock];
}

- (void)didRequestComplete:(WaiterServiceMDetailModel *)data {
    
    _model = data;
    [_handle upDate:data];
    [self detailSetting:data];
    
    [super didRequestComplete:data];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _model ? [super numberOfSectionsInTableView:tableView] : 0;
}
- (void)detailSetting:(WaiterServiceMDetailModel *)model {
    self.orderTypeLabel.text = model.serviceName;
    self.orderNumlabel.text = model.serviceNo;
    self.orderDetailLabel.text = model.serviceDetails;
    self.orderMoneyLabel.text =[NSString stringWithFormat:@"¥%.2f",model.serviceAmount];
    self.orderStatusLabel.text = model.serviceStatusTitle;
    self.phoneNumLabel.text = model.serviceUserTel;
    self.orderTimeLabel.text = model.createTime;
    
    CGSize size = BoundIngRectWithText(model.serviceDetails, CGSizeMake(kMainScreenWidth - 140, MAXFLOAT), 14);
    CGFloat fontHeight = kFontHeigt(14);
    CGFloat calculateHeight = 45 - fontHeight + size.height;
    _orderDetailHeight =  calculateHeight > 45 ? calculateHeight : 45;
    
    
    if (model.serviceStatus == 0 ) {
        CGFloat allHeight = kMainScreenHeight -   (45 * 6 + _orderDetailHeight) - 84;
        allHeight = allHeight > 105 ? allHeight : 105;
        _myFootView.frame = CGRectMake(0, 0, kMainScreenWidth, allHeight);
        _myFootView.hidden = NO;

    }else {
        
        _myFootView.hidden = YES;
    }
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return   indexPath.row == 2 ? _orderDetailHeight : 45;
    
}

- (void)choosePayHandleWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data {
    if (payStatus == PayOK) {
        
        _myFootView.hidden = YES;
    }
}

- (IBAction)payButtonAction:(UIButton *)sender {
    
    
    [self.handle handleShow];
}

- (ChoosePayHandle *)handle {
    if (_handle == nil) {
        _handle = [[ChoosePayHandle alloc]initWithController:self andModel:_model];
        _handle.delegate = self;
    }
    return _handle;
}

@end
