//
// Created by yaowang on 16/3/30.
// Copyright (c) 2016 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseCollectionViewController.h"


@interface BaseReqeustCollectionViewController : BaseCollectionViewController
{
/**
* 请求失败block
*/
@protected
    ErrorBlock _errorBlock;
/**
* 请求成功 block
*/
@protected
    CompleteBlock _completeBlock;
}

/**
*  开始请求
*/
-(void) didRequest;
/**
*  请求完成
*
*  @param data 返回的数据
*/
-(void) didRequestComplete:(id) data;
/**
*  请求出错
*
*  @param error 错误信息
*/
-(void) didRequestError:(NSError*) error;

@end