//
//  CardTribeDetailTabelViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/31.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CardTribeDetailTabelViewController.h"
#import "TribeModel.h"
#import "CardDetailTopTableViewCell.h"
#import "CardDetailBottomTableViewCell.h"
#import "CardTribeViewController.h"
#import "CommentViewController.h"
@interface CardTribeDetailTabelViewController ()<CardDetailTopCellDelegate>

@end

@implementation CardTribeDetailTabelViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didRequest:(NSInteger)pageIndex {
    
     [[AppAPIHelper shared].getMyAndUserAPI getTribeCommentListWihtPage:pageIndex tribeMessageId:_myModel.id complete:_completeBlock error:_errorBlock];
}

- (void)didRequestComplete:(id)data {
    
    
    
    [super didRequestComplete:data];
    
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        CardDetailTopTableViewCell *cell=[[CardDetailTopTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        _myIndexPath=indexPath;
        cell.model=_myModel;
        cell.delegate=self;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"commentCell";
        CardDetailBottomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            cell=[[CardDetailBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=_dataArray[indexPath.row-1];
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        CardDetailTopTableViewCell *cell=(CardDetailTopTableViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }else{
        CardDetailBottomTableViewCell *cell=(CardDetailBottomTableViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }

}
#pragma mark -CardDetailTopCellDelegate
-(void)praise:(CardDetailTopTableViewCell *)cell{
    [self showLoader:@"点赞中"];
    WEAKSELF
    TribeModel *model=_myModel;
    [[AppAPIHelper shared].getMyAndUserAPI postTribePraiseTribeMessageId:model.id complete:^(id data) {
        model.likeNum=model.likeNum+1;
         model.isLike=1;
        _myModel=model;
        cell.praiseLabel.text=[NSString stringWithFormat:@"%d",model.likeNum];
        if ([_delegate respondsToSelector:@selector(sendMyModel:)])
        {
            [_delegate sendMyModel:_myModel];
        }
        [weakSelf.tableView reloadData];
        [weakSelf removeMBProgressHUD];
        [weakSelf showTips:@"点赞成功"];
    } error:^(NSError *error) {
        [weakSelf removeMBProgressHUD];
        [weakSelf showError:error];
    }];
}
-(void)comment:(CardDetailTopTableViewCell *)cell{
//    TribeModel *model=_myModel;
//    CommentViewController *cvc=[[CommentViewController alloc] init];
//    cvc.myModel=model;
//    [self presentViewController:cvc animated:YES completion:nil];
    if ([_delegate respondsToSelector:@selector(pushComment:)])
    {
        [_delegate pushComment:_myModel];
    }
}
-(void)deletePraise:(CardDetailTopTableViewCell *)cell{
    [self showLoader:@"取消点赞中"];
    WEAKSELF
    TribeModel *model=_myModel;
    [[AppAPIHelper shared].getMyAndUserAPI deletePostTribePraiseTribeMessageId:model.id complete:^(id data) {
        model.likeNum=model.likeNum-1;
        model.isLike=0;
        _myModel=model;
        cell.praiseLabel.text=[NSString stringWithFormat:@"%d",model.likeNum];
        if ([_delegate respondsToSelector:@selector(sendMyModel:)])
        {
            [_delegate sendMyModel:_myModel];
        }
        [weakSelf.tableView reloadData];
        [weakSelf removeMBProgressHUD];
        [weakSelf showTips:@"取消点赞成功"];
    } error:^(NSError *error) {
        [weakSelf removeMBProgressHUD];
        [weakSelf showError:error];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
