//
//  MyAndUserModel.m
//  mgame648
//
//  Created by iMac on 15/11/24.
//  Copyright © 2015年 yaowang. All rights reserved.
//

#import "MyAndUserModel.h"
@implementation MyAndUserModel

-(instancetype)init {
    self = [super init];
    if( self != nil) {
        _username = @"";

        _headpic = @"";
        _blackcardCreditline = 0.0;
        _blackCardName = @"";

    }
    return self;
}



+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{@"username" : @"name",
             @"headpic" : @"headUrl"
             
             };
}



@end


@implementation UserDetailModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             
             };
}


@end


@implementation CheckPayPasswordModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             
             };
}


@end



@implementation VersionModel
+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{ @"describe" : @"description"
             
             };
}


@end



@implementation UserBandModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{@"openId":@"openId",
             @"accountType":@"accountType",
             @"channel":@"channel",
             @"nickname":@"nickname",
             @"headpic":@"headpic",
             @"appType":@"appType",
             @"unionid":@"unionid"
             };
}
@end

