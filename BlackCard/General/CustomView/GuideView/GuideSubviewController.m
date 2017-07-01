//
//  GuideSubviewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/28.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "GuideSubviewController.h"

@interface GuideSubviewController ()
@property(strong,nonatomic)UIImageView *imageView;
@property(copy,nonatomic)NSString *imageName;
@property(strong,nonatomic)UIButton *topButton;
@property(strong,nonatomic)UIButton *BottomButton;
@end

@implementation GuideSubviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _imageView.image = [UIImage imageNamed:_imageName];
    _imageView.clipsToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imageView];

    
}


- (UIButton *)topButton {
    
    if (_topButton == nil) {
        _topButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _topButton.backgroundColor = kUIColorWithRGBAlpha(0xffffff, 0.25);
        [_topButton setTitle:@"跳过" forState:UIControlStateNormal];
        _topButton.frame = CGRectMake(36, 30, 61, 26);
        _topButton.layer.masksToBounds = YES;
        _topButton.layer.cornerRadius = 13;
        _topButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_topButton setTitleColor:kUIColorWithRGB(0x999999) forState:UIControlStateNormal];
        [_topButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_topButton];
 
    }
    return _topButton;
}
- (UIButton *)BottomButton {
    if (_BottomButton == nil) {
        CGFloat y = kMainScreenHeight - 113 * (kMainScreenHeight / 667.0);
        
        _BottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _BottomButton.frame = CGRectMake((kMainScreenWidth - 209)/ 2.0, y, 209, 44);
        [_BottomButton setImage:[UIImage imageNamed:@"guideViewButton"] forState:UIControlStateNormal];
        [_BottomButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_BottomButton];
    }
    return _BottomButton;
    
}

- (instancetype)initWithImageNamed:(NSString *)imageName {
    self = [super init];
    if (self) {
        self.imageName = imageName;
    }
    
    return self;
}
+ (instancetype)guideSubViewImageNamed:(NSString *)imageName {
    
    return [[GuideSubviewController alloc]initWithImageNamed:imageName];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showBottomButton:(BOOL)isBottom {
    self.topButton.hidden = isBottom;
    self.BottomButton.hidden = !isBottom;
    
}
- (void)buttonAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(didAction:data:)]) {
        [self.delegate didAction:_tag data:nil];
    }
}


@end
