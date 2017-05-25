//
//  PurchaseHistoryModel.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/24.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "PurchaseHistoryModel.h"
#import "NSString+Category.h"
@implementation PurchaseHistoryModel

- (NSString *)formatCreateTime {
    
    if (_formatCreateTime == nil) {
        _formatCreateTime = [NSString convertStrToTime:_tradeTime];
    }
    return _formatCreateTime;
}

- (NSInteger)yearMonth {
    if (_yearMonth == 0) {
        _yearMonth = [NSString convertStrToTime:_tradeTime timeStyle:@"yyyyMM"].integerValue;
    }
    return _yearMonth;
}

@end


@implementation MyPurseDetailModel



- (NSString *)formatCreateTime {
    
    if (_formatCreateTime == nil) {
        _formatCreateTime = [NSString convertStrToTime:_createTime];
    }
    return _formatCreateTime;
}

- (NSInteger)yearMonth {
    if (_yearMonth == 0) {
        _yearMonth = [NSString convertStrToTime:_createTime timeStyle:@"yyyyMM"].integerValue;
    }
    return _yearMonth;
}





@end
