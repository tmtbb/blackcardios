//
//  CardTribeHandle.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/19.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CardTribeHandle.h"
#import "CustomAlertController.h"
#import "TribeModel.h"
@implementation CardTribeHandle



+ (void)doPraise:(UIViewController *)control  model:(TribeModel *)model complete:(void (^)( ))complete {
    
    
    BOOL isLike = model.isLike;
    [[AppAPIHelper shared].getTribeAPI doTribePraiseTribeMessageId:model.circleId isLike:isLike complete:^(id data) {
        model.isLike = !isLike;
        NSString *show = @"点赞成功";
        NSInteger count = 1;
        if (isLike) {
            show = @"已取消点赞";
            count = -1;
        }
        model.likeNum += count;
        if (complete) {
            complete();
        }
        [control showTips:show];
        
        
    } error:^(NSError *error) {
        [control showError:error];
    }];
    
    
    
}

+ (void)doComment:(UIViewController *)control indexPath:(NSIndexPath *)path model:(TribeModel *)model complete:(void (^)(NSIndexPath *))complete {
    
    [control presentViewControllerWithIdentifier:@"CommentViewController" isNavigation:YES block:^(UIViewController *viewController) {
        [viewController setValue:model forKey:@"myModel"];
        [viewController setValue:path forKey:@"path"];
        [viewController setValue:control forKey:@"delegate"];
        
        
    }];
    if (complete) {
        complete(path);
    }
    
    
}

+ (void)doMore:(UIViewController *)control model:(TribeModel *)model {
    
    
    CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:@"更多功能" message:nil preferredStyle:UIAlertControllerStyleActionSheet cancelButtonTitle:@"取消" otherButtonTitles:@"举报",nil];
    [alert show:control didClicked:^(UIAlertAction *action, NSInteger buttonIndex) {
        if (action.style != UIAlertActionStyleCancel) {
            if (model.circleId  == nil) {
                [control showTips:@"举报内容不存在"];
                return;
            }
            [control showLoader:@"正在举报..."];
            [[AppAPIHelper shared].getTribeAPI toReportMessageId:model.circleId complete:^(id data) {
                [control showTips:@"举报成功"];
            } error:^(NSError *error) {
                [control showError:error];
            }];
        }
        
    }];

}
@end

