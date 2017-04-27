//
// Created by yaobanglin on 15/9/20.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import "BaseController.h"


@implementation BaseController {

}

- (instancetype)initWithDelegate:(id)delegate {
    self = [self init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

+ (instancetype)controllerWithDelegate:(id)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

-(UIViewController *) viewController
{
    return [_delegate viewController:self];
}
@end
