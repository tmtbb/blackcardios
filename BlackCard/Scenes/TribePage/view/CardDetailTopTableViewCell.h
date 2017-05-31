//
//  CardDetailTopTableViewCell.h
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TribeModel.h"
#import "UIImage+ALinExtension.h"

@interface CardDetailTopTableViewCell : UITableViewCell
@property(strong,nonatomic)UIImageView *headerImageView;
@property(strong,nonatomic)UIImageView *levelImageView;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *dateLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UIView *showImageView;
@property(strong,nonatomic)UIButton *praiseBtn;
@property(strong,nonatomic)UILabel *praiseLabel;
@property(strong,nonatomic)UILabel *commentLabel;
@property(strong,nonatomic)UIButton *commentBtn;
@property(strong,nonatomic)UIButton *moreBtn;
@property(strong,nonatomic)UILabel *moreLabel;
@property(strong,nonatomic)UIView *whiteView;
@property(strong,nonatomic)TribeModel *model;
@property(strong,nonatomic)UILabel *listTitle;
@property(strong,nonatomic)UILabel *underLine;
@end
