//
//  ShoppingListLogCell.h
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

@interface ShoppingListLogCell : OEZTableViewCell
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *deteLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


- (void)setYearMonth:(NSInteger )time;
@end
