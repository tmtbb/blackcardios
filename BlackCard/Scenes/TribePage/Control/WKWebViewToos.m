//
//  WKWebViewToos.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "WKWebViewToos.h"

@interface WKWebViewToos ()<WKNavigationDelegate>
@property(strong,nonatomic)WKWebView *wkWeb;
@property(strong,nonatomic)UIProgressView *proressView;
@property(copy,nonatomic)WKWebViewToosBlock myBlock;
@property(nonatomic)BOOL loadFinish;
@end
@implementation WKWebViewToos



- (instancetype)initWithWebViewFrame:(CGRect)rect {
    self = [super init];
    if (self) {
        
        WKWebView *web = [[WKWebView alloc]initWithFrame:rect];
        web.backgroundColor = kAppBackgroundColor;
        web.navigationDelegate = self;
        web.allowsBackForwardNavigationGestures = YES;
        [web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        _wkWeb = web;
        _proressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0,_wkWeb.frameWidth, 2)];
        _proressView.progressTintColor = kUIColorWithRGB(0xE3A63F);
        _proressView.trackTintColor = [UIColor clearColor];
        [_wkWeb addSubview:_proressView];
        
        
    }
    
    return self;
}

- (void)loadRequest:(NSString *)url withReponse:(void(^)(WKWebView *webView,id response,NSError *error))block {
    
    
    if (!_isOnceLoad  || !_loadFinish ) {
        _myBlock = block;
        [_wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    __weak typeof(self) weakSelf = self;
    
    
    
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
        if (weakSelf.myBlock) {
            weakSelf.myBlock(webView, response, error);
        }

    }];
    _loadFinish = YES;
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    CGFloat  changeFloat = [change[@"new"] floatValue];
    [_proressView setProgress:changeFloat animated:YES];
    if (changeFloat < 1.0) {
        _proressView.hidden = NO;
    }else {
        _proressView.hidden = YES;
    }
    
    
}

- (void)dealloc
{
    [_wkWeb removeObserver:self forKeyPath:@"estimatedProgress"];
    
}

- (WKWebView *)webView {
    
    return _wkWeb;
    
}
@end
