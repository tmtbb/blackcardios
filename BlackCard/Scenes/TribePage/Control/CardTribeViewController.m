//
//  CardTribeViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CardTribeViewController.h"
#import "TribeModel.h"
#import "CardTribeTableViewCell.h"
#import "TribeCardTableViewCell.h"
#import "CardTribeDetailViewController.h"
#import "CommentViewController.h"
#import "ImageBrowseViewController.h"

@interface CardTribeViewController ()<PraiseRresh,CommentRefresh>

@end

@implementation CardTribeViewController

- (void)viewDidLoad {

    
    [super viewDidLoad];

    
}


- (void)didRequest:(NSInteger)pageIndex {
    
        [[AppAPIHelper shared].getTribeAPI getTribeListWihtPage:pageIndex complete:_completeBlock error:_errorBlock];
}
- (void)didRequestComplete:(id)data {
 
    [super didRequestComplete:data];
}

- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"TribeCardTableViewCell";
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CardTribeDetailViewController *cvc=[[CardTribeDetailViewController alloc] init];
    cvc.myModel=_dataArray[indexPath.row];
    cvc.id=[NSString stringWithFormat:@"%ld",indexPath.row];
    cvc.delegate=self;
    cvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:cvc animated:YES];
}


- (void)tableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath didAction:(NSInteger)action data:(id)data {
    
    switch (action) {
        case TribeType_ImageAction:{
           
//            NSDictionary *dic = data;
//            ImageBrowseViewController *imageb = [[ImageBrowseViewController alloc]init];
//            imageb.index = [dic[@"index"] integerValue];
//            imageb.rectArray = dic[@"frames"];
//            TribeModel *model = [self tableView:tableView cellDataForRowAtIndexPath:indexPath];
//            
//            
//            
//            [self presentViewController:imageb animated:YES completion:nil];
            
            
            
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
    TribeModel *model = [self tableView:self.tableView cellDataForRowAtIndexPath:path];
    BOOL isLike = model.isLike;
    [[AppAPIHelper shared].getTribeAPI doTribePraiseTribeMessageId:model.tribeId isLike:isLike complete:^(id data) {
        model.isLike = !isLike;
        NSString *show = @"点赞成功";
        NSInteger count = 1;
        if (isLike) {
            show = @"已取消点赞";
            count = -1;
        }
        model.likeNum += count;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf showTips:show];
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
}
-(void)comment:(NSIndexPath *)path{
    TribeModel *model= [self tableView:self.tableView cellDataForRowAtIndexPath:path];
    
    WEAKSELF
    [self presentViewControllerWithIdentifier:@"CommentViewController" isNavigation:YES block:^(UIViewController *viewController) {
        [viewController setValue:model forKey:@"myModel"];
        [viewController setValue:path forKey:@"path"];
        [viewController setValue:weakSelf forKey:@"delegate"];
        
    }];
    

}
-(void)more:(NSIndexPath *)path{
    CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:@"更多功能" message:nil preferredStyle:UIAlertControllerStyleActionSheet cancelButtonTitle:@"取消" otherButtonTitles:@"举报",nil];
    WEAKSELF
    [alert show:self didClicked:^(UIAlertAction *action, NSInteger buttonIndex) {
        if (action.style != UIAlertActionStyleCancel) {
            TribeModel *model =  [weakSelf tableView:weakSelf.tableView cellDataForRowAtIndexPath:path];
            [weakSelf toReport:model];
        }

    }];
    
}

- (void)toReport:(TribeModel *)model {
    if (model.tribeId  == nil) {
        [self showTips:@"举报内容不存在"];
        return;
    }
    [self showLoader:@"正在举报..."];
    WEAKSELF
    [[AppAPIHelper shared].getTribeAPI toReportMessageId:model.tribeId complete:^(id data) {
        [weakSelf showTips:@"举报成功"];
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
    
}
#pragma mark -CommentReresh
-(void)refresh:(NSIndexPath *)path{
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark -PraiseRresh
-(void)cardTribeRefresh:(NSDictionary *)dict{
    _dataArray[[dict[@"id"] integerValue]]=[dict valueForKey:@"model"];
    [self.tableView reloadData];
}



@end
