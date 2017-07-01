//
//  ManorTirbeViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ManorTirbeViewController.h"
#import "TribeModel.h"
#import "MomentViewController.h"
#define kManorHeaderHeight (kMainScreenWidth *0.6)
#define KManorRect CGRectMake(0, 0, kMainScreenWidth, kManorHeaderHeight)
@interface ManorTirbeViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *hearderImageView;
@property (weak, nonatomic) IBOutlet UIView *headerBackView;

@property(strong,nonatomic)ManorInfoModel *infoModel;
@property (weak, nonatomic) IBOutlet UIView *forgeNavigationBar;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomButtom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomButtonBottom;
@property (assign,nonatomic)BOOL isPresent;
@end

@implementation ManorTirbeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self rightButtonSetting];
    _headerView.frameHeight = kManorHeaderHeight;
    self.tableView.tableHeaderView = _headerView;
    
}

- (void)rightButtonSetting {
  CALayer *layer =  [[CALayer alloc]init];
    layer.frame = CGRectMake(17.5, 1, 28, 28);
    layer.backgroundColor = kUIColorWithRGBAlpha(0x000000, 0.9).CGColor;
    layer.masksToBounds = YES;
    layer.cornerRadius = 14;
    [self.rightButton.layer insertSublayer:layer below:self.rightButton.imageView.layer];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   [self.navigationController setNavigationBarHidden:YES animated:NO];
   

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
 


}

- (void)didRequest:(NSInteger)pageIndex {
    if (pageIndex == 1) {
        WEAKSELF
        [[AppAPIHelper shared].getTribeAPI getManorInfoWihtManorId:_circleId complete:^(id data) {
            weakSelf.infoModel = data;
            [weakSelf headerSetting:data];
            [weakSelf postHttp:pageIndex];
        } error:_errorBlock];
    }else {
        [self postHttp:pageIndex];
    }
   
}




- (void)postHttp:(NSInteger)pageIndex {
     [[AppAPIHelper shared].getTribeAPI getTribeListWihtPage:pageIndex circleId:_circleId complete:_completeBlock error:_errorBlock];
    
}

- (void)didRequestComplete:(id)data {
    self.headerView.hidden = NO;
    [self bottomButtonSetting:_infoModel];
    [super didRequestComplete:data];
    
}


- (void)headerSetting:(ManorInfoModel *)info {
    UIImageView *imageV = _hearderImageView;
    [imageV sd_setImageWithURL:[NSURL URLWithString:info.tribeInfo.coverUrl] placeholderImage:[UIImage imageNamed:@"myAndUserBack"]];
    
    
    UILabel *nameLabel = [_headerView viewWithTag:101];
    nameLabel.text = info.tribeInfo.name;
    
    UILabel *detail = [_headerView viewWithTag:102];
    detail.text = [NSString stringWithFormat:@"领域 %@  |  成员 %@",info.tribeInfo.industry,@(info.tribeInfo.memberNum)];
    UILabel *locationLabel = [_headerView viewWithTag:103];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",info.tribeInfo.province,info.tribeInfo.city] attributes:@{NSForegroundColorAttributeName : kUIColorWithRGB(0xfefefe),NSFontAttributeName : [UIFont systemFontOfSize:12]}];
    NSTextAttachment *ment = [[NSTextAttachment alloc]init];
    ment.image = [UIImage imageNamed:@"manorLocation"];
    CGRect rect = CGRectMake(-5, 0, ment.image.size.width, ment.image.size.height);
    ment.bounds = rect;
    [string insertAttributedString:[NSAttributedString attributedStringWithAttachment:ment] atIndex:0];
    locationLabel.attributedText = string;
    
    
    UIButton *joinButton = [_headerView viewWithTag:104];
    
    if (_infoModel.tribeInfo.status == 2) {
        [self joinButtonSetting:joinButton infoModel:info];
    }else joinButton.hidden = YES;
  
    
    
    
   
    
    
}

- (void)bottomButtonSetting:(ManorInfoModel *)info  {
    
    BOOL canNotPush = info.tribeInfo.status == 1 || info.memberInfo.status != 2 ;
    _bottomButtom.hidden = canNotPush;
    _bottomButtonBottom.constant = canNotPush ? -51 : 0;
}


- (void)joinButtonSetting:(UIButton *)joinButton infoModel:(ManorInfoModel *)info  {
    NSString *join = @"加入";
    joinButton.hidden = NO;
    switch (info.memberInfo.status) {
        case 1:{
            join = @"审核中";
            
        }
            break;
        case 2:
            join = @"退出";
            break;
        case 3:
            join = @"已拒绝";
            break;
            
    }
    joinButton.hidden = info.memberInfo.identity;
    joinButton.userInteractionEnabled =  info.memberInfo.status == 0 || info.memberInfo.status == 2;
    [joinButton setTitle:join forState:UIControlStateNormal];
    
    
}
- (IBAction)joinButtonAction:(UIButton *)sender {
    
    BOOL isJoin = _infoModel.memberInfo.status == 0;
    WEAKSELF
    [[AppAPIHelper shared].getTribeAPI doJoinOrOutManorPerson:isJoin manorId:_circleId complete:^(id data) {
        [weakSelf showTips: isJoin ?  @"申请成功,请等待审核" : @"退出成功"];
        
        weakSelf.infoModel.memberInfo.status = isJoin ?  1 : 0;
        [weakSelf headerSetting:weakSelf.infoModel];
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
    
    
}


- (void)tableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath didAction:(NSInteger)action data:(id)data {
    if (_infoModel.memberInfo.identity == 0 && _infoModel.memberInfo.status != 2) {
        
        switch (action) {
            case TribeType_PraiseAction:
            case TribeType_CommentAction:
            case TribeType_MoreAction:{
                [self showTips:@"您尚未加入该部落"];
            }
                break;
            case TribeType_ImageAction:
                _isPresent = YES;
            default:{
                [super tableView:tableView rowAtIndexPath:indexPath didAction:action data:data];
            }
                break;
        }
        
    }else [super tableView:tableView rowAtIndexPath:indexPath didAction:action data:data];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (_infoModel.memberInfo.identity == 1 ||  _infoModel.memberInfo.status == 2) {
        
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (IBAction)memberButtonAction:(UIButton *)sender {
    
    WEAKSELF
    [self pushStoryboardViewControllerIdentifier:@"ManorMembersViewController" block:^(UIViewController *viewController) {
        [viewController setValue:weakSelf.infoModel.tribeInfo.tribeId forKey:@"circleId"];
        [viewController setValue:@"成员列表" forKey:@"title"];
        if (weakSelf.infoModel.memberInfo.identity == 0) {
            [viewController  setValue:@1 forKey:@"isMember"];

        }
        
    }];
    
    
    
}
- (IBAction)pushMomentAction:(UIButton *)sender {
    WEAKSELF
    [self pushWithIdentifier:@"MomentViewController" complete:^(UIViewController *controller) {
        controller.hidesBottomBarWhenPushed = YES;
        [controller setValue:weakSelf forKey:@"delegate"];
        [controller setValue:weakSelf.circleId forKey:@"circleId"];
        
    }];
    
    
    
}
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

        CGPoint point = scrollView.contentOffset;
        [self contentOffset:point];
        [self changeForgeNavigationBarAlpha:point];
        
}



- (void) contentOffset:(CGPoint) contentOffset {
    CGFloat yOffset  = contentOffset.y ;
    if ( yOffset <= -20) {

        CGRect rect = KManorRect;
 
        rect.origin.y = yOffset ;

        rect.size.height = fabs(yOffset) + kManorHeaderHeight;
        rect.size.width = (rect.size.height * 16.0 / 9.0);
        rect.origin.x = (kMainScreenWidth - rect.size.width)/2;
        _hearderImageView.frame = rect;
        _headerBackView.frame = rect;
      
    }
}
- (void)changeForgeNavigationBarAlpha:(CGPoint)point {
    CGFloat yTure = point.y + 104;
    NSInteger zero  = yTure - kManorHeaderHeight;
    NSInteger alpha =  zero > 20 ? 20 : zero;
    alpha = alpha < 0 ? 0 : alpha / 20.0;
    self.forgeNavigationBar.backgroundColor = kUIColorWithRGBAlpha(0x434343, alpha);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



@end
