//
//  GuideViewController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/31.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GuideViewControllerDelegate <NSObject>

- (void)guideViewClose;

@end
@interface GuideViewController : UIViewController

@property(weak,nonatomic)id<GuideViewControllerDelegate>delegate;


@end
