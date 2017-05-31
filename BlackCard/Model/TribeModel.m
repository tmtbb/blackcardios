//
//  ClubModel.m
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TribeModel.h"
#import "NSString+Category.h"

@implementation TribeModel
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
