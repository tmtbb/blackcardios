//
//  CardTribeDetailViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CardTribeDetailViewController.h"
#import "TribeModel.h"
#import "CommentViewController.h"
#import "CardTribeHandle.h"
#import "PictureShowViewController.h"
@interface CardTribeDetailViewController ()<CommentRefresh>
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property(strong,nonatomic)UIView *sectionHeaderView;
@end

@implementation CardTribeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self upPriseButton];
}

- (void)upPriseButton {
        [_praiseButton  setImage:[UIImage imageNamed:_myModel.isLike ? @"bottomPraised" : @"bottomPraise"] forState:UIControlStateNormal];
    
}

- (void)didRequest:(NSInteger)pageIndex {
    
    [[AppAPIHelper shared].getTribeAPI getTribeCommentListWihtPage:pageIndex tribeMessageId:_myModel.circleId complete:_completeBlock error:_errorBlock];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
            
        default:
            return [super tableView:tableView numberOfRowsInSection:section];
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            
           return @"TribeCardDetailHeaderTableViewCell";
            
        default:
           return @"CardDetailBottomTableViewCell";
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 0.1;
            
        default:
            return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return nil;
            
        default:
            return self.sectionHeaderView;
    }
    
}


- (id)tableView:(UITableView *)tableView cellDataForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            
            return _myModel;
            
        default:
            return [super tableView:tableView cellDataForRowAtIndexPath:indexPath];
    }
    
    
}



- (UIView *)sectionHeaderView {
    
    if (_sectionHeaderView == nil) {
        _sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(23, 18, 100, 30)];
        label.text = @"评论";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = kUIColorWithRGB(0x434343);
        [label sizeToFit];
        
        CALayer *layer = [[CALayer alloc]init];
        layer.frame = CGRectMake(label.frameX - 1, 38, label.frameWidth + 2, 2);
        layer.backgroundColor = kUIColorWithRGB(0xE3A63F).CGColor;
        [_sectionHeaderView addSubview:label];
        [_sectionHeaderView.layer addSublayer:layer];
        
    }
    return _sectionHeaderView;
}
- (void)tableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath didAction:(NSInteger)action data:(id)data {
    
    switch (action) {
        case TribeType_ImageAction:{
            
            NSDictionary *dic = data;
            NSInteger index = [dic[@"index"] integerValue];
            NSArray *rects = dic[@"frames"];
            TribeModel *model = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
            NSMutableArray *array = [NSMutableArray array];
            
            
            [model.circleMessageImgs enumerateObjectsUsingBlock:^(TribeMessageImgsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ImagesModel *model = [ImagesModel new];
                model.url = obj.img;
                model.size = obj.size;
                
                
                [array addObject:model];
            }];
            
            
            [PictureShowViewController showInControl:self imageArray:array rectArray:rects index:@(index)];
            
            
        }
            break;
        case TribeType_PraiseAction:{
            [self praise:indexPath];
            
        }
            break;
        case TribeType_CommentAction:
            [self comment:indexPath];
            break;
        case TribeType_MoreAction:
            [self more:indexPath];
            break;
    }
    
}


#pragma mark -CardTribeCellDelegate
-(void)praise:(NSIndexPath *)path{
    WEAKSELF
    
    [CardTribeHandle doPraise:self model:_myModel complete:^{
        [weakSelf.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf upPriseButton];
        [weakSelf changeTribeModel:_myModel];

        
    }];

  
}
-(void)comment:(NSIndexPath *)path{
    
    
    [CardTribeHandle doComment:self indexPath:path model:_myModel complete:nil];

    
}
-(void)more:(NSIndexPath *)path{
    TribeModel *model =  [self tableView:self.tableView cellDataForRowAtIndexPath:path];
    [CardTribeHandle doMore:self model:model];
    
}

- (void)commentRefresh:(NSIndexPath *)path data:(id)data{
    if (data!= nil) {
        [_dataArray addObject:data];
    }
    [self.tableView reloadData];
    
    [self changeTribeModel:_myModel];

    
}
- (IBAction)bottomButtonAction:(UIButton *)sender {
 
    TribeType  type  =  sender == _praiseButton ? TribeType_PraiseAction : TribeType_CommentAction;
    
    [self tableView:self.tableView rowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] didAction:type data:nil];
    
    
}
- (void)changeTribeModel:(TribeModel *)model{
    
    if ([self.delegate respondsToSelector:@selector(changeTribeIndexPath:model:)]) {
        [self.delegate changeTribeIndexPath:_path model:model];
    }
}


@end
