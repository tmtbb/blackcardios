//
//  homePageCollectionViewCell.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "HomePageCollectionViewCell.h"
#import "HomePageModel.h"

@implementation HomePageCollectionViewCell
-(void)awakeFromNib {
    [super awakeFromNib];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    
}
- (void)update:(HomePageModel *)data {
    if ([data isKindOfClass:[HomePageModel class]]) {
        
        [self setColorWithModel:data];
        
        self.titleLabel.text = data.privilegeName;
        self.hidden = NO;
        
        
        
        
        
        
    }else {
        
//        _iconView.image = nil;
//        _titleLabel.text = nil;
        self.hidden = YES;
    }
    
  
    
}

- (void)setColorWithModel:(HomePageModel *)model {
    
    BOOL  isNotGray =  [model.privilegePowers[model.privilegePowerType.type.stringValue] boolValue];
    if (isNotGray) {
        self.titleLabel.textColor = kUIColorWithRGB(0x434343);
    }else {
        
        self.titleLabel.textColor = kUIColorWithRGB(0xA6A6A6);
    }
    
    [self setImageWithImage:model.privilegeIcon isGray:!isNotGray];
    
}


- (void)setImageWithImage:(NSString *)imageStr isGray:(BOOL)isGray {
    if ([NSString isEmpty:imageStr]) {
        _iconView.image = [UIImage imageNamed:@"blackCardPrivilegeDefault"];
    }else if ([imageStr hasPrefix:@"res://"]) {
        NSString *str = [imageStr stringByReplacingOccurrencesOfString:@"res://" withString:@""];
        UIImage *image = [UIImage imageNamed:str];
        image = isGray ? [self imageWithImage:image] : image;
        _iconView.image = image;
        
    }else {
        
        WEAKSELF
        
        [_iconView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"blackCardPrivilegeDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (isGray && error == nil) {
                weakSelf.iconView.image = [weakSelf imageWithImage:image];
            }

        }];

        
        
        
    }
    
    
    
}




- (UIImage *)imageWithImage:(UIImage *)image
{
    CGRect imageRect = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, image.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [image drawInRect:imageRect];
    
    CGContextSetFillColorWithColor(ctx, kUIColorWithRGB(0xa6a6a6).CGColor);
    CGContextSetAlpha(ctx, 1.0);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, imageRect);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
                                             scale:image.scale
                                       orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    return darkImage;
}

@end
