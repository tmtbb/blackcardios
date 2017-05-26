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

@interface CardTribeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *cardTribeTabelView;
@property(strong,nonatomic)NSMutableArray *dataArray;
@end

@implementation CardTribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cardTribeTabelView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, self.view.frame.size.height-123) style:UITableViewStylePlain];
    _cardTribeTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _cardTribeTabelView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_cardTribeTabelView];
    
    _dataArray=[[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        TribeModel *model=[[TribeModel alloc] init];
        model.name=@"大王";
        model.date=@"05-16";
        model.time=@"18:18";
        model.title=@"大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀大家好我是王小琳啊呀你好";
        model.praiseNumber=@"1000";
        model.commentNumber=@"800";
        [_dataArray addObject:model];
        
    }
    _cardTribeTabelView.dataSource=self;
    _cardTribeTabelView.delegate=self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CardTribeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"order"];
    if (!cell) {
        cell=[[CardTribeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"order"];
        cell.model=_dataArray[indexPath.row];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CardTribeTableViewCell *cell=(CardTribeTableViewCell*)[self tableView:_cardTribeTabelView cellForRowAtIndexPath:indexPath];
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
