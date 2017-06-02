//
//  GuideViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/31.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "GuideViewController.h"
#import "GuidePageOneView.h"
#import "GuidePageTwoView.h"
#import "GuidePageThreeView.h"

@interface GuideViewController ()<OEZViewActionProtocol>

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createView];
    
    
    
    
}

- (void)createView {
    WEAKSELF
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
        UIScrollView   *scrollView = [[UIScrollView alloc]initWithFrame:frame];
        CGFloat width = 3 * kMainScreenWidth;
        scrollView.contentSize = CGSizeMake(width,kMainScreenHeight);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        
        [weakSelf.view addSubview:scrollView];
        
        
        GuidePageOneView *one = [GuidePageOneView loadFromNib];
        one.delegate = weakSelf;
        one.frame = frame;
        GuidePageTwoView *two = [GuidePageTwoView loadFromNib];
        frame.origin.x += kMainScreenWidth;
        two.frame = frame;
        two.delegate = weakSelf;
        GuidePageTwoView *three = [GuidePageThreeView loadFromNib];
        frame.origin.x += kMainScreenWidth;
        three.delegate = weakSelf;
        three.frame = frame;
        
        [scrollView addSubview:one];
        [scrollView addSubview:two];
        [scrollView addSubview:three];
        
    });
    
    
}


- (void)view:(UIView *)view didAction:(NSInteger)action data:(id)data {
    if ([self.delegate respondsToSelector:@selector(guideViewClose)]) {
        [self.delegate guideViewClose];
    }
    
    
}
@end
