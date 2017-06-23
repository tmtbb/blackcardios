//
//  ManorMemberCell.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

@interface ManorMemberCell : OEZTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UIButton *refuseButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


- (void)isShowStatus:(BOOL)status;
@end
