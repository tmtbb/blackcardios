//
//  BaseTableViewController.h
//  douniwan
//
//  Created by yaobanglin on 15/9/1.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpAPI.h"
#import "BaseTableViewController.h"

/**
* TableViewController 带请求的基类
*/
@interface BaseRequestTableViewController : BaseTableViewController
{
    /**
    * 请求成功 block
    */
@protected
    CompleteBlock _completeBlock;
    /**
    * 请求失败block
    */
@protected ErrorBlock _errorBlock;
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
