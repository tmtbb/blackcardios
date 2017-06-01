//
//  CardDetailBottomTableViewCell.h
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TribeModel.h"
#import "UIImage+ALinExtension.h"

@interface CardDetailBottomTableViewCell : UITableViewCell
@property(strong,nonatomic)UIImageView *headerImageView;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *dateLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UIView *whiteView;
@property(strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)CommentListModel *model;
@end
