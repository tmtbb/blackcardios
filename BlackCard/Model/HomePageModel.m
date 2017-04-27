//
//  HomePageModel.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel
+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             };
}


- (PrivilegePowerPoint *)privilegePowerType {
    if (_privilegePowerType == nil) {
        _privilegePowerType = [[PrivilegePowerPoint alloc]init];
    }
    return _privilegePowerType;
}
@end

@implementation PrivilegePowerPoint



@end

@implementation  CardListModel


+ (Class)privilegesModleClass {
    
    return [HomePageModel class];
}

+ (Class)blackcardsModleClass {
    
    return [BlackCardModel class];
}


@end

@implementation BlackCardModel


@end

@implementation RegisterModel

+ (NSArray*) debarsByPropertyKey {
    return @[@"cardModel"];
}

- (BlackCardModel * )cardModel {
    if (_cardModel == nil) {
        _cardModel = [[BlackCardModel alloc]init];
    }
   return  _cardModel;
}


@end
