//
//  GuideSubviewController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/28.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideSubviewControllerDelegate <NSObject>

- (void)didAction:(NSInteger)action data:(id)data;

@end

@interface GuideSubviewController : UIViewController
@property(nonatomic)NSInteger tag;
@property(weak,nonatomic)id<GuideSubviewControllerDelegate>delegate;
- (instancetype)initWithImageNamed:(NSString *)imageName;
+ (instancetype)guideSubViewImageNamed:(NSString *)imageName;

- (void)showBottomButton:(BOOL)isBottom;
@end
