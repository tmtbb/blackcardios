//
//  WKWebViewToos.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

typedef void(^WKWebViewToosBlock)(WKWebView *webView,id response,NSError *error);

@interface WKWebViewToos : NSObject

- (WKWebView *)webView ;
- (instancetype)initWithWebViewFrame:(CGRect)rect;
- (void)loadRequest:(NSString *)url withReponse:(void(^)(WKWebView *webView,id response,NSError *error))block;
@end
