//
//  PayModel.m
//  mgame648
//
//  Created by simon on 15/11/24.
//  Copyright © 2015年 yaowang. All rights reserved.
//

#import "PayModel.h"

@implementation PayModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             };
}
+ (Class)payInfoModelClass {
    
    return [PayInfoModel class];
}


@end


@implementation PayInfoModel

+ (Class)wxPayInfoModelClass {
    
    return [WXPayModel class];
}
+ (Class)aliPayInfoModelClass {
    
    return [AliPayModel class];
}

@end

@implementation WXPayModel


+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             @"sign":@"paysign",
             };
    
    
}



@end

@implementation AliPayModel



@end

@implementation DefaultModel



@end
