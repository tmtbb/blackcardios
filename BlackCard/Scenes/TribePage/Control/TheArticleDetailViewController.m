//
//  TheArticleDetailViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TheArticleDetailViewController.h"
#import "TribeModel.h"
#import "WKWebViewToos.h"
#import "TheAriticleCommentViewController.h"
@interface TheArticleDetailViewController ()<TheAriticleCommentProtocol>
@property(strong,nonatomic)TheArticleDetailModel *detailModel;
@property(strong,nonatomic)WKWebViewToos *webToos;
@property(strong,nonatomic)UIView *sectionHeaderView;
@end

@implementation TheArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingWebView];
    self.title = _articleModel.title;
    
    
}

- (void)settingWebView{
    CGRect rect = self.tableView.bounds;
    rect.size.height = kMainScreenHeight - 64;
    _webToos =[[WKWebViewToos alloc]initWithWebViewFrame:rect controller:self];
    _webToos.isOnceLoad = YES;
    self.tableView.tableHeaderView = _webToos.webView;
    _webToos.webView.scrollView.scrollEnabled = NO;
}


- (void)didRequest:(NSInteger)pageIndex {
    if (pageIndex == 1) {
      
        WEAKSELF
       [[AppAPIHelper shared].getTribeAPI getArticleId:_articleModel.articleId complete:^(id data) {
           [weakSelf setDetailModel:data];
           [weakSelf reloadWebView:data];
       } error:_errorBlock];
        
        
        
    }else {
        [[AppAPIHelper shared].getTribeAPI getArticleCommentListId:_articleModel.articleId page:pageIndex complete:_completeBlock error:_errorBlock];
        
    }
    
}

//- (void)setDetailModel:(TheArticleDetailModel *)detailModel {
//    _detailModel = detailModel;
//    [self sectonHeaderSetTitleNumber:detailModel.commentNum];
//    
//}



- (void)reloadWebView:(TheArticleDetailModel *)model; {
    WEAKSELF
    
    
    [_webToos loadRequest:model.detailUrl withReponse:^(WKWebView *webView, id response, NSError *error) {
        webView.frameHeight = [response floatValue];
        weakSelf.tableView.tableHeaderView = webView;
        weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
        
    }];
    
    [[AppAPIHelper shared].getTribeAPI getArticleCommentListId:_articleModel.articleId page:1 complete:_completeBlock    error:_errorBlock];
    
}






- (void)didRequestComplete:(id)data {
   [super didRequestComplete:data];

    
}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return  _dataArray.count > 0 ? 1 : 0;
//}

- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"TheAriticleCommentCell";
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    [self sectonHeaderSetTitleNumber:_detailModel.commentNum];
    return self.sectionHeaderView;
}


- (void)tableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath didAction:(NSInteger)action data:(id)data {
    
       
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CommentListModel *model = [self tableView:self.tableView cellDataForRowAtIndexPath:indexPath];
    
    if ([model.userId isEqualToString:[CurrentUserHelper shared].uid]) {
        
        CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addButtonWithTitle:@"删除" andStyle:UIAlertActionStyleDestructive];
        [alert addCancleButton:@"取消"];
        WEAKSELF
        [alert show:self didClicked:^(UIAlertAction *action, NSInteger buttonIndex) {
            if (action.style == UIAlertActionStyleDestructive) {
                [weakSelf doDeleteComment:model indexPath:indexPath];
            }
        }];
        
    }
    
}

- (void)doDeleteComment:(CommentListModel *)model indexPath:(NSIndexPath *)path{
    __weak NSMutableArray *array = _dataArray;
    WEAKSELF
    [self showLoader:@"评论删除中..."];
    [[AppAPIHelper shared].getTribeAPI doDeleteArticleWithCommentId:model.commentId complete:^(id data) {
        [array removeObjectAtIndex:path.row];
        [weakSelf.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        weakSelf.detailModel.commentNum  -=1;
        [weakSelf sectonHeaderSetTitleNumber:weakSelf.detailModel.commentNum];
        [weakSelf showTips:@"评论删除成功"];
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
    
}

- (UIView *)sectionHeaderView {
    
    if (_sectionHeaderView == nil) {
        
        _sectionHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(23, 18, 100, 30)];
        label.text = @"评论";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = kUIColorWithRGB(0x434343);
        label.tag = 100;
        [label sizeToFit];
        
        CALayer *layer = [[CALayer alloc]init];
        layer.frame = CGRectMake(label.frameX - 1, 38, label.frameWidth + 2, 2);
        layer.backgroundColor = kUIColorWithRGB(0xE3A63F).CGColor;
        [_sectionHeaderView addSubview:label];
        [_sectionHeaderView.layer addSublayer:layer];


    }
    return _sectionHeaderView;
}


- (void)sectonHeaderSetTitleNumber:(NSInteger )number {
    UILabel *label = [self.sectionHeaderView viewWithTag:100];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"评论" attributes:@{NSForegroundColorAttributeName : kUIColorWithRGB(0x434343),NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    [string appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"(%@)",@(number)] attributes:@{NSForegroundColorAttributeName : kUIColorWithRGB(0x434343),NSFontAttributeName : [UIFont systemFontOfSize:12]}]];
    
    label.attributedText = string;
    [label sizeToFit];
    
}



- (IBAction)rightBarAction:(UIBarButtonItem *)sender {
    
    WEAKSELF
    [self pushWithIdentifier:@"TheAriticleCommentViewController" complete:^(UIViewController *controller) {
       
        [controller setValue:weakSelf.detailModel forKey:@"model"];
        [controller setValue:weakSelf forKey:@"delegate"];
    }];
    
}
-(void)theAriticlecommentRefresh:(id)data {
    if (data != nil) {
        [_dataArray addObject:data];
    }
    [self.tableView reloadData];
}


//- (UIView *)showEmptyDataCustomTipsView {
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 40)];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"暂无评论哦";
//    label.font = [UIFont systemFontOfSize:14];
//    label.textColor = kUIColorWithRGB(0xa6a6a6);
//    return label;
//    
//    
//}



@end
