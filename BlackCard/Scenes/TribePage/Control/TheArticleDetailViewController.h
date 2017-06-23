//
//  TheArticleDetailViewController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "BaseRefreshPageCustomTableViewController.h"
@class TheArticleModel;
@interface TheArticleDetailViewController : BaseRefreshPageCustomTableViewController
@property(copy,nonatomic)TheArticleModel  *articleModel;
@end
