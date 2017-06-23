//
//  ManorMembersViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ManorMembersViewController.h"
#import "ManorMemberCell.h"
#import "TribeModel.h"
@interface ManorMembersViewController ()

@end

@implementation ManorMembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didRequest:(NSInteger)pageIndex {
    
    [[AppAPIHelper shared].getTribeAPI getManorPersonListTribeId:_circleId page:pageIndex complete:_completeBlock error:_errorBlock];
}

- (void)didRequestComplete:(id)data {
    
    [super didRequestComplete:data];
}

- (NSString *)tableView:(UITableView *)tableView cellIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"ManorMemberCell";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isMember) {
        [((ManorMemberCell *)cell) isShowStatus:NO];
    }
    
}

- (void)tableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath didAction:(NSInteger)action data:(id)data {
    switch (action) {
        case TribeType_ManorAgreeMemberJoin:
            [self auditMemeberJoin:YES indexPath:indexPath];
            break;
        case TribeType_ManorRefuseMemberJoin:
            [self auditMemeberJoin:NO indexPath:indexPath];

            break;
    }
    
}

- (void)auditMemeberJoin:(BOOL)isAgree indexPath:(NSIndexPath *)path{
    ManorPersonModel *model = [self tableView:self.tableView cellDataForRowAtIndexPath:path];
    WEAKSELF
    [[AppAPIHelper shared].getTribeAPI doAuditManorPerson:model.personId type:@(isAgree).stringValue complete:^(id data) {
        model.status = isAgree ?  2 : 3;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];
}

@end
