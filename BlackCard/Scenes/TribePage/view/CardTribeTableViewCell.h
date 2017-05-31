//
//  CardTribeTableViewCell.h
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TribeModel.h"
#import "UIImage+ALinExtension.h"
@class CardTribeTableViewCell;
@protocol CardTribeCellDelegate<NSObject>
-(void)praise:(CardTribeTableViewCell *)cell;
-(void)comment:(CardTribeTableViewCell *)cell;
-(void)more:(CardTribeTableViewCell *)cell;
@end

@interface CardTribeTableViewCell : UITableViewCell

@property(assign,nonatomic)id <CardTribeCellDelegate>delegate;
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
@end

