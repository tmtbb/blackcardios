//
//  ManorViewCell.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

@interface ManorViewCell : OEZTableViewCell<OEZTableViewCellProtocol>
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UILabel *titleViewLabel;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


- (void)changeLeftColor:(UIColor *)color;

@end
