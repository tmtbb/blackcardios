//
//  ViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/19.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ViewController.h"
#import "ShowYourNeedPageView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowYourNeedPageView *view = [[ShowYourNeedPageView alloc]initWithFrame:self.view.bounds];
    [view setModel:nil];
    [self.view addSubview:view];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
