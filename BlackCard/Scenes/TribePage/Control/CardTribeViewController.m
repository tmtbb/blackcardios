//
//  CardTribeViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CardTribeViewController.h"
#import "TribeModel.h"
#import "CardTribeDetailViewController.h"
#import "CommentViewController.h"
#import "PictureShowViewController.h"
#import "CardTribeHandle.h"
#import "MomentViewController.h"
@interface CardTribeViewController ()<CardTribeDetailProcotol,CommentRefresh,MomentViewControllerDelegate>

@end

@implementation CardTribeViewController

- (void)viewDidLoad {

    
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"TribeCardTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TribeCardTableViewCell"];
}


- (void)didRequest:(NSInteger)pageIndex {
    
        [[AppAPIHelper shared].getTribeAPI getTribeListWihtPage:pageIndex circleId:@"0" complete:_completeBlock error:_errorBlock];
}
- (void)didRequestComplete:(id)data {
 
    [super didRequestComplete:data];
}

- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"TribeCardTableViewCell";
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TribeModel *model = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
    WEAKSELF
    [self pushStoryboardViewControllerIdentifier:@"CardTribeDetailViewController" block:^(UIViewController *viewController) {
        [viewController setValue:model forKey:@"myModel"];
        [viewController setValue:indexPath forKey:@"path"];
        [viewController setValue:weakSelf forKey:@"delegate"];
    }];

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
            
            
            [self presentImageBrowseViewController:array index:index andRect:rects];
            
            
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
-(void) presentImageBrowseViewController:(NSArray*) images index:(NSInteger) index andRect:(NSArray *)rects{

    [PictureShowViewController showInControl:self imageArray:images rectArray:rects index:@(index)];

}

#pragma mark -CardTribeCellDelegate
-(void)praise:(NSIndexPath *)path{
    WEAKSELF
    TribeModel *model = [self tableView:self.tableView cellDataForRowAtIndexPath:path];
    
    [CardTribeHandle doPraise:self model:model complete:^{
  [weakSelf.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];

    }];
    
}
-(void)comment:(NSIndexPath *)path{
    TribeModel *model= [self tableView:self.tableView cellDataForRowAtIndexPath:path];
    
    
    [CardTribeHandle doComment:self indexPath:path model:model complete:nil];


}
-(void)more:(NSIndexPath *)path{
    TribeModel *model =  [self tableView:self.tableView cellDataForRowAtIndexPath:path];
    WEAKSELF
    [CardTribeHandle doMore:self model:model block:^(BOOL isDelete, id data, NSError *error) {
        if (error) {
            [weakSelf showError:error];
        }else {
            
            if (isDelete) {
                [weakSelf deleteMyPushWihtPath:path];
                [weakSelf showTips:@"删除成功"];
                
            }else {
                [weakSelf showTips:@"举报成功"];
                
            }
            
        }
        
        
    }];

    
}


#pragma mark -CommentReresh
-(void)commentRefresh:(NSIndexPath *)path data:(id)data{
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark -PraiseRresh


- (void)changeTribeIndexPath:(NSIndexPath *)path model:(TribeModel *)model {
    
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}


- (void)deleteMyPushWihtPath:(NSIndexPath *)path {
    if (path && path.row < _dataArray.count) {
        [_dataArray removeObjectAtIndex:path.row];
        [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];

    }else {
        [self didRequest];
    }
    
}

#pragma mark -MomentViewController Delegate

- (void)pushMomentComplete:(id)data {
    
    [_dataArray insertObject:data atIndex:0];
    [self.tableView reloadData];
    
}



@end
