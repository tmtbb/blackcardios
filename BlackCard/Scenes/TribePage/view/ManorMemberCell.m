//
//  ManorMemberCell.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ManorMemberCell.h"
#import "TribeModel.h"
@implementation ManorMemberCell

- (void)update:(ManorPersonModel *)data {
    [self.headerButton sd_setImageWithURL:[NSURL URLWithString:data.headUrl] forState:UIControlStateNormal placeholderImage:kUIImage_DefaultIcon];
    
    self.nameLabel.text = data.nickName;
    self.dateLabel.text = data.formatCreateTime;
    
    self.buttonView.hidden = data.identity == 1;
    NSString *labelStr;
    switch (data.status) {

        case 2:
            labelStr = @"已通过";
            break;
        case 3:
            labelStr = @"已拒绝";
            break;
    }
    
    _statusLabel.hidden = labelStr == nil;
    _agreeButton.hidden = labelStr != nil;
    _refuseButton.hidden = _agreeButton.hidden;
    _statusLabel.text = labelStr;
    
}

- (void)isShowStatus:(BOOL)status {
    
    _buttonView.hidden = !status;
    
}
- (IBAction)buttonAction:(UIButton *)sender {
    TribeType type = sender.tag == 100 ? TribeType_ManorAgreeMemberJoin : TribeType_ManorRefuseMemberJoin;
    [self didSelectRowAction:type data:nil];
    
}
@end
