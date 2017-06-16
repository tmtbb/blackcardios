//
//  CEOThinkingViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CEOThinkingViewController.h"
#import "TribeModel.h"
#import "EliteLifeTableViewCell.h"
@interface CEOThinkingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *ceoTableView;
@property(strong,nonatomic)NSMutableArray *dataArray;
@end

@implementation CEOThinkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kAppBackgroundColor;
    _ceoTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 64, kMainScreenWidth, self.view.frame.size.height-123) style:UITableViewStylePlain];
    _ceoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _ceoTableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_ceoTableView];
    
    _dataArray=[[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        EliteLifeModel *model=[[EliteLifeModel alloc] init];
        model.title=@"大王";
        model.date=@"05-16";
        model.time=@"18:18";
        model.article=@"大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀你好";
        [_dataArray addObject:model];
        
    }
    _ceoTableView.dataSource=self;
    _ceoTableView.delegate=self;
}
#pragma mark -UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EliteLifeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"elite"];
    if (!cell) {
        cell=[[EliteLifeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"elite"];
        cell.model=_dataArray[indexPath.row];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    EliteLifeTableViewCell *cell=(EliteLifeTableViewCell*)[self tableView:_ceoTableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
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
