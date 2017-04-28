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

             
             };
}



@end

//@implementation MyAccountModel
//+(NSDictionary *)jsonKeysByPropertyKey
//{
//    return @{@"source":@"source",
//             @"money":@"money",
//             @"createTime":@"createTime"};
//}
//
//
//@end
//
//
//@implementation MySettingCheckVersion
//
//+(NSDictionary *)jsonKeysByPropertyKey
//{
//    return @{
//             @"version":@"version",
//             @"url":@"url",
//             @"intro":@"intro",
//             @"must":@"must",
//             @"rcgStatus":@"rcgStatus",
//             };
//}
//@end
//
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
//
//@implementation AdvertisementPopupModel
//+(NSDictionary *)jsonKeysByPropertyKey
//{
//    return @{@"advertisementId":@"id",
//             };
//}
//@end
//
//@implementation BaseMenuModel
//
//
//@end
//
//@implementation LocalMenuModel
//+ (instancetype)menuName:(NSString *)name icon:(NSString *)icon tag:(NSInteger)tag {
//    
//    LocalMenuModel *model = [[LocalMenuModel alloc]init];
//    model.name = name;
//    model.icon = icon;
//    model.tag = tag;
//    return  model;
//}
//
//
//@end
//
//@implementation LocalMenuMessageModel
//+ (instancetype)menuName:(NSString *)name icon:(NSString *)icon tag:(NSInteger)tag {
//    LocalMenuMessageModel *model = [[LocalMenuMessageModel alloc]init];
//    model.name = name;
//    model.icon = icon;
//    model.tag = tag;
//    return  model;
//}
//
//
//@end
//
//
//
//@implementation CustommenuListModel
//
//- (NSInteger)tag {
//    
//    return  10086;
//}
//
//+ (NSDictionary *)jsonKeysByPropertyKey {
//    return @{@"menuId":@"id"};
//}

//@end
