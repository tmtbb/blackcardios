//
//  EliteDetailTopTableViewCell.h
//  BlackCard
//
//  Created by xmm on 2017/5/29.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TribeModel.h"
@interface EliteDetailTopTableViewCell : UITableViewCell
@property(strong,nonatomic)UIView *whitView;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *dateLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UIImageView *articleIamge;
@property(strong,nonatomic)UILabel *articleLabel;
@property(strong,nonatomic)UILabel *partingLine;
@property(strong,nonatomic)UIButton *allBtn;
@property(strong,nonatomic)EliteLifeModel *model;
@end
