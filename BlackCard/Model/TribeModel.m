//
//  ClubModel.m
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TribeModel.h"
#import "NSString+Category.h"

@interface TribeModel ()
@property(nonatomic)CGFloat tribeHeight;
@end
@implementation TribeModel


+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             @"tribeId":@"id",
             };
    
    
}

+ (Class)tribeMessageImgsModelClass {
    
    return [TribeMessageImgsModel class];
}

- (NSString *)formatCreateTime {
    
    if (_formatCreateTime == nil) {
        _formatCreateTime = [NSString convertStrToTime:_createTime timeStyle:@"yyyy-MM-dd   HH:mm"];
    }
    return _formatCreateTime;
}

- (NSInteger)yearMonth {
    if (_yearMonth == 0) {
        _yearMonth = [NSString convertStrToTime:_createTime timeStyle:@"yyyyMM"].integerValue;
    }
    return _yearMonth;
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

@implementation TribeMessageImgsModel

+(NSDictionary *)jsonKeysByPropertyKey
{
    return @{
             };
    
    
}


@end

@implementation EliteLifeModel

@end

@implementation CommentListModel
- (NSString *)formatCreateTime {
    
    if (_formatCreateTime == nil) {
        _formatCreateTime = [NSString convertStrToTime:[NSString stringWithFormat:@"%ld",_createTime]];
    }
    return _formatCreateTime;
}

- (NSInteger)yearMonth {
    if (_yearMonth == 0) {
        _yearMonth = [NSString convertStrToTime:[NSString stringWithFormat:@"%ld",_createTime] timeStyle:@"yyyyMM"].integerValue;
    }
    return _yearMonth;
}

@end
