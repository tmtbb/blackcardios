//
//  UserSetInfoTableViewController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "BaseRefreshTableViewController.h"

@class UserDetailModel;
@protocol UserSetInfoUpdateProcotol <NSObject>

- (void)saveUserInformation:(id )data;

@end

@interface UserSetInfoTableViewController : BaseRefreshTableViewController
@property(weak,nonatomic)id<UserSetInfoUpdateProcotol> delegate;
@end
