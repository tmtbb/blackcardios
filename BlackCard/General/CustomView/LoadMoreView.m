//
//  LoadMoreView.m
//  douniwan
//
//  Created by 180 on 15/4/7.
//  Copyright (c) 2015年 180. All rights reserved.
//

#import "LoadMoreView.h"

@implementation LoadMoreView

-(void) startLoadMore;
{
    [self startAnimating];
    [_loadLabel setText:@"正在加载..."];
    [_loadLabel setHidden:NO];
}

- (void)endLoadMoreNoText
{
    [self endLoadMore];
    [_loadLabel setHidden:YES];
    
}

-(void) errorLoadMore
{
    [self stopAnimating];
    [_loadLabel setText:@"加载数据失败"];
}

-(void) endLoadMore
{
   [self stopAnimating];
    [_loadLabel setText:@"再上点~"];
    
}

-(void) notMore
{
    [self stopAnimating];
    [_loadLabel setText:@"暂无更多数据"];
}

-(void) startAnimating
{
    [self.labelCenterX setConstant:-10.0];
    [_activity setHidden:NO];
    [_activity startAnimating];
}

-(void) stopAnimating
{
    [self.labelCenterX setConstant:0];
    [_activity setHidden:YES];
    [_activity stopAnimating];
}

@end
