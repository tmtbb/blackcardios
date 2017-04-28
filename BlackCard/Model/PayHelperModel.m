//
//  PayHelperModel.m
//  mgame648
//
//  Created by yaowang on 16/7/9.
//  Copyright © 2016年 ywwl. All rights reserved.
//

#import "PayHelperModel.h"

@implementation PayHelperModel


- (NSString*)payOrderNo {
    return self.isMore ? self.orderBatchNo : self.orderNo;
}
@end
