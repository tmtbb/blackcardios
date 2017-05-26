//
//  MyPurseDetailCell.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "MyPurseDetailCell.h"
#import "PurchaseHistoryModel.h"
@interface MyPurseDetailCell ()
@property(strong,nonatomic)CALayer *lineLayer;
@end
@implementation MyPurseDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _lineLayer = [[CALayer alloc]init];
    _lineLayer.frame = CGRectMake(12, 68.5, kMainScreenWidth - 48, 0.5);
    _lineLayer.backgroundColor = kUIColorWithRGB(0xd7d7d7).CGColor;
    [self.showView.layer addSublayer:_lineLayer];
    
}

- (void)update:(MyPurseDetailModel *)data {
    
    self.nameLabel.text = data.tradeName;
    self.dateLabel.text = data.formatCreateTime;
    
    if (data.amount > 0) {
        self.moneyLabel.textColor = kUIColorWithRGB(0x1FCF55);
        self.moneyLabel.text = [NSString stringWithFormat:@"+¥%.2f",data.amount];
        
    }else if (data.amount < 0) {
        
        self.moneyLabel.textColor = kUIColorWithRGB(0xDB462E);
        self.moneyLabel.text = [NSString stringWithFormat:@"-¥%.2f",fabs(data.amount)];
    }else {
        
        self.moneyLabel.textColor = kUIColorWithRGB(0x1FCF55);
        self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",data.amount];
    }
    
    
    
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

- (void)hiddenTime:(BOOL)isHidden{
    self.timeLabel.hidden = isHidden;
    _lineLayer.hidden = !isHidden;
    
}



@end
