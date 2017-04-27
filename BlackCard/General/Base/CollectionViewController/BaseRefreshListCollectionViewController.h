//
// Created by yaowang on 16/3/30.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRefreshCollectionViewController.h"


@interface BaseRefreshListCollectionViewController : BaseRefreshCollectionViewController
{
    /**
* 列表数据
*/
@protected
    NSMutableArray *_dataArray;
}
@end