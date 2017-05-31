//
//  EliteDetailViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "EliteDetailViewController.h"
#import "TribeModel.h"
#import "EliteDetailTopTableViewCell.h"
#import "CardDetailBottomTableViewCell.h"

@interface EliteDetailViewController ()
//@property(strong,nonatomic)UITableView *cardTridDetailTableView;
//@property(strong,nonatomic)NSMutableArray *dataArray;
@end

@implementation EliteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 设置导航条内容
//    [self setupNavgationBar];
//    
//    // 添加底部内容view
//    [self setupBottomContentView];
//    self.view.backgroundColor=kUIColorWithRGB(0xF8F8F8);
}
- (void)didRequest:(NSInteger)pageIndex {
    
//    [[AppAPIHelper shared].getMyAndUserAPI getTribeCommentListWihtPage:pageIndex tribeMessageId:_myModel.id complete:_completeBlock error:_errorBlock];
}

- (void)didRequestComplete:(id)data {
    
    
    
    [super didRequestComplete:data];
    
}
#pragma mark -设置导航条内容
-(void)setupNavgationBar{
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
    topView.backgroundColor=kUIColorWithRGB(0x434343);
    
    //返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 25, 50, 30) ;
    [backBtn setImage:[UIImage imageNamed:@"icon-back"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 40);
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    
    //视图标题
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-40,25,80 , 30)];
    titleLabel.text=_myModel.title;
    titleLabel.font=[UIFont systemFontOfSize:16];
    titleLabel.textColor=kUIColorWithRGB(0xFFFFFF);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    //发布按钮
    UIButton *publishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame=CGRectMake(kMainScreenWidth-50, 25, 40, 30);
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    publishBtn.titleLabel.textColor=kUIColorWithRGB(0xFFFFFF);
    publishBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [publishBtn addTarget:self action:@selector(publishBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:publishBtn];
    
    [self.view addSubview:topView];
    
}
#pragma mark -设置视图内容
-(void)setupBottomContentView {
//    _cardTridDetailTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, kMainScreenHeight-115) style:UITableViewStylePlain];
//    _cardTridDetailTableView.dataSource=self;
//    _cardTridDetailTableView.delegate=self;
//    _cardTridDetailTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    _dataArray=[[NSMutableArray alloc] init];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        for (int i=0; i<10; i++)
//        {
//            CommentListModel *model=[[CommentListModel alloc] init];
//            model.name=@"你好你好你好";
//            model.date=@"2017-05-25";
//            model.time=@"15:30";
//            model.comment=@"说的太好了太好了太好了太好了太好了太好了太好了说的太好了太好了太好了太好了太好了太好了太好了说的太好了太好了太好了太好了太好了太好了太好了说的太好了太好了太好了太好了太好了太好了太好了说的太好了太好了太好了太好了太好了太好了太好了";
//            [_dataArray addObject:model];
//        }
//    });
//    [self.view addSubview:_cardTridDetailTableView];
}
#pragma mark -返回
-(void)backBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        EliteDetailTopTableViewCell *cell=[[EliteDetailTopTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.model=_myModel;
        return cell;
    }else{
        static NSString *CellIdentifier = @"commentCell";
        CardDetailBottomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            cell=[[CardDetailBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.model=_dataArray[indexPath.row-1];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        EliteDetailTopTableViewCell *cell=(EliteDetailTopTableViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }else{
        CardDetailBottomTableViewCell *cell=(CardDetailBottomTableViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed=NO;
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
