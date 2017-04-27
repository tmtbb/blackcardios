//
// Created by yaowang on 16/3/30.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import "BaseReqeustCollectionViewController.h"


@implementation BaseReqeustCollectionViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initRequestBlock];
}
#pragma mark reqeust
- (void)didRequest {
    [self showLoader:@"加载中..."];
}

- (void)didRequestComplete:(id)data {
    [self hiddenProgress];
}

- (void)didRequestError:(NSError *)error {
    [self showError:error];
}


#pragma mark private
- (void)initRequestBlock {
    __weak id SELF = self;
    _errorBlock = ^(NSError *error) {
        [SELF didRequestError:error];
    };
    _completeBlock = ^(id data) {
        [SELF didRequestComplete:data];
    };
}

@end