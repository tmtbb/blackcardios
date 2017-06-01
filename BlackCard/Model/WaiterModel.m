//
//  WaiterModel.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "WaiterModel.h"
#import "NSString+Category.h"
@implementation WaiterModel

@end

@implementation WaiterServiceMDetailModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             
             };
}


- (NSString *)createTime {
    return  [NSString convertStrToTime:_createTime];
}

@end
