//
//  WaiterServiceAPI.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpAPI.h"


@protocol WaiterServiceAPI <NSObject>


- (void)getWaiterServiceDetailWithServiceNum:(NSString *)num Complete:(CompleteBlock)complete withError:(ErrorBlock)error;

- (void)getPayWithServiceNo:(NSString *)serviceNo  payType:(NSInteger)payType payPassword:(NSString *)payPassword Complete:(CompleteBlock)complete withError:(ErrorBlock)error;

@end
