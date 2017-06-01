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
#import "CardTribeDetailViewController.h"
#import "BaseHttpAPI.h"
#import "CommentViewController.h"

@interface CardTribeViewController ()<CardTribeCellDelegate>
//@property(strong,nonatomic)UITableView *cardTribeTabelView;
//@property(strong,nonatomic)NSMutableArray *dataArray;
@end

@implementation CardTribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView registerClass:[CardTribeTableViewCell class] forCellReuseIdentifier:@"CardTribeTableViewCell"];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
- (void)didRequest:(NSInteger)pageIndex {
    
        [[AppAPIHelper shared].getMyAndUserAPI getTribeListWihtPage:pageIndex complete:_completeBlock error:_errorBlock];
}
- (void)didRequestComplete:(id)data {
    [super didRequestComplete:data];
    
}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArray.count;
//}
//- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"=======================");
//    
//    return @"UITableViewCell";
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardTribeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"order"];
    if (!cell) {
        cell=[[CardTribeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"order"];
    }
    cell.model=_dataArray[indexPath.row];
    cell.tag=indexPath.row;
    cell.delegate=self;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CardTribeTableViewCell *cell=(CardTribeTableViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CardTribeDetailViewController *cvc=[[CardTribeDetailViewController alloc] init];
    cvc.myModel=_dataArray[indexPath.row];
    cvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:cvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -CardTribeCellDelegate
-(void)praise:(CardTribeTableViewCell *)cell{
    WEAKSELF
    TribeModel *model=_dataArray[cell.tag];
    [[AppAPIHelper shared].getMyAndUserAPI postTribePraiseTribeMessageId:model.id complete:^(id data) {
        model.likeNum=model.likeNum+1;
        model.isLike=1;
        _dataArray[cell.tag]=model;
//        [_dataArray removeObjectAtIndex:cell.tag];
//        [_dataArray insertObject:model atIndex:cell.tag];
//        cell.praiseLabel.text=[NSString stringWithFormat:@"%d",model.likeNum];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
}
-(void)comment:(CardTribeTableViewCell *)cell{
    TribeModel *model=_dataArray[cell.tag];
    CommentViewController *cvc=[[CommentViewController alloc] init];
    cvc.id=model.id;
    [self presentViewController:cvc animated:YES completion:nil];
}
-(void)deletePraise:(CardTribeTableViewCell *)cell{
    WEAKSELF
    TribeModel *model=_dataArray[cell.tag];
    [[AppAPIHelper shared].getMyAndUserAPI deletePostTribePraiseTribeMessageId:model.id complete:^(id data) {
        model.likeNum=model.likeNum-1;
        model.isLike=0;
        _dataArray[cell.tag]=model;
//        cell.praiseLabel.text=[NSString stringWithFormat:@"%d",model.likeNum];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
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
