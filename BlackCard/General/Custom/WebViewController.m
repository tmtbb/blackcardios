//
//  WebViewController.m
//  levelinghelper
//
//  Created by abx’s mac on 2017/3/6.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "WebViewController.h"
@interface WebViewController ()<UIWebViewDelegate>
@property (strong, nonatomic)  UIWebView *webView;
@property(nonatomic,copy)NSString *url;
@property (nonatomic, strong)NSString *webTitle;
@property(nonatomic)BOOL needBack;
@end

@implementation WebViewController

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
   WEAKSELF
    self.title = self.webTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf didloadSetting];
    });
   
}

- (void)didloadSetting {
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    
    self.webView.dataDetectorTypes = UIDataDetectorTypeLink;
    //取消右侧，下侧滚动条，去处上下滚动边界的黑色背景
    self.webView.backgroundColor=[UIColor clearColor];
    
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    [self showLoader:@"正在加载"];
    if (![self.url hasPrefix:@"http"]) {
        self.url = [NSString stringWithFormat:@"http://%@",self.url];
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

    [self.view addSubview:_webView];
    
    
    
    
    
    
    
    //    for (UIView * view in self.webView.scrollView.subviews) {
    //        if ([view isKindOfClass:[UIImageView class]]) {
    //            view.hidden = YES;
    //            break;
    //        }
    //    }
    
    
    
    
    
    
    
    [self settinghLeftBar];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [self hiddenProgress];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self  hiddenProgress];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
