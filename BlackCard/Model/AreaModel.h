//
//  AreaModel.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>


@interface CityModel : OEZModel
@property(copy,nonatomic)NSString *state;
@property(strong,nonatomic)NSArray *cities;
@end

@interface AreaModel : OEZModel

@property(copy,nonatomic)NSString *city;
@property(strong,nonatomic)NSArray *areas;
@end


@interface CityAreaModel : CityModel

@end


@interface CityLocationModel : OEZModel
@property(copy,nonatomic)NSString *state;
@property(copy,nonatomic)NSString *city;

@end
