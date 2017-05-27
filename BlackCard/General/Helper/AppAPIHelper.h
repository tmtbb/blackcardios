//
//  AppAPIHelper.h
//  mgame648
//
//  Created by simon on 15/11/24.
//  Copyright © 2015年 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyAndUserAPI.h"
#import "HomePageAPI.h"
#import "WaiterServiceAPI.h"

@protocol MessageAPI;

@interface AppAPIHelper : NSObject<OEZHelperProtocol>


/**
 *  我的及用户相关API
 *
 *  @return
 */
- (id <MyAndUserAPI>)getMyAndUserAPI;


- (id<HomePageAPI>)getHomePageAPI;
- (id<WaiterServiceAPI>)getWaiterServiceAPI;
@end
