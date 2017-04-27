//
//  CurrentUserActionHelper.m
//  mgame648
//
//  Created by yaowang on 15/11/27.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "CurrentUserActionHelper.h"
@implementation CurrentUserActionHelper
{
    OEZWeakMutableArray *_softMutableArray;
}
HELPER_SHARED(CurrentUserActionHelper)

- (instancetype)init {
    self = [super init];
    if ( self != nil )
    {
        _softMutableArray = [[OEZSoftLockMutableArray alloc] init];
    }
    return self;
}

- (void)registerDelegate:(id<CurrentUserActionDelegate>)delegate {
    [_softMutableArray addSingletonObject:delegate];
}

- (void)removeDelegate:(id<CurrentUserActionDelegate>)delegate {
    [_softMutableArray removeObject:delegate];
}

- (void)didDelegate:(void (^)(id<CurrentUserActionDelegate> delegate))block {
    if( block != nil)
    {
        [_softMutableArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (  [obj conformsToProtocol:@protocol(CurrentUserActionDelegate)] )
            {
                block(obj);
            }
        }];
        
        
    }
}

- (void)didDelegateConcurrent:(void (^)(id<CurrentUserActionDelegate> delegate))block {
    if( block != nil)
    {
        [_softMutableArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (  [obj conformsToProtocol:@protocol(CurrentUserActionDelegate)] )
            {
                block(obj);
            }
        }];
    }
}

- (void)sender:(id)sender didLogin:(id)user {
    [self didDelegate:^(id<CurrentUserActionDelegate> delegate) {
        if( [delegate respondsToSelector:@selector(sender:didLogin:)])
        {
            [delegate sender:sender didLogin:user];
        }
    }];
}

- (void)didLogoutSender:(id)sender {
    [self didDelegate:^(id<CurrentUserActionDelegate> delegate) {
        if ( [delegate respondsToSelector:@selector(didLogoutSender:)]) {
            [delegate didLogoutSender:sender];
        }
    }];
}

- (void)sender:(id)sender didUpdate:( MyAndUserModel *)userinfo; {
    [self didDelegate:^(id <CurrentUserActionDelegate> delegate) {
        if ([delegate respondsToSelector:@selector(sender:didUpdate:)]) {
            [delegate sender:sender didUpdate:userinfo];
        }
    }];
}

- (void)sender:(id)sender didChangeMoney:(CGFloat)money {
    [self didDelegateConcurrent:^(id<CurrentUserActionDelegate> delegate) {
        if ( [delegate respondsToSelector:@selector(sender:didChangeMoney:)]) {
            [delegate sender:sender didChangeMoney:money];
        }
    }];
}

- (void)sender:(id)sender didChangeOrderStauts:(NSInteger) status orderId:(NSString*) orderId {
    [self didDelegate:^(id<CurrentUserActionDelegate> delegate) {
        if ( [delegate respondsToSelector:@selector(sender:didChangeOrderStauts:orderId:)]) {
            [delegate sender:sender didChangeOrderStauts:status orderId:orderId];
        }
    }];
}

- (void)sender:(id)sender didFeedBackOrderId:(NSString *)orderId {
    [self didDelegate:^(id<CurrentUserActionDelegate> delegate) {
        if ([delegate respondsToSelector:@selector(sender:didFeedBackOrderId:)]) {
            [delegate sender:sender didFeedBackOrderId:orderId];
        }
    }];
}


- (void)sender:(id)sender didPublishDynamic:(id)dynamic {
    [self didDelegate:^(id <CurrentUserActionDelegate> delegate) {
        if ([delegate respondsToSelector:@selector(sender:didPublishDynamic:)]) {
            [delegate sender:sender didPublishDynamic:dynamic];
        }
    }];
}

- (void)sender:(id)sender didRefreshDynamic:(id)dynamic {
    [self didDelegate:^(id <CurrentUserActionDelegate> delegate) {
        if ([delegate respondsToSelector:@selector(sender:didRefreshDynamic:)]) {
            [delegate sender:sender didRefreshDynamic:dynamic];
        }
    }];
}

- (void)sender:(id)sender didModalWeiXinInvitation:(id)isFirst {
    [self didDelegate:^(id<CurrentUserActionDelegate> delegate) {
        if ([delegate respondsToSelector:@selector(sender:didModalWeiXinInvitation:)]) {
            [delegate sender:sender didModalWeiXinInvitation:isFirst];
        }
    }];
}

- (void)sender:(id)sender didIsSpread:(id)isSpread {
    [self didDelegate:^(id<CurrentUserActionDelegate> delegate) {
        if ([delegate respondsToSelector:@selector(sender:didIsSpread:)]) {
            [delegate sender:sender didIsSpread:isSpread];
        }
    }];
}

- (void)sender:(id)sender didIsDelete:(id)isDelete {
    [self didDelegate:^(id<CurrentUserActionDelegate> delegate) {
        if ([delegate respondsToSelector:@selector(sender:didIsDelete:)]) {
            [delegate sender:sender didIsDelete:isDelete];
        }
    }];
}

- (void)messagesPraiseHelper:(id)sender withHeadImageUrl:(NSString *)url {
    [self didDelegate:^(id<CurrentUserActionDelegate> delegate) {
        if ([delegate respondsToSelector:@selector(messagesPraiseHelper:withHeadImageUrl:)]) {
            [delegate messagesPraiseHelper:sender withHeadImageUrl:url];
        }
    }];
}

- (void)messagesRedMessagesHelper:(id)sender withHidden:(BOOL)isHidden {
    [self didDelegate:^(id<CurrentUserActionDelegate> delegate) {
        if ([delegate respondsToSelector:@selector(messagesRedMessagesHelper:withHidden:)]) {
            [delegate messagesRedMessagesHelper:sender withHidden:isHidden];
        }
    }];
}

@end
