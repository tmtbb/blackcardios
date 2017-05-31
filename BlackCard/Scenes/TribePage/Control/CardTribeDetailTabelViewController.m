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
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 10;
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
