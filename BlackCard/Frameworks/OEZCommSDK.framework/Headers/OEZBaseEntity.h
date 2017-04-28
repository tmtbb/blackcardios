//
//  Created by 180 on 14/9/21.
//  Copyright (c) 2014年 180. All rights reserved.
//
#import <Foundation/Foundation.h>

//yaobanglin 本引擎只限内部使用
@interface OEZBaseEntity : NSObject
-(instancetype) initWithDictionary:(NSDictionary *) dict;
-(NSDictionary*) toDictionary:(BOOL) isNSNull;
+(instancetype) initWithDictionary:(NSDictionary *) dict;
+(NSArray*) initWithsDictionarys:(NSArray*) dicts;
+(NSArray*) initWithsContentsOfPlistFile:(NSString *)path;
+(NSArray*) initWithsPlistResource:(NSString *)name ofType:(NSString *)ext;
+(NSArray*) initWithsJsonResource:(NSString *)name ofType:(NSString *)ext;
+(instancetype) initWithJsonResource:(NSString *)name ofType:(NSString *)ext;
@end