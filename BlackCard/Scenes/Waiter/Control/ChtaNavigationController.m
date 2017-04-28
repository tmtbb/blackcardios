//
//  ChtaNavigationController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/28.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ChtaNavigationController.h"

@interface ChtaNavigationController ()

@end

@implementation ChtaNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)onBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
