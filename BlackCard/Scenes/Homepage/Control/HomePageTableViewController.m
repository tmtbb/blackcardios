//
//  HomePageTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "SubviewWithCollectionView.h"
#import "HomePageModel.h"
#import "ShowYourNeedPageView.h"
#import "ChatTools.h"
@interface HomePageTableViewController ()<SubviewWithCollectionViewDelegate ,OEZViewActionProtocol>
@property (weak, nonatomic) IBOutlet SubviewWithCollectionView *privilegeCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *pageCountView;
@property(nonatomic)NSInteger pageCount;
@property(nonatomic)NSInteger chooseCount;
@property(strong,nonatomic)ShowYourNeedPageView *needView;
@property(strong,nonatomic)HomePageModel *waiterModel;
@property(strong,nonatomic)CardListModel *listModel;
@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor whiteColor];
    
    _privilegeCollectionView.myDelegate = self;
    [self setTitleDate];

    
    [self setHeaderNewFrame];
    
    
    
    
}


- (void)didRequest {
    [[AppAPIHelper shared].getHomePageAPI cardListWithComplete:_completeBlock withError:_errorBlock];
    
}

- (void)didRequestComplete:(CardListModel *)data {
    if (![data isKindOfClass:[CardListModel class]]) {
        return;
    }
    [super didRequestComplete:data.privileges];
    
    if (data != nil) {
        [self removeRefreshControl];
    }
    _listModel = data;
    NSInteger levelid = [CurrentUserHelper shared].myAndUserModel.blackCardId;
    [data.privileges enumerateObjectsUsingBlock:^(HomePageModel   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.privilegePowerType.type = @(levelid);
    }];
    
    [self pageRemoveFromView:_pageCount];
    _pageCount =  [_privilegeCollectionView update:data.privileges];
    [self  pageCountViewSetting];
    [self.tableView reloadData];
    

}

- (void)setHeaderNewFrame {
    
    
    CALayer *layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(0, 0, kMainScreenWidth, 20);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.tableView.tableHeaderView.layer addSublayer:layer];
    
    
    self.tableView.tableHeaderView.frameHeight = 261 * (kMainScreenWidth / 375.0) + 20;
    
    
}


- (void)setTitleDate{
    UIFont *font = [UIFont systemFontOfSize:14];
    
    NSMutableAttributedString *baseStr = [[NSMutableAttributedString alloc]initWithString:@"尊贵的" attributes:@{NSForegroundColorAttributeName:kUIColorWithRGB(0x434343),NSFontAttributeName : font}];
    NSAttributedString *level = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",[CurrentUserHelper shared].userBlackCardName] attributes:@{NSForegroundColorAttributeName:kUIColorWithRGB(0xE3A63F),NSFontAttributeName : font}];
    NSAttributedString *name = [[NSAttributedString alloc]initWithString:[CurrentUserHelper shared].userName attributes:@{NSForegroundColorAttributeName:kUIColorWithRGB(0x333333),NSFontAttributeName : font}];
     NSAttributedString *last = [[NSAttributedString alloc]initWithString:@"，您好。" attributes:@{NSForegroundColorAttributeName:kUIColorWithRGB(0x434343),NSFontAttributeName : font}];
    [baseStr appendAttributedString:level];
    [baseStr appendAttributedString:name];
    [baseStr appendAttributedString:last];
    
    _nameLabel.attributedText = baseStr;
    
    
    
}


- (void)pageCountViewSetting {
    
    CGFloat width = _pageCount * 8   + (_pageCount -1)* 1;
    CGFloat  x = (kMainScreenWidth - width) / 2.0;
    CGFloat  y =  (38 - 4) / 2.0;
    for (NSInteger i = 0 ; i < _pageCount; i++) {
        UIImageView *imageView =  [[UIImageView alloc]initWithFrame:CGRectMake(x + i * 9, y, 8, 4)];
        imageView.image = [UIImage imageNamed:@"pageCountPointNone"];
        imageView.tag = 100 + i;
        imageView.contentMode = UIViewContentModeCenter;
        [_pageCountView addSubview:imageView];
    }
    
   UIImageView *image = [_pageCountView viewWithTag:100 + _chooseCount];
    image.image = [UIImage imageNamed:@"pageCountPointChoose"];
    
}

- (void)pageRemoveFromView:(NSInteger)count{
    if (count != 0) {
        
        for (UIView *view  in _pageCountView.subviews) {
            if (view.tag >= 100) {
                [view removeFromSuperview];
            }
        }
       
    }
    
}

- (void)setChoosePageCount:(NSInteger)page {
    if (_chooseCount != page) {
        
        UIImageView *oldImage = [_pageCountView viewWithTag:100 + _chooseCount];
        UIImageView *image = [_pageCountView viewWithTag:100 + page];
        oldImage.image = [UIImage imageNamed:@"pageCountPointNone"];
        image.image = [UIImage imageNamed:@"pageCountPointChoose"];
   
        
        _chooseCount = page;
        
    }
}

- (void)collectionView:(UIView *)collectionView didAction:(NSIndexPath *)action data:(id)data{
    
    if ([self hasThisPrivilege:data]) {
        _waiterModel = data;
        [self showNeedViewWithModel:_waiterModel];
    }
    
    
    
    APPLOG(@"%@",action);
}

- (BOOL)hasThisPrivilege:(HomePageModel *)model {
    NSString *privilegeId = model.privilegePowerType.type.stringValue;
    BOOL isPrivilege = [model.privilegePowers[privilegeId] boolValue];
    if (!isPrivilege ) {
        WEAKSELF
       [_listModel.blackcards enumerateObjectsUsingBlock:^(BlackCardModel   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
           BOOL hasP = [model.privilegePowers[@(obj.blackcardId).stringValue] boolValue];

           if (hasP) {
               NSString *string = [NSString stringWithFormat:@"很抱歉，该特权为%@专属特权，您可通过会籍升级享受此特权",obj.blackcardName];
               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles: nil];
               alert.tintColor = kUIColorWithRGB(0x434343);
               [alert show];
               *stop = YES;
           }
           
       }];
        
        
    }
    
    
    return isPrivilege;
}




- (void)view:(UIView *)view pageIndex:(NSInteger)pageIndex {
    
    [self setChoosePageCount:pageIndex];
}


- (void)view:(UIView *)view didAction:(NSInteger)action data:(id)data {
    switch (action) {
        case ShowYourNeedPageViewAction_Go:{
        

            [ChatTools chatViewControllerWithTitle:_waiterModel.privilegeName present:self];

            [_needView removeFromSuperview];
            
        }
            
            break;
        case ShowYourNeedPageViewAction_Close: {
            _waiterModel = nil;
            [self showNeedViewWithModel:nil];
        }
            break;
    }
    
    
}
- (ShowYourNeedPageView *)needView {
    if (_needView == nil) {
        _needView = [[ShowYourNeedPageView alloc]initWithFrame:self.view.window.bounds];
        _needView.delegate = self;
    }
    return _needView;
    
}


- (void)showNeedViewWithModel:(HomePageModel *)model {
    
    if (model) {
        [self.needView setModel:model];
        [self.view.window addSubview:self.needView];
        
    }else {
        
        [self.needView removeFromSuperview];
    }
    
}






@end
