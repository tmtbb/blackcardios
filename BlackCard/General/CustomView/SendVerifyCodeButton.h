//
//  SendVerifyCodeButton.h
//  douniwan
//
//  Created by yaobanglin on 15/9/7.
//  Copyright (c) 2015 yaowang. All rights reserved.
//


@interface SendVerifyCodeButton : UIButton
@property NSInteger maxLastSec;

/**
*  开始计时
*/
- (void)startWithCount;

/**
*  停止计时
*/
- (void)stopWithCount;
@end
