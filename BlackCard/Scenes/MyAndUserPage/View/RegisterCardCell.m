//
//  RegisterCardCell.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/24.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "RegisterCardCell.h"
#import "HomePageModel.h"

@interface RegisterCardCell ()<OEZViewActionProtocol>
@property(nonatomic)NSInteger lastChoose;
@end

@implementation RegisterCardCell
//

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (NSString *)hScrollView:(OEZHScrollView *)hScrollView cellIdentifierForColumnAtIndex:(NSInteger)columnIndex {
    return @"RegisterCardHScollCell";
}


- (CGFloat)hScrollView:(OEZHScrollView *)hScrollView widthForColumnAtIndex:(NSInteger)columnIndex {
    
    return   kMainScreenWidth / 3.0;
}



-(OEZHScrollViewCell*)hScrollView:(OEZHScrollView*)hScrollView cellForColumnAtIndex:(NSInteger) columnIndex{
    
    NSString *identifier = [self hScrollView:hScrollView cellIdentifierForColumnAtIndex:columnIndex];
    OEZHScrollViewCell *cell = [hScrollView dequeueReusableCellWithIdentifier:identifier];
    cell.selectBackgroundColor = [UIColor clearColor];
    [cell update:[_datas objectAtIndex:columnIndex]];
    cell.tag = 100 + columnIndex;
    cell.delegate = self;
    return cell;
}

- (void)view:(UIView *)view didAction:(NSInteger)action data:(id)data {
    if (_lastChoose != action) {
        BlackCardModel *model = [_datas objectAtIndex:action - 100];
        model.isChoose = YES;
        
        if (_lastChoose > 0) {
            model = [_datas objectAtIndex:_lastChoose - 100];
            model.isChoose = NO;
        }
        
        _lastChoose = action;
        
        [self.hScrollView reloadData];
        
        [self  didSelectRowColumn:action - 100];
        
    }
    
    
    
    
}

//- (void)hScrollView:(OEZHScrollView *)hScrollView didSelectColumnAtIndex:(NSInteger)columnIndex {
//    if (_lastChoose != columnIndex) {
//        RegisterCardHScollCell *cell = (RegisterCardHScollCell *)[self hScrollView:hScrollView cellForColumnAtIndex:columnIndex];
//        [cell setButtonTransformIsScale:YES];
//        if (_lastChoose > -1) {
//            cell = (RegisterCardHScollCell *)[self hScrollView:hScrollView cellForColumnAtIndex:_lastChoose];
//            [cell setButtonTransformIsScale:NO];
//        }
//        
//        _lastChoose = columnIndex;
//    }
//    
//    
//}
@end



@implementation RegisterCardHScollCell


- (void)update:(BlackCardModel *)data {
    [self.NameButton setTitle:data.blackcardName forState:UIControlStateNormal];
    NSString *price = [NSString stringWithFormat:@"¥%.2f",data.blackcardPrice];
    self.titleLabel.text = price;
    
    [self setButtonTransformIsScale:data.isChoose];
    
}

- (IBAction)buttonAction:(id)sender {

    [self didAction:self.tag];
    
}


- (void)setButtonTransformIsScale:(BOOL)isScale{
    UIButton *button = self.NameButton;
    if (isScale) {
        button.transform = CGAffineTransformMakeScale(1.1, 1.1);
        button.layer.borderWidth = 2;
        button.layer.borderColor = kUIColorWithRGB(0xE3A63F).CGColor;
       
    }else {
        
        button.transform =CGAffineTransformMakeScale(1, 1);
        button.layer.borderWidth = 1;
        button.layer.borderColor = kUIColorWithRGB(0xA6A6A6).CGColor;
    }
    
    
    
    
    
}

@end
