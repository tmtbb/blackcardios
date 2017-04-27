//
//  HomePageAPI.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpAPI.h"
#import "HomePageModel.h"

@protocol HomePageAPI <NSObject>


- (void)privilegeListWithComplete:(CompleteBlock)complete withError:(ErrorBlock)error;

- (void)cardListWithComplete:(CompleteBlock)complete withError:(ErrorBlock)error;
@end
