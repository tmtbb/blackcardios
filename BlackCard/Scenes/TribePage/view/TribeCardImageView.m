//
//  TribeCardImageView.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/13.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "TribeCardImageView.h"
#import "TribeModel.h"

#define kImageWidth ((kMainScreenWidth - 95) / 3.0 - 5.0)
#define kMaxWidth (kMainScreenWidth - 100)
#define kMaxHeight (kMaxWidth * 9.0 / 16.0)



@interface TribeCardImageView ()
@property(strong,nonatomic)NSMutableArray<UIButton *> *buttonArray;
@property(nonatomic)NSUInteger imagesCount;
@end

static const CGFloat kEdge =  12.0;
static const CGFloat kImageEdge =  5.0;
static const NSInteger kMaxCount =  9;
@implementation TribeCardImageView


- (void)awakeFromNib {
    [super awakeFromNib];
    _buttonArray = [NSMutableArray array];
    
}


- (void)update:(NSArray<TribeMessageImgsModel*> *)array {
    if (array == nil || array.count == 0){
        self.hidden = YES;
        return;
    }
    
    self.hidden = NO;
    NSArray *imageArray = array;
    if (array.count > kMaxCount) {
        imageArray = [array subarrayWithRange:NSMakeRange(0, 9)];
    }
    
    _imagesCount = imageArray.count;
    WEAKSELF
    if (imageArray.count > self.buttonArray.count) {
        
        [imageArray enumerateObjectsUsingBlock:^(TribeMessageImgsModel  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < weakSelf.buttonArray.count) {
                UIButton *button = [weakSelf.buttonArray objectAtIndex:idx];
                button.hidden = NO;
                [weakSelf setButtonImage:button model:obj index:idx];
            }else {
                UIButton *button = [weakSelf createImageButton];
                [weakSelf setButtonImage:button model:obj index:idx];
                [weakSelf.buttonArray addObject:button];
            }
        }];
        
    }else {
        
        [self.buttonArray enumerateObjectsUsingBlock:^(UIButton  *_Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx < imageArray.count) {
                button.hidden = NO;
                [weakSelf setButtonImage:button model:[imageArray objectAtIndex:idx] index:idx];
                
            }else {
                [button setImage:nil forState:UIControlStateNormal];
                button.frame = CGRectZero;
                button.hidden = YES;
            }
            
        }];
        
        
    }
    
    [self setSpecialFrame:imageArray];
    
}


- (void)setButtonImage:(UIButton *)button model:(TribeMessageImgsModel *)model index:(NSUInteger)index {
    [button sd_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholderImage:nil];
    button.tag = 100 + index;
    
    [self setButtonFrame:button index:index];
    
}

- (void)setButtonFrame:(UIButton *)button index:(NSUInteger) index{
    NSInteger line = index % 3;
    NSInteger colum = index / 3;
    CGFloat x = kEdge + (kImageWidth + kImageEdge ) * line;
    CGFloat y = (kImageWidth + kImageEdge) * colum;
    button.frame = CGRectMake(x, y, kImageWidth, kImageWidth);
    
}

- (void)setSpecialFrame:(NSArray<TribeMessageImgsModel *>*)array {
    UIButton *button1 = _buttonArray.firstObject;
    switch (array.count) {
        case 1:{
            [TribeCardImageView computeImageSize:array.firstObject button:button1];
        }
            break;
        default:
            button1.contentMode = UIViewContentModeScaleAspectFit;
        case 4:{
            UIButton *button3 = [_buttonArray objectAtIndex:2];
            UIButton *button4 = [_buttonArray objectAtIndex:3];
            button3.frame = button4.frame;
            [self setButtonFrame:button4 index:4];
            
        }
            break;
            
    }
    
    
    
    
}

+(CGSize)computeImageSize:(TribeMessageImgsModel *)model {
    return  [self computeImageSize:model button:nil];
    
}


+ (CGFloat)computeImageHeigth:(NSArray<TribeMessageImgsModel*> *)array {
    
    switch (array.count) {
        case 0:
            return 0;
        case 1:
            return [self computeImageSize:array.firstObject button:nil].height;
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:{
            NSInteger cloum = array.count / 3 ;
            return (kImageWidth + kEdge) * cloum + kImageWidth;
        }
        default:
            return  kImageWidth * 3 + kEdge * 2;
    }
    
    
}


+ (CGSize)computeImageSize:(TribeMessageImgsModel *)model button:(UIButton *)button{
    
    NSArray *array = [model.size componentsSeparatedByString:@"x"];
    CGFloat width = [array.firstObject floatValue] / 2.0;
    CGFloat heigth = [array.lastObject floatValue] / 2.0;
    if (width == 0 || width == 0) {
        button.frame = CGRectMake(12, 0, kImageWidth, kImageWidth);
        button.contentMode = UIViewContentModeScaleAspectFit;
        return CGSizeMake(kImageWidth, kImageWidth);
    }else {
        
        double scale = width / heigth;
        CGFloat minWidth =  kImageWidth / 2.0 ;
        if (scale >= 9.0 / 16.0) {
            if (width > kMaxWidth) {
                heigth =   heigth * kMaxWidth / width;
                if (heigth < minWidth) {
                    heigth = minWidth;
                    button.contentMode = UIViewContentModeScaleAspectFit;
                }else button.contentMode = UIViewContentModeScaleToFill;
                width = kMaxWidth;
            }else  button.contentMode = UIViewContentModeScaleToFill;
            
            
        }else {
            if (heigth > kMaxHeight) {
                width = width * kMaxHeight / heigth;
                width = width < minWidth ? minWidth : width;
                if (width < minWidth) {
                    width = minWidth;
                    button.contentMode = UIViewContentModeScaleAspectFit;
                    
                }else   button.contentMode = UIViewContentModeScaleToFill;
                
                heigth = kMaxHeight;
                
            }else  button.contentMode = UIViewContentModeScaleToFill;
        }
        
        button.frame = CGRectMake(12, 0, width, heigth);
        return  CGSizeMake(width, heigth);
    }
    
}



- (UIButton *)createImageButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.clipsToBounds = YES;
    button.contentMode = UIViewContentModeScaleAspectFit;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
    
}


- (void)buttonAction:(UIButton *)button {
    NSMutableArray *frameArray = [NSMutableArray array];
    for (int i = 0 ; i < _imagesCount; i++) {
        UIButton *button = [_buttonArray objectAtIndex:i];
        CGRect rect = [self.window convertRect: button.frame fromView:button]; ;
        
        NSString *string = NSStringFromCGRect(rect);
        [frameArray addObject:string];
    }
    
    
    
    [self didAction:TribeType_ImageAction data:@{@"index":@(button.tag - 100),@"frames":frameArray}];
    
}


@end
