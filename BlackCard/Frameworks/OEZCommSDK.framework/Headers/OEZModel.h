//
// Created by yaowang on 16/3/4.
// Copyright (c) 2016 180. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OEZModel : NSObject
/**
 *  属性名与json映射字典
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *) jsonKeysByPropertyKey;
/**
 *  排除填充属性名字典
 *
 *  @return <#return value description#>
 */
+ (NSArray*) debarsByPropertyKey;
/**
 *  数组属性model class
 */
//+ (Class) arrayModleClass;
@end