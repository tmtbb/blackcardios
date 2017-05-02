//
//  ShowYourNeedPageView.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/20.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ShowYourNeedPageView.h"
#import "WaiterModel.h"

@interface ShowYourNeedPageView ()
@property(strong,nonatomic)UIImageView *showView;
@property(strong,nonatomic)UIView *detailBackView;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *detailLabel;
@property(strong,nonatomic)UIButton *goButton;
@property(strong,nonatomic)UIButton *closeButton;

@end
@implementation ShowYourNeedPageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *layer = [[CALayer alloc]init];
        layer.frame = self.bounds;
        layer.backgroundColor = kUIColorWithRGBAlpha(0x555555, 0.7).CGColor;
        [self.layer addSublayer:layer];
        
        CGFloat scale  = kMainScreenWidth /375.0 ;
        CGFloat width = 301 * scale;
        CGFloat x = (kMainScreenWidth - width) / 2.0;
        
        UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(x, 92 * scale, width, 451 * scale)];
        baseView.backgroundColor = [UIColor whiteColor];
        baseView.layer.masksToBounds = YES;
        baseView.layer.cornerRadius = 3;
        

           _showView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,width, 271 * scale)];

        _showView.clipsToBounds = YES;
        _showView.contentMode = UIViewContentModeScaleAspectFill;
//        _showView.backgroundColor = kUIColorWithRGB(0xa6a6a6);
        
        
        

        _detailBackView = [[UIView alloc]initWithFrame:CGRectMake(0,_showView.frameHeight, width, 180 *scale)];
        _detailBackView.backgroundColor = [UIColor whiteColor];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15 * scale, width, 20)];
        _titleLabel.textColor = kUIColorWithRGB(0xE3A63F);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(44 * scale, _titleLabel.frameY + _titleLabel.frameHeight + 15 * scale, width - 88 * scale, kFontHeigt(14) * 2)];
        
        _detailLabel.textColor = kUIColorWithRGB(0x070707);
        _detailLabel.font= [UIFont systemFontOfSize:14];
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        
        
        _goButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _goButton.frame = CGRectMake(30 * scale, _detailLabel.frameY + _detailLabel.frameHeight + 18 * scale, width - 60 * scale, 45 * scale);
        _goButton.layer.masksToBounds = YES;
        _goButton.layer.cornerRadius = 3;
        _goButton.backgroundColor = kUIColorWithRGB(0x434343);
        [_goButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_goButton setTitle:@"召唤管家" forState:UIControlStateNormal];
        [_goButton addTarget:self action:@selector(goButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_detailBackView addSubview:_titleLabel];
        [_detailBackView addSubview:_detailLabel];
        [_detailBackView addSubview:_goButton];
        
        [self addSubview:baseView];
        [baseView addSubview:_showView];
        [baseView addSubview:_detailBackView];
        
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake((kMainScreenWidth - 50 ) / 2.0, baseView.frameY + baseView.frameHeight + 18, 50, 50);
        [_closeButton setImage:[UIImage imageNamed:@"waiterClose"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_closeButton];
        
        
        
        
    }
    
    return self;
    
}


- (void)setModel:(HomePageModel *)model {
    
//    model = [[WaiterModel alloc]init];
//    model.icon = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492694069136&di=5267ac4816e932f7dbb66557f27dc18a&imgtype=0&src=http%3A%2F%2Fsc.jb51.net%2Fuploads%2Fallimg%2F150707%2F14-150FG4503G95.jpg";
//    model.title = @"私人飞机";
//    model.detail = @"高效便捷随时出发，无需办理手续 立即登机，独享私密空间。";
    
    if ([model.privilegeImgurl hasPrefix:@"res://"]) {
        NSString *str = [model.privilegeImgurl stringByReplacingOccurrencesOfString:@"res://" withString:@""];
        UIImage *image = [UIImage imageNamed:str];
        _showView.image = image;
        
    }else {
        [_showView sd_setImageWithURL:[NSURL URLWithString:model.privilegeImgurl] placeholderImage:[UIImage imageNamed:@"waiterDefault"]];
    }
       
    _titleLabel.text = model.privilegeName;
    _detailLabel.text = model.privilegeDescribe;
    
}

- (void)goButtonAction:(UIButton *)button {
    
    [self didAction:ShowYourNeedPageViewAction_Go];

    
}

- (void)closeButtonAction:(UIButton *)button {
    
    [self didAction:ShowYourNeedPageViewAction_Close];
    
}
@end
