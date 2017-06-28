//
//  WKWebViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/28.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WKWebView.h>
@interface WKWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (strong, nonatomic)  WKWebView *webView;
@property(strong,nonatomic)UIProgressView *proressView;
@property(nonatomic,copy)NSString *url;
@property (nonatomic, strong)NSString *webTitle;
@property(nonatomic)BOOL needBack;
@end

@implementation WKWebViewController



- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    WEAKSELF
    self.title = self.webTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf didloadSetting];
    });
//    [weakSelf didloadSetting];

    self.navigationItem.backBarButtonItem.imageInsets = UIEdgeInsetsMake(0,-8.5, 0, 8.5);


}

- (void)didloadSetting {
    

    
    
    CGFloat top = self.navigationController.viewControllers.count > 1? 64 : 0;
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, top, kMainScreenWidth, kMainScreenHeight - top)];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    //取消右侧，下侧滚动条，去处上下滚动边界的黑色背景
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.allowsBackForwardNavigationGestures = YES;

    if (![self.url hasPrefix:@"http"]) {
        self.url = [NSString stringWithFormat:@"http://%@",self.url];
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    _proressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, top > 0 ? 0 : 64,_webView.frameWidth, 4)];
    _proressView.progressTintColor = kUIColorWithRGB(0xE3A63F);
    _proressView.trackTintColor = [UIColor clearColor];
    
    [self.view addSubview:_webView];
    [self.webView addSubview:_proressView];


    
    [self settinghLeftBar];
    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    CGFloat  changeFloat = [change[@"new"] floatValue];
    [_proressView setProgress:changeFloat animated:YES];
    if (changeFloat >= 1.0) {
        _proressView.hidden = YES;
        [_proressView setProgress:0 animated:NO];
    }else {
        _proressView.hidden = NO;
    }
}


- (void)settinghLeftBar {
    
    if (_needBack) {
        
        UIBarButtonItem * bar =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(backWithDismiss:)];
        bar.tintColor = kUIColorWithRGB(0xffffff);
        self.navigationItem.leftBarButtonItem = bar;
        
        
        
        
    }
    
    
}
- (void)backWithDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    __weak typeof(self) weakSelf = self;
    
    
    
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (response) {
            weakSelf.title = response;
        }

    }];

}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    [self showError:error];
}

- (void)dealloc
{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
}


@end
