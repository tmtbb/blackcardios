//
//  CardTribeDetailViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CardTribeDetailViewController.h"
#import "TribeModel.h"
#import "CardDetailTopTableViewCell.h"
#import "CardDetailBottomTableViewCell.h"
#import "CardTribeDetailTabelViewController.h"
#import "CommentViewController.h"

@interface CardTribeDetailViewController ()<sendMymodelDelegate,CommentRefresh>
@property(strong,nonatomic)CardTribeDetailTabelViewController *cardTridDetailTableView;
@end

@implementation CardTribeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条内容
    [self setupNavgationBar];
    //添加tableview
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setupTableView];
//    });
    [self setupTableView];
    // 添加底部内容view
    [self setupBottomContentView];
    self.hidesBottomBarWhenPushed=YES;
    self.view.backgroundColor=kAppBackgroundColor;
    
}

#pragma mark -设置导航条内容
-(void)setupNavgationBar{
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
    topView.backgroundColor=kUIColorWithRGB(0x434343);
    
    //返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 20, 50, 40) ;
    [backBtn setImage:[UIImage imageNamed:@"icon-back"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 40);
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    
    //视图标题
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-40,25,80 , 30)];
    titleLabel.text=@"详情";
    titleLabel.font=[UIFont systemFontOfSize:16];
    titleLabel.textColor=kUIColorWithRGB(0xFFFFFF);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    
    [self.view addSubview:topView];
    
}
#pragma mark -设置tableView
-(void)setupTableView {
    UIView *myTableView=[[UIView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight-115)];
    [self.view addSubview:myTableView];
    _cardTridDetailTableView=[[CardTribeDetailTabelViewController alloc] init];
    _cardTridDetailTableView.delegate=self;
    _cardTridDetailTableView.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    CGRect frame=_cardTridDetailTableView.view.frame;
    frame.size.height=frame.size.height-120;
    _cardTridDetailTableView.myModel=_myModel;
    _cardTridDetailTableView.view.frame=frame;
    [myTableView addSubview:_cardTridDetailTableView.view];

}
#pragma mark -设置底部图
-(void)setupBottomContentView{
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight-50, kMainScreenWidth, 50)];
    bottomView.backgroundColor=kUIColorWithRGB(0xFAFAFA);
    bottomView.layer.borderColor=kUIColorWithRGB(0xD7D7D7).CGColor;
    bottomView.layer.borderWidth=1.0f;
//    bottomView.layer.shadowColor = kUIColorWithRGB(0xD7D7D7).CGColor;
//    bottomView.layer.shadowRadius = 4.f;
    
    //底部点赞按钮
    UIButton *bottomPraiseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    bottomPraiseBtn.frame=CGRectMake(0, 0, kMainScreenWidth/2, 50);
    if (_myModel.isLike==0)
    {
        [bottomPraiseBtn setImage:[UIImage imageNamed:@"bottomPraise"] forState:UIControlStateNormal];
        [bottomPraiseBtn setTitle:@"赞" forState:UIControlStateNormal];
    }else{
        [bottomPraiseBtn setImage:[UIImage imageNamed:@"bottomPraised"] forState:UIControlStateNormal];
        [bottomPraiseBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    
    bottomPraiseBtn.imageEdgeInsets=UIEdgeInsetsMake(15, kMainScreenWidth/4-20, 15, kMainScreenWidth/4);
//    [bottomPraiseBtn setTitle:@"赞" forState:UIControlStateNormal];
    bottomPraiseBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [bottomPraiseBtn setTitleColor:kUIColorWithRGB(0x434343) forState:UIControlStateNormal];
    bottomPraiseBtn.titleEdgeInsets=UIEdgeInsetsMake(15, kMainScreenWidth/4-10, 15, kMainScreenWidth/4-45);
    bottomPraiseBtn.tag=100;
    if (_myModel.isLike==0) {
        [bottomPraiseBtn addTarget:self action:@selector(bottomPraiseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [bottomPraiseBtn addTarget:self action:@selector(deleteBottomPraiseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [bottomView addSubview:bottomPraiseBtn];
    
    //分割线
    UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2, 12, 1, 26)];
    lineLabel.backgroundColor=kUIColorWithRGB(0xF2F2F2);
    [bottomView addSubview:lineLabel];
    [bottomView addSubview:lineLabel];
    
    //底部评论按钮
    UIButton *bottomCommentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    bottomCommentBtn.frame=CGRectMake(kMainScreenWidth/2, 0, kMainScreenWidth/2,50);
    [bottomCommentBtn setImage:[UIImage imageNamed:@"bottomComment"] forState:UIControlStateNormal];
    bottomCommentBtn.imageEdgeInsets=UIEdgeInsetsMake(15, kMainScreenWidth/4-20, 15, kMainScreenWidth/4);
    [bottomCommentBtn setTitle:@"评论" forState:UIControlStateNormal];
    bottomCommentBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [bottomCommentBtn setTitleColor:kUIColorWithRGB(0x434343) forState:UIControlStateNormal];
    bottomCommentBtn.titleEdgeInsets=UIEdgeInsetsMake(15, kMainScreenWidth/4-10, 15, kMainScreenWidth/4-45);
    [bottomCommentBtn addTarget:self action:@selector(bottomCommentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:bottomCommentBtn];
    
    
    [self.view addSubview:bottomView];
    
}
#pragma mark -返回
-(void)backBtnClicked {
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
    [dict setValue:_id forKey:@"id"];
    [dict setValue:_myModel forKey:@"model"];
    if ([_delegate respondsToSelector:@selector(cardTribeRefresh:)])
    {
        [_delegate cardTribeRefresh:dict];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -UITableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _dataArray.count+1;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==0) {
//        CardDetailTopTableViewCell *cell=[[CardDetailTopTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//        cell.model=_myModel;
//        cell.tag=1;
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        return cell;
//    }else{
//        static NSString *CellIdentifier = @"commentCell";
//        CardDetailBottomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        if (!cell)
//        {
//            cell=[[CardDetailBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        }
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        cell.model=_dataArray[indexPath.row-1];
//        return cell;
//    }
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==0) {
//        CardDetailTopTableViewCell *cell=(CardDetailTopTableViewCell*)[self tableView:_cardTridDetailTableView.tableView cellForRowAtIndexPath:indexPath];
//        return cell.frame.size.height;
//    }else{
//        CardDetailBottomTableViewCell *cell=(CardDetailBottomTableViewCell*)[self tableView:_cardTridDetailTableView.tableView cellForRowAtIndexPath:indexPath];
//        return cell.frame.size.height;
//    }
//}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -下部视图点击事件
-(void)bottomCommentBtnClicked {
//    CommentViewController *cvc=[[CommentViewController alloc] init];
//    cvc.myModel=_myModel;
//    cvc.delegate=self;
//    cvc.id=@"0";
//    [self presentViewController:cvc animated:YES completion:nil];
    
}
-(void)bottomPraiseBtnClicked:(UIButton *)sender {
    [self showLoader:@"点赞中"];
    WEAKSELF
//    TribeModel *model=_myModel;
//    [[AppAPIHelper shared].getMyAndUserAPI postTribePraiseTribeMessageId:model.tribeId complete:^(id data) {
//        model.likeNum=model.likeNum+1;
//        model.isLike=1;
//        _myModel=model;
//        [sender setImage:[UIImage imageNamed:@"bottomPraised"] forState:UIControlStateNormal];
//        [sender setTitle:@"取消" forState:UIControlStateNormal];
//        [sender removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
//        [sender addTarget:self action:@selector(deleteBottomPraiseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [_cardTridDetailTableView.tableView reloadData];
//        [weakSelf removeMBProgressHUD];
//        [weakSelf showTips:@"点赞成功"];
//    } error:^(NSError *error) {
//        [weakSelf removeMBProgressHUD];
//        [weakSelf showError:error];
//    }];
}
-(void)deleteBottomPraiseBtnClicked:(UIButton *)sender{
    [self showLoader:@"取消点赞中"];
    WEAKSELF
    TribeModel *model=_myModel;
//    [[AppAPIHelper shared].getMyAndUserAPI deletePostTribePraiseTribeMessageId:model.tribeId complete:^(id data) {
//        model.likeNum=model.likeNum-1;
//        _myModel=model;
//        model.isLike=0;
//        [sender setImage:[UIImage imageNamed:@"bottomPraise"] forState:UIControlStateNormal];
//        [sender setTitle:@"赞" forState:UIControlStateNormal];
//        [sender removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
//        [sender addTarget:self action:@selector(bottomPraiseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [_cardTridDetailTableView.tableView reloadData];
//        [weakSelf removeMBProgressHUD];
//        [weakSelf showTips:@"取消点赞成功"];
////        CardDetailTopTableViewCell *cell=[self.view viewWithTag:1];
////        cell.praiseLabel.text=[NSString stringWithFormat:@"%d",model.likeNum];
//    } error:^(NSError *error) {
//        [weakSelf removeMBProgressHUD];
//        [weakSelf showError:error];
//    }];
}
#pragma mark -sendMymodelDelegate
-(void)sendMyModel:(TribeModel *)model{
    _myModel=model;
    UIButton *btn=[self.view viewWithTag:100];
    if (model.isLike==1) {
        [btn setImage:[UIImage imageNamed:@"bottomPraised"] forState:UIControlStateNormal];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(deleteBottomPraiseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [btn setImage:[UIImage imageNamed:@"bottomPraise"] forState:UIControlStateNormal];
        [btn setTitle:@"赞" forState:UIControlStateNormal];
        [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(bottomPraiseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)pushComment:(TribeModel *)model{
//    CommentViewController *cvc=[[CommentViewController alloc] init];
//    cvc.myModel=model;
//    cvc.id=@"0";
//    cvc.delegate=self;
//    [self presentViewController:cvc animated:YES completion:nil];
}
-(void)refresh:(NSDictionary *)dict{
    _myModel=[dict objectForKey:@"model"];
    [_cardTridDetailTableView didRequest:1];
    [_cardTridDetailTableView.tableView reloadData];
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
