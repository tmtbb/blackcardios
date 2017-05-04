//
//  ShowYourNeedPageView.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePageModel;
typedef NS_ENUM(NSInteger,ShowYourNeedPageViewAction)  {
    ShowYourNeedPageViewAction_Close = 500,
    ShowYourNeedPageViewAction_Go
    
    
};


@interface ShowYourNeedPageView : OEZBaseView
- (void)setModel:(HomePageModel *)model;
@end
