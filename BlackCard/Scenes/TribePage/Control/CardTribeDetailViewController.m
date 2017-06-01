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

@interface CardTribeDetailViewController ()
@property(strong,nonatomic)CardTribeDetailTabelViewController *cardTridDetailTableView;
@property(strong,nonatomic)NSMutableArray *dataArray;
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
    self.view.backgroundColor=kUIColorWithRGB(0xF8F8F8);
    
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
    CGRect frame=_cardTridDetailTableView.view.frame;
    frame.size.height=frame.size.height-120;
    _cardTridDetailTableView.myModel=_myModel;
    _cardTridDetailTableView.view.frame=frame;
    [myTableView addSubview:_cardTridDetailTableView.view];
//    _cardTridDetailTableView.dataSource=self;
//    _cardTridDetailTableView.delegate=self;
//    _cardTridDetailTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _dataArray=[[NSMutableArray alloc] init];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    for (int i=0; i<10; i++)
//    {
//        CommentListModel *model=[[CommentListModel alloc] init];
//        model.name=@"你好你好你好";
//        model.date=@"2017-05-25";
//        model.time=@"15:30";
//        model.comment=@"说的太好了太好了太好了太好了太好了太好了太好了说的太好了太好了太好了太好了太好了太好了太好了说的太好了太好了太好了太好了太好了太好了太好了说的太好了太好了太好了太好了太好了太好了太好了说的太好了太好了太好了太好了太好了太好了太好了";
//        [_dataArray addObject:model];
//    }
//    });
//    [self.view addSubview:_cardTridDetailTableView];
}
#pragma mark -设置底部图
-(void)setupBottomContentView{
    UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight-50, kMainScreenWidth, 50)];
    bottomView.backgroundColor=kUIColorWithRGB(0xD7D7D7);
//    bottomView.backgroundColor=[UIColor whiteColor];
    
    //底部点赞按钮
    UIButton *bottomPraiseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    bottomPraiseBtn.frame=CGRectMake(0, 0, kMainScreenWidth/2, 50);
    [bottomPraiseBtn setImage:[UIImage imageNamed:@"bottomPraise"] forState:UIControlStateNormal];
    bottomPraiseBtn.imageEdgeInsets=UIEdgeInsetsMake(15, kMainScreenWidth/4-20, 15, kMainScreenWidth/4);
    [bottomPraiseBtn setTitle:@"赞" forState:UIControlStateNormal];
    bottomPraiseBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [bottomPraiseBtn setTitleColor:kUIColorWithRGB(0x434343) forState:UIControlStateNormal];
    bottomPraiseBtn.titleEdgeInsets=UIEdgeInsetsMake(15, kMainScreenWidth/4-10, 15, kMainScreenWidth/4-25);
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
    CommentViewController *cvc=[[CommentViewController alloc] init];
    cvc.id=_myModel.id;
    [self presentViewController:cvc animated:YES completion:nil];
    
}
-(void)bottomPraiseBtnClicked:(UIButton *)sender {
    WEAKSELF
    TribeModel *model=_myModel;
    [[AppAPIHelper shared].getMyAndUserAPI postTribePraiseTribeMessageId:model.id complete:^(id data) {
        model.likeNum=model.likeNum+1;
        model.isLike=1;
        _myModel=model;
        [sender removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [sender addTarget:self action:@selector(deleteBottomPraiseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_cardTridDetailTableView.tableView reloadData];
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
}
-(void)deleteBottomPraiseBtnClicked:(UIButton *)sender{
    WEAKSELF
    TribeModel *model=_myModel;
    [[AppAPIHelper shared].getMyAndUserAPI deletePostTribePraiseTribeMessageId:model.id complete:^(id data) {
        model.likeNum=model.likeNum-1;
        _myModel=model;
        model.isLike=0;
        [sender removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [sender addTarget:self action:@selector(bottomPraiseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_cardTridDetailTableView.tableView reloadData];
//        CardDetailTopTableViewCell *cell=[self.view viewWithTag:1];
//        cell.praiseLabel.text=[NSString stringWithFormat:@"%d",model.likeNum];
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
