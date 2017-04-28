//
//  SendVerifyCodeButton.m
//  douniwan
//
//  Created by yaobanglin on 15/9/7.
//  Copyright (c) 2015 yaowang. All rights reserved.
//

#import "SendVerifyCodeButton.h"


@interface SendVerifyCodeButton () {
    NSTimer *_timer;
    NSInteger _lastSec;
    UIColor *_color;
}
@end

@implementation SendVerifyCodeButton

- (void)awakeFromNib {
    [super awakeFromNib];
    //[self addTarget:self action:@selector(didAction:) forControlEvents:UIControlEventTouchUpInside];
    _maxLastSec = 60;
    _color = self.backgroundColor;
}

- (void)didTimer:(NSTimer *)timer {
    if (--_lastSec == 0) {
        [self stopWithCount];
    }
    else {
        [self setSendVerifyCodeTitle];
    }
}

- (void)setSendVerifyCodeTitle {
    NSString *strTitle = @"获取验证码";
    if (_lastSec > 0) {
        strTitle = [NSString stringWithFormat:@"剩余%@秒", @(_lastSec)];
        self.titleLabel.text = strTitle;
        [self setBackgroundColor:kUIColorWithRGB(0xCCCCCC)];
    }
    [self setTitle:strTitle forState:UIControlStateNormal];
    [self setTitle:strTitle forState:UIControlStateDisabled];
}

- (void)removeFromSuperview {
    [self stopWithCount];
    [super removeFromSuperview];
}

- (IBAction)didAction:(id)sender {
}

- (void)startWithCount {
    _lastSec = _maxLastSec;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(didTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [self setEnabled:NO];
    [self setSendVerifyCodeTitle];
}

- (void)stopWithCount {
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    [self setBackgroundColor:_color];
    [self setEnabled:YES];
}
@end
