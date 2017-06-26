//
//  ClubModel.m
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TribeModel.h"
#import "NSString+Category.h"

@interface BaseTribeModel ()
@property(nonatomic)CGFloat tribeHeight;
@end
@implementation BaseTribeModel


- (NSString *)formatCreateTime {
    if (_formatCreateTime == nil) {
        NSString *time = [self giveTime];
        _formatCreateTime = [NSString convertWeekToTime:time];
    }
    return _formatCreateTime;
}
- (NSString *)giveTime {
    return @"";
}


-(CGFloat)modelHeight {
    return _tribeHeight;
}

- (void)setHeigth:(CGFloat)height {
    _tribeHeight = height;
}

- (BOOL)hasHeight{
    
    return _tribeHeight != 0;
}
@end


@implementation TribeModel


+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             @"circleId":@"id",
             };
    
    
}

+ (Class)circleMessageImgsModelClass {
    
    return [TribeMessageImgsModel class];
}

- (NSString *)giveTime {
    
    return _createTime;
}
- (NSInteger)yearMonth {
    if (_yearMonth == 0) {
        _yearMonth = [NSString convertStrToTime:_createTime timeStyle:@"yyyyMM"].integerValue;
    }
    return _yearMonth;
}




@end

@implementation TribeMessageImgsModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             @"img" : @"imgUrl"
             };
    
    
}


@end

@implementation TheArticleModel
+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             @"articleId":@"id",
             };
    
    
}
- (NSString *)giveTime {
    
    return _createTime;
}
@end

@implementation TheArticleDetailModel



@end

@implementation CommentListModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             @"commentId":@"id",
             };
    
    
}
- (NSString *)giveTime {
    
    return _createTime;
}

- (NSInteger)yearMonth {
    if (_yearMonth == 0) {
        _yearMonth = [NSString convertStrToTime:_createTime timeStyle:@"yyyyMM"].integerValue;
    }
    return _yearMonth;
}

@end



@implementation ManorModel


+ (Class)recommendTribesModelClass {
    
    return [ManorDescribeModel class];
}

+ (Class)userTribesModelClass {
    
    return [ManorDescribeModel class];
}



@end

@implementation ManorStatusModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             @"tribeId":@"id",
             };
    
    
}

@end

@implementation ManorDescribeModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             @"tribeId":@"id",
             @"describe":@"description",
             };
    
    
}

@end

@implementation ManorPersonModel
+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             @"personId":@"id",
             };
    
    
}

- (NSString *)giveTime {
    
    return _createTime;
}


@end

@implementation ManorInfoModel
+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{

             };
    
    
}


@end

@implementation ManorDetailModel
+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             @"tribeId":@"id",
             @"describe":@"description",
             };
    
    
}


@end


@implementation ManorMemberInfoModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             
             };
    
    
}

@end



