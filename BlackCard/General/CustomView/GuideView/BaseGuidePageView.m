//
//  BaseGuidePageView.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/31.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "BaseGuidePageView.h"

@interface BaseGuidePageView ()


@end

@implementation BaseGuidePageView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.pageViewTop.constant = 278 * kMainScreenWidth / 375.0;
    [self createPageView];
}

- (void)createPageView{
    CGFloat top  =  kMainScreenHeight - (30 * kMainScreenWidth / 375.0) - 21;
    CGFloat left = (kMainScreenWidth - 153)/ 2.0;
    CALayer *layer1 = [self creatAlayer:CGRectMake(0, top + 10 ,left, 1)];
    CALayer *layer2 = [self creatAlayer:CGRectMake(left + 21, top + 10 ,45, 1)];
    CALayer *layer3 = [self creatAlayer:CGRectMake(left + 21 * 2 + 45 , top + 10 ,45, 1)];
    CALayer *layer4 = [self creatAlayer:CGRectMake(kMainScreenWidth - left, top + 10 ,left, 1)];

    
    
    UILabel *label1 = [self createALabel:CGRectMake(left, top, 21, 21) text:@"1"];
    label1.tag = 100;
    UILabel *label2 = [self createALabel:CGRectMake(left + 21 + 45, top, 21, 21) text:@"2"];
    label2.tag = 101;
    UILabel *label3 = [self createALabel:CGRectMake(left + 42 + 90, top, 21, 21) text:@"3"];
    label3.tag = 102;


    
    [self.layer addSublayer:layer1];
    [self.layer addSublayer:layer2];
    [self.layer addSublayer:layer3];
    [self.layer addSublayer:layer4];

    
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];

    
    
    
    
}


- (UILabel *)createALabel:(CGRect )frame text:(NSString *)text{
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = kUIColorWithRGB(0x999999);
    label.layer.borderColor = kUIColorWithRGB(0x999999).CGColor;
    label.layer.cornerRadius = 10.5;
    label.font = [UIFont systemFontOfSize:14];
    label.layer.masksToBounds = YES;
    label.layer.borderWidth = 1;
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
- (CALayer *)creatAlayer:(CGRect )frame {
    
    CALayer *layer = [[CALayer alloc]init];
    layer.frame =frame;
    layer.backgroundColor = kUIColorWithRGB(0x4d4d4d).CGColor;
    return layer;
}

- (void)choosePage:(NSInteger)page {
    for (NSInteger i = 0 ; i < 3; i++) {
        UILabel *label = [self viewWithTag:100 + i];

        if (page == i) {
            label.layer.borderColor = kUIColorWithRGB(0xffffff).CGColor;
            label.textColor = kUIColorWithRGB(0x010101);
             label.backgroundColor = [UIColor whiteColor];
            
        }else {
            label.layer.borderColor = kUIColorWithRGB(0x999999).CGColor;
            label.textColor = kUIColorWithRGB(0x999999);
            label.backgroundColor = [UIColor clearColor];
        }
    }
    
}


- (IBAction)closeButtonAction:(UIButton *)sender {
    [self didAction:0];
}

@end
