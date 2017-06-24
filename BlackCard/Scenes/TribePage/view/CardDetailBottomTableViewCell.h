//
//  CardDetailBottomTableViewCell.h
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardDetailBottomTableViewCell : OEZTableViewCell<OEZTableViewCellProtocol>
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
