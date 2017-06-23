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
#define kMaxWidth (kMainScreenWidth  / 2.0)
#define kMaxHeight (kMaxWidth)



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
            
        case 4:{
            UIButton *button3 = [_buttonArray objectAtIndex:2];
            UIButton *button4 = [_buttonArray objectAtIndex:3];
            button3.frame = button4.frame;
            [self setButtonFrame:button4 index:4];
            
        }
            break;
        default:
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
            NSInteger cloum = (array.count - 1)/ 3.0 ;
            return (kImageWidth + kImageEdge) * cloum + kImageWidth;
        }
        default:
            return  kImageWidth * 3.0 + kImageEdge * 2.0;
    }
    
    
}


+ (CGSize)computeImageSize:(TribeMessageImgsModel *)model button:(UIButton *)button{
    
    NSArray *array = [model.size componentsSeparatedByString:@"x"];
    CGFloat width = [array.firstObject floatValue] / 2.0;
    CGFloat heigth = [array.lastObject floatValue] / 2.0;
    if (width == 0 || width == 0) {
        button.frame = CGRectMake(12, 0, kImageWidth, kImageWidth);
        return CGSizeMake(kImageWidth, kImageWidth);
    }else {
        
        double scale = width / heigth;
        CGFloat minWidth =  kImageWidth / 2.0 ;
        if (scale >= kMaxWidth / kMaxHeight) {
            if (width > kMaxWidth) {
                CGFloat scaleHeight =   heigth * kMaxWidth / width;
                if (scaleHeight < minWidth) {
                    heigth = heigth < kMaxHeight ? heigth : minWidth;
                }else {
                   heigth = scaleHeight;
                }
        
                width = kMaxWidth;
            }
            
            
        }else {
            if (heigth > kMaxHeight) {
                
                CGFloat scaleWidth =   width * kMaxHeight / heigth;
                if (scaleWidth < minWidth) {
                    width = width < kMaxWidth ? width : minWidth;
                }else {
                    width = scaleWidth;
                }
                
                
                heigth = kMaxHeight;
                
            }
        }
        
        button.frame = CGRectMake(12, 0, width, heigth);
        return  CGSizeMake(width, heigth);
    }
    
}



- (UIButton *)createImageButton{
    ImageFillButton *button = [ImageFillButton buttonWithType:UIButtonTypeCustom];
    button.imageView.clipsToBounds = YES;
    button.contentMode = UIViewContentModeScaleToFill;
    button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
    
}


- (void)buttonAction:(UIButton *)button {
    NSMutableArray *frameArray = [NSMutableArray array];
    for (int i = 0 ; i < _imagesCount; i++) {
        UIButton *button =  [_buttonArray objectAtIndex:i];
        CGRect rect = [button convertRect: button.bounds toView:self.window]; ;
        
        NSString *string = NSStringFromCGRect(rect);
        [frameArray addObject:string];
    }
    
    
    
    [self didAction:TribeType_ImageAction data:@{@"index":@(button.tag - 100),@"frames":frameArray}];
    
}


@end


@implementation ImageFillButton


- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    return self.bounds;
}

@end

