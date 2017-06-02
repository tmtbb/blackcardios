//
//  ChoosePayHandle.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ChoosePayHandlePayStatusDelegate <NSObject>

- (void)choosePayHandleWithType:(PayType)type withPayStatus:(PayStatus)payStatus withData:(id)data;

@end
@interface ChoosePayHandle : NSObject
@property(weak,nonatomic)id<ChoosePayHandlePayStatusDelegate>delegate;

- (instancetype)initWithController:(UIViewController *)controller andModel:(id)model;
- (void)handleShow;

- (void)upDate:(id)data;
@end
