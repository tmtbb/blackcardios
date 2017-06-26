//
//  TheAritickeCommentViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TheAriticleCommentViewController.h"
#import "TribeModel.h"
@interface TheAriticleCommentViewController ()

@property(strong,nonatomic)TheArticleDetailModel *model;
@end

@implementation TheAriticleCommentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
}

- (NSString *)rightBarTitle {
    
    return @"提交";
}

#pragma mark -发布
-(void)publishBtnClicked {
    
    NSString *str = [self textViewFinishingString];
    if ([NSString isEmpty:str])
    {
        
        CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:@"评论不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    [self showLoader:@"评论发布中"];
    WEAKSELF
    
    [[AppAPIHelper shared].getTribeAPI pushArticleCommentId:_model.articleId comment:str complete:^(id data) {
        [weakSelf showTips:@"评论成功"];
        weakSelf.model.commentNum += 1;
        [weakSelf refreshWihtData:data];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    } error:^(NSError *error) {
        
    }];
    
    
}

- (void)backBtnClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshWihtData:(id)data{
    if ([_delegate respondsToSelector:@selector(theAriticlecommentRefresh:)])
    {
        [_delegate theAriticlecommentRefresh:data];
    }
    
}



@end
