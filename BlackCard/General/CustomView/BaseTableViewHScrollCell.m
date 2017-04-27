//
//  BaseTableViewHScrollCell.m
//  douniwan
//
//  Created by yaobanglin on 15/9/15.
//  Copyright (c) 2015 yaowang. All rights reserved.
//

#import "BaseTableViewHScrollCell.h"

@implementation BaseTableViewHScrollCell
{
    
}

- (NSInteger)numberColumnCountHScrollView:(OEZHScrollView *)hScrollView {
    return [_datas count];
}

- (void)update:(id)data {
    if (_datas != data) {
        _datas = data;
        //[super update:data];
        [self.hScrollView reloadData];
    }
}

- (OEZHScrollViewCell *)hScrollView:(OEZHScrollView *)hScrollView cellForColumnAtIndex:(NSInteger)columnIndex {
    NSString *identifier = [self hScrollView:hScrollView cellIdentifierForColumnAtIndex:columnIndex];
    OEZHScrollViewCell *cell = [hScrollView dequeueReusableCellWithIdentifier:identifier];
    cell.selectBackgroundColor = [UIColor clearColor];
    [cell update:[_datas objectAtIndex:columnIndex]];
    return cell;
}


-(NSString *) hScrollView:(OEZHScrollView *)hScrollView cellIdentifierForColumnAtIndex:(NSInteger)columnIndex
{
    return nil;
}


- (void)hScrollView:(OEZHScrollView *)hScrollView didSelectColumnAtIndex:(NSInteger)columnIndex {
    [self didSelectRowColumn:columnIndex];
}
@end
