//
//  BaseRequestViewController.m
//  douniwan
//
//  Created by yaobanglin on 15/9/2.
//  Copyright (c) 2015 yaowang. All rights reserved.
//

#import "BaseRequestViewController.h"
#import "UIViewController+Category.h"
@implementation BaseRequestViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRequestBlock];
}

- (void)initRequestBlock {
    __weak id SELF = self;
    _errorBlock = ^(NSError *error) {
        [SELF didRequestError:error];
    };
    _completeBlock = ^(id data) {
        [SELF didRequestComplete:data];
    };
}

- (void)didRequestComplete:(id)data {
    [self hiddenProgress];
}

- (void)didRequestError:(NSError *)error {
    [self showError:error];
}

- (void)didRequest {
    [self showLoader:@"加载中..."];
}
@end
