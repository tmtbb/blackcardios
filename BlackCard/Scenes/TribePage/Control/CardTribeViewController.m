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
//    NSInteger pageIndex=1;
//    [[AppAPIHelper shared].getMyAndUserAPI getTribeListWihtPage:pageIndex complete:_completeBlock error:_errorBlock];
//    _cardTribeTabelView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, self.view.frame.size.height-123) style:UITableViewStylePlain];
//    _cardTribeTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    _cardTribeTabelView.showsVerticalScrollIndicator=NO;
//    [self.view addSubview:_cardTribeTabelView];
//    
//    _dataArray=[[NSMutableArray alloc] init];
//    for (int i=0; i<10; i++) {
//        TribeModel *model=[[TribeModel alloc] init];
//        model.nickName=@"大王";
//        model.createTime=10000000;
//        model.message=@"大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀你好";
//        model.likeNum=1000;
//        model.commentNum=800;
//        [_dataArray addObject:model];
//        
//    }
//    _cardTribeTabelView.dataSource=self;
//    _cardTribeTabelView.delegate=self;
}
- (void)didRequest:(NSInteger)pageIndex {
    
    [[AppAPIHelper shared].getMyAndUserAPI getTribeListWihtPage:pageIndex complete:_completeBlock error:_errorBlock];
}

- (void)didRequestComplete:(id)data {
    
    
    
    [super didRequestComplete:data];
    
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArray.count;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardTribeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"order"];
    if (!cell) {
        cell=[[CardTribeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"order"];
        cell.model=_dataArray[indexPath.row];
        cell.tag=indexPath.row;
        cell.delegate=self;
    }
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
