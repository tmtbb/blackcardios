//
//  BaseRequestViewController.h
//  douniwan
//
//  Created by yaobanglin on 15/9/2.
//  Copyright (c) 2015 yaowang. All rights reserved.
//



#import "BaseHttpAPI.h"
#import "BaseViewController.h"

/**
* ViewController 带请求的基类
*/
@interface BaseRequestViewController : BaseViewController
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
- (void)didRequest;

/**
*  请求完成
*
*  @param data 返回的数据
*/
- (void)didRequestComplete:(id)data;

/**
*  请求出错
*
*  @param error 错误信息
*/
- (void)didRequestError:(NSError *)error;
@end
