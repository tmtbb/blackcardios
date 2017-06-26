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

+ (void)doMore:(UIViewController *)control model:(TribeModel *)model  block:(CardTribeHandleBlock)block{
    
    CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:@"更多功能" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    BOOL isMe = [model.userId isEqualToString:[CurrentUserHelper shared].uid];
    [alert addButtonWithTitle:isMe ? @"删除" : @"举报" andStyle:UIAlertActionStyleDestructive];
    [alert addCancleButton:@"取消"];
    
    WEAKSELF
    [alert show:control didClicked:^(UIAlertAction *action, NSInteger buttonIndex) {
        if (action.style != UIAlertActionStyleCancel) {
            if (isMe) {
                [weakSelf doDeleteCircleWihtModel:model control:control block:block];
                
            }else {
                [weakSelf   doReportWihtModel:model control:control block:block];
                
            }
            
        }
        
    }];

}

+ (void)doDeleteCircleWihtModel:(TribeModel *)model control:(UIViewController *)controller  block:(CardTribeHandleBlock)block {
    [controller showLoader:@"正在删除"];
   [[AppAPIHelper shared].getTribeAPI doDeleteCircleWihtId:model.circleId complete:^(id data) {
       if (block) {
           block(YES,data,nil);
       }
   } error:^(NSError *error) {
       if (block) {
           block(YES,nil,error);
       }
   }];
    
}

+ (void)doReportWihtModel:(TribeModel *)model control:(UIViewController *)controller  block:(CardTribeHandleBlock)block{
    
    if (model.circleId  == nil) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"举报内容不存在" forKey:NSLocalizedDescriptionKey];
        NSError  *error = [NSError errorWithDomain:kAppNSErrorDomain code:kAppNSErrorCheckDataCode userInfo:userInfo];
        if (block) {
            block(NO,nil,error);
        }
        return;
    }
    [controller showLoader:@"正在举报..."];
    [[AppAPIHelper shared].getTribeAPI toReportMessageId:model.circleId complete:^(id data) {
        block(NO,data,nil);
        if (block) {
            block(NO,data,nil);
        }
    } error:^(NSError *error) {
        if (block) {
            block(NO,nil,error);
        }
    }];
    
}


@end

