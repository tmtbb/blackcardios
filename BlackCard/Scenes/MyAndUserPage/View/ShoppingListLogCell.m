//
//  ShoppingListLogCell.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ShoppingListLogCell.h"
#import "PurchaseHistoryModel.h"
@interface ShoppingListLogCell ()
@property(strong,nonatomic)CALayer *lineLayer;

@end
@implementation ShoppingListLogCell
- (void)awakeFromNib {
    [super awakeFromNib];
    _lineLayer = [[CALayer alloc]init];
    _lineLayer.frame = CGRectMake(12, 68.5, kMainScreenWidth - 48, 0.5);
    _lineLayer.backgroundColor = kUIColorWithRGB(0xd7d7d7).CGColor;
    [self.showView.layer addSublayer:_lineLayer];
    
}
- (void)update:(PurchaseHistoryModel *)data {
    self.namelabel.text = data.tradeGoodsName;
    self.deteLabel.text = data.formatCreateTime;
    self.orderNumLabel.text = data.tradeNo;
    
}


- (void)hiddenTime:(BOOL)isHidden{
    self.timeLabel.hidden = isHidden;
    _lineLayer.hidden = !isHidden;
}

- (void)setYearMonth:(NSInteger )time {
    if (time < 0) {
        self.timeLabel.hidden = YES;
        _lineLayer.hidden = YES;
    }else if (time == 0) {
        self.timeLabel.hidden = YES;
        _lineLayer.hidden = !self.timeLabel.hidden;
    }else {
        self.timeLabel.hidden = NO;
        _lineLayer.hidden = !self.timeLabel.hidden;
        
        NSInteger year = time / 100;
        NSInteger month = time % year;
        
        self.timeLabel.text = [NSString stringWithFormat:@"%@年%@月",@(year),@(month)];
        
    }
    
    
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    self.showView.backgroundColor = highlighted ? kUIColorWithRGB(0xd7d7d7) : kUIColorWithRGB(0xffffff);
    
}




@end
