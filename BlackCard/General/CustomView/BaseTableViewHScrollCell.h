//
//  BaseTableViewHScrollCell.h
//  douniwan
//
//  Created by yaobanglin on 15/9/15.
//  Copyright (c) 2015 yaowang. All rights reserved.
//



@interface BaseTableViewHScrollCell : OEZTableViewHScrollCell {
@protected
    NSArray *_datas;
}
-(NSString *) hScrollView:(OEZHScrollView *)hScrollView cellIdentifierForColumnAtIndex:(NSInteger)columnIndex;
@end
