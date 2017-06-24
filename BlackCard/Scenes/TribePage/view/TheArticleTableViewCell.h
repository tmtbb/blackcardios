//
//  EliteLifeTableViewCell.h
//  BlackCard
//
//  Created by xmm on 2017/5/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
@interface TheArticleTableViewCell : OEZTableViewCell<OEZTableViewCellProtocol>
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopToLabelCenter;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailTop;


@end
