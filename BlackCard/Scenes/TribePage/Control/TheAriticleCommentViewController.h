//
//  TheAritickeCommentViewController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "BaseWriteTextViewController.h"

@protocol TheAriticleCommentProtocol<NSObject>
-(void)theAriticlecommentRefresh:(id)data;
@end
@interface TheAriticleCommentViewController : BaseWriteTextViewController
@property(assign,nonatomic)id<TheAriticleCommentProtocol>delegate;

@end
