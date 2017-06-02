//
//  BaseGuidePageView.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/31.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

@interface BaseGuidePageView : OEZNibView
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageViewTop;


- (void)choosePage:(NSInteger)page;


@end
