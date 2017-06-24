//
//  TribeCardTableViewCell.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/13.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
@class TribeModel;
@class TribeCardImageView;
@interface TribeCardTableViewCell : OEZTableViewCell<OEZTableViewCellProtocol>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerButtonTop;

@property (weak, nonatomic) IBOutlet UIButton *headerIconButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deteLabel;
@property (weak, nonatomic) IBOutlet UIButton *topButton;

@property (weak, nonatomic) IBOutlet UIView *showView;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailTop;
@property (weak, nonatomic) IBOutlet TribeCardImageView *imagesView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagesTop;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;


+ (CGFloat)detailHeight:(TribeModel *)data;
@end
