//
//  RegisterCardCell.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/24.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "BaseTableViewHScrollCell.h"

@interface RegisterCardCell : BaseTableViewHScrollCell

@end


@interface RegisterCardHScollCell : OEZHScrollViewCell
@property (weak, nonatomic) IBOutlet UIButton *NameButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


- (void)setButtonTransformIsScale:(BOOL)isScale;
@end
