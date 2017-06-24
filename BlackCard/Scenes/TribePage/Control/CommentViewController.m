//
//  CommentViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CommentViewController.h"
#import "CustomTextView.h"

#define kMaxTextCount 300
@interface CommentViewController ()<UITextViewDelegate>

@end
@implementation CommentViewController

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

    [[AppAPIHelper shared].getTribeAPI postTribeCommentTribeMessageId:_myModel.circleId message:str complete:^(id data) {
        [weakSelf showTips:@"评论成功"];
        weakSelf.myModel.commentNum += 1;
        [weakSelf refreshWihtPath:data];

        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];

}

- (void)refreshWihtPath:(id)data{
    if ([_delegate respondsToSelector:@selector(commentRefresh:data:)])
    {
        [_delegate commentRefresh:_path data:data];
    }
    
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
