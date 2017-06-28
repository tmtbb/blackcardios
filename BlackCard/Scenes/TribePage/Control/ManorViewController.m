//
//  ManorViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ManorViewController.h"
#import "TribeModel.h"
#import "ManorViewCell.h"
#import "ManorCreateTableViewController.h"
@interface ManorViewController ()<ManorCreateControllerProcotol>

@property(strong,nonatomic)ManorModel *model;
@property(strong,nonatomic)UIView *sectionView;
@property (weak, nonatomic) IBOutlet UIButton *applyForManorButton;
@property (weak, nonatomic) IBOutlet UIView *nextPresonRedView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTop;
@end

@implementation ManorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的部落";
    self.tableViewTop.constant = self.navigationController.viewControllers.count > 1 ? 0 : 64;
}

- (void)didRequest {
    
    [[AppAPIHelper shared].getTribeAPI getManorDescribeListComplete:_completeBlock error:_errorBlock];
    
}


- (void)didRequestComplete:(id)data {
    _model = data;
    _nextPresonRedView.hidden = _model.ownTribe.verifyNum == 0;
    
    [_applyForManorButton setTitle:_model.ownTribe.status == 2 ? @"成员申请" : @"部落申请"   forState:UIControlStateNormal ];
    _applyForManorButton.hidden = NO;
    [super didRequestComplete:nil];
    
}


- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"ManorViewCell";
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [((ManorViewCell *)cell) changeLeftColor:indexPath.section == 0 ? kUIColorWithRGB(0x434343) : kUIColorWithRGB(0xE4A63F)];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? _model.userTribes.count : _model.recommendTribes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    switch (section) {

        case 1:{
            CGFloat height = 0.1;
            if (_model) {
               height = _model.userTribes.count > 0 ? (_model.recommendTribes.count > 0 ? 43 : 0.1) : 65;
            }
            
            return   height;
        }
        default:
            return 0.1;
    }
}

- (id)tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section == 0 ? [_model.userTribes objectAtIndex:indexPath.row] : [_model.recommendTribes objectAtIndex:indexPath.row];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 1:
            return  [self sectionViewWihtModel:_model];
        default:
            return nil;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ManorDescribeModel *model = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
    [self pushStoryboardViewControllerIdentifier:@"ManorTirbeViewController" block:^(UIViewController *viewController) {
        [viewController setValue:model.tribeId forKey:@"circleId"];
        
    }];
    
}

- (UIView *)sectionViewWihtModel:(ManorModel *)model {
    UIView *view;
    if (model) {
        
        view =  model.userTribes.count > 0 ?
        (model.recommendTribes.count > 0 ? [self hasManorSectionView] : nil)
        : [self noManorSection];
        
    }
    
    
    return view;
    
    
}



- (UIView *)hasManorSectionView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 43)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 30)];
    label.text = @"推荐的部落如下";
    label.textColor = kUIColorWithRGB(0xa6a6a6);
    label.font = [UIFont systemFontOfSize:14];
    [label sizeToFit];
    [view addSubview:label];
    label.center = view.center;
    label.frameY = view.frameHeight - 10 - label.frameHeight;
    
    CGPoint point = view.center;
    
    CALayer *layerLeft = [[CALayer alloc]init];
    layerLeft.frame = CGRectMake(label.frameX - 10 - 81, point.y - 0.25, 81, 0.5);
    layerLeft.backgroundColor = kUIColorWithRGB(0xd7d7d7).CGColor;
    
    CALayer *layerRight = [[CALayer alloc]init];
    layerRight.frame = CGRectMake(kMainScreenWidth - layerLeft.frame.origin.x - 81, point.y - 0.25, 81, 0.5);
    layerRight.backgroundColor = kUIColorWithRGB(0xd7d7d7).CGColor;
    
    [view addSubview:label];
    [view.layer addSublayer:layerLeft];
    [view.layer addSublayer:layerRight];
    return view;
}

- (UIView *)noManorSection {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 55)];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, kMainScreenWidth - 24, 45)];
    label.backgroundColor = kUIColorWithRGB(0xffffff);
    label.textColor = kUIColorWithRGB(0xa6a6a6);
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 3.0;
    
    label.text = @"您还没有加入部落！下面是推荐的部落";
    [view addSubview:label];
    return view;
    
}
- (IBAction)buttonApplyForManorAction:(UIButton *)sender {
    WEAKSELF
    switch (_model.ownTribe.status) {
        case 0:
            [self pushStoryboardViewControllerIdentifier:@"ManorCreateTableViewController" block:^(UIViewController *viewController) {
                [viewController setValue:weakSelf forKey:@"delegate"];
            }];
            break;
        case 1:{
            [self showTips:@"部落正在申请中"];
        }
            break;
        case 2:{
            _nextPresonRedView.hidden = YES;
            [self pushStoryboardViewControllerIdentifier:@"ManorMembersViewController" block:^(UIViewController *viewController) {
                [viewController setValue:weakSelf.model.ownTribe.tribeId forKey:@"circleId"];
                [viewController setValue:@"部落申请" forKey:@"title"];
                
            }];
            
        }
            break;
    }
    
    
  
}

- (void)manorCreateSuccess:(id)data {
    
    _model.ownTribe.status = 1;
    [self didRequest];
    
}

@end
