//
//  TribeCardTableViewCell.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/13.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TribeCardTableViewCell.h"
#import "TribeCardImageView.h"
#import "TribeModel.h"
#define kMaxDetailHeight  (kFontHeigt(14) * 6 + 1)


@interface TribeCardTableViewCell ()<OEZViewActionProtocol>
@property(strong,nonatomic)TribeModel *model;
@end
@implementation TribeCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imagesView.delegate = self;

}

- (void)update:(TribeModel *)data {
    _model = data;
    [self.headerIconButton sd_setImageWithURL:[NSURL URLWithString:data.headUrl] forState:UIControlStateNormal placeholderImage:kUIImage_DefaultIcon];
    self.userNameLabel.text = data.nickName;
    self.deteLabel.text = data.formatCreateTime;
    self.detailLabel.text = data.message.trim;
    [self.imagesView update:data.circleMessageImgs];
    self.detailTop.constant = [NSString isEmpty:data.message.trim] ? 0 : 9;
    self.imagesTop.constant = data.circleMessageImgs.count > 0 ? 10 : 0;
    self.topButton.hidden = !data.isTop;
    [self updateForButton:data];
    
    
}

- (void)updateForButton:(TribeModel *)data {
    [self praiseButtonImage:data];

    [self.praiseButton setTitle:@(data.likeNum).stringValue forState:UIControlStateNormal];
    [self.commentButton setTitle:@(data.commentNum).stringValue forState:UIControlStateNormal];
    
    
}

- (void)praiseButtonImage:(TribeModel *)data {
    [self.praiseButton setImage:[UIImage imageNamed:data.isLike ? @"praised" : @"praise"] forState:UIControlStateNormal];
    
}

- (void)view:(UIView *)view didAction:(NSInteger)action data:(id)data {
    
    [self didSelectRowAction:action data:data];
}



+ (CGFloat)calculateHeightWithData:(TribeModel *)data {
    
    if (!data.hasHeight){
        CGFloat imagesHeight = [TribeCardImageView computeImageHeigth:data.circleMessageImgs];
        imagesHeight  = imagesHeight == 0 ? 0 : imagesHeight + 10;
        CGFloat messageHeight = [self detailHeight:data];
        
        [data setHeigth:67 + 39 + messageHeight + imagesHeight];
        
    }
    

    return  data.modelHeight;

}

+ (CGFloat)detailHeight:(TribeModel *)data {
    NSString *detail = data.message.trim;
    CGFloat messageHeight = 9;
    if ([NSString isEmpty:detail]) {
        messageHeight = 0;
    }else {
        CGSize size = BoundIngRectWithText(detail, CGSizeMake(kMainScreenWidth - 100, MAXFLOAT), 14);
        CGFloat maxHeight = kMaxDetailHeight ;
        messageHeight += size.height >  maxHeight ? maxHeight : size.height;
    }
    
    return messageHeight;
}


- (IBAction)buttonAction:(UIButton *)sender {
    NSInteger type = 0;
    
    switch (sender.tag) {
        case 100:
            type = TribeType_PraiseAction;
            
            break;
        case 101:
            type = TribeType_CommentAction;
            
            break;
        case 102:
            type = TribeType_MoreAction;
            break;
        default:
            break;
    }

    
    [self didSelectRowAction:type];
    
}


- (void)changeButtonType:(TribeType)type model:(TribeModel *)data{
    if (data != _model) {
        return;
    }
    switch (type) {
        case TribeType_PraiseAction:
            
            [self praiseButtonImage:data];
            break;
            
        default:
            break;
    }
}




@end
