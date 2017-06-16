//
//  ImageBrowseViewCell.m
//  douniwan
//
//  Created by simon on 15/9/23.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "ImageBrowseViewCell.h"
#import "CacheHelper.h"
#import "ImagesModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDImageCache.h>
#define SMALLWIDTH 100.f
typedef NS_ENUM(NSInteger, ImageUrl)
{
    HaveSmallImage,
    NoBigImage,
    HaveBigImage
    
};

@interface ImageBrowseViewCell ()
{
    id _data;
    BOOL _isBigOne;
}
@property(nonatomic,strong)UIImage *smallImage;
@end

@implementation ImageBrowseViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.iScrollView addGestureRecognizer:tap];
    
    [self settingIImageView];
}

- (void)settingIImageView{
    self.iImageView = [UIImageView new];
    self.iImageView.userInteractionEnabled = YES;
    self.iImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iImageView.clipsToBounds = YES;
    [self.iImageView setFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(iImageViewLongPress:)];
    [self.iImageView addGestureRecognizer:longPress];
    [self.iScrollView addSubview:_iImageView];
    
}


- (void)update:(id)data {
    _smallImage = nil;
    _isBigOne = NO;
    _data = data;
    
    //    self.iScrollView.contentSize = CGSizeMake(kMainScreenWidth, kMainScreenHeight);
    //    self.iImageView.center = CGPointMake(kMainScreenWidth/2, kMainScreenHeight/2);
    self.iScrollView.zoomScale = 1.0;
    
    if ([data isKindOfClass:[UIImage class]]) {
        
        self.iImageView.image = data;
        self.iImageView.frame = [ImageBrowseViewCell calculateIimageViewFrame:self.iImageView.image.size];
        
    }
    else {
        NSString *url = nil;
        if ([data isKindOfClass:[ImagesModel class]]) {
            ImagesModel *model = data;
            url = [model url];
        }
        else if ([data isKindOfClass:[NSString class]])
            url = data;
        
        [self setImageViewSmallUrl:url];
    }
    
}

- (void)setImageViewSmallUrl:(NSString *)stringUrl {
    if (stringUrl != nil)
    {
        NSString *bigStringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"small" withString:@"big"];
        if (![bigStringUrl isEqualToString:stringUrl])//大小图url不同时
        {
            //有大图直接显示大图
            //            if ([[CacheHelper shared] diskImageFileExistsWithKey:bigStringUrl])
            if ( [[CacheHelper shared] diskImageFileExistsWithKey:bigStringUrl] )
                [self setImageViewUrl:bigStringUrl isActivity:HaveBigImage];
            
            else if ( [[CacheHelper shared] diskImageFileExistsWithKey:stringUrl] ) // 没大图 有小图 显示小图 然后刷大图
                [self setImageViewUrl:stringUrl isActivity:HaveSmallImage];
            
            else
                [self setImageViewUrl:bigStringUrl isActivity:NoBigImage];
            
        }
        else
        {
            if ( [[CacheHelper shared] diskImageFileExistsWithKey:stringUrl] ) {
                [self setImageViewUrl:stringUrl isActivity:HaveBigImage];
            }
            else
                [self setImageViewUrl:stringUrl isActivity:NoBigImage];
            
        }
        
    }
}


- (void)setImageViewUrl:(NSString *)stringUrl isActivity:(NSInteger)isActivity {
    
    switch (isActivity) {
        case HaveSmallImage:{
            [self isCacheImage:stringUrl];
            stringUrl = [stringUrl stringByReplacingOccurrencesOfString:@"small" withString:@"big"];
            [self.activityView startAnimating];
            
        }
            break;
        case NoBigImage:{
            [self.iImageView setFrame:CGRectMake(kMainScreenWidth / 2.f, kMainScreenHeight / 2.f, 0, 0)];
            [self.activityView startAnimating];
        }
            
            break;
        default:
            break;
    }
    NSURL *nsurl = [[CacheHelper shared] imageNSURLWithStrUrl:stringUrl];
    
    @try {
        WEAKSELF
        
        [self.iImageView sd_setImageWithURL:nsurl placeholderImage:_smallImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if ([weakSelf.activityView isAnimating]) {
                [weakSelf.activityView stopAnimating];
            }
            if (error == nil)
            {
                if (isActivity != HaveBigImage) {
                    [UIView animateWithDuration:0.5 animations:^{
                        weakSelf.iImageView.frame = [ImageBrowseViewCell calculateIimageViewFrame:image.size];
                        
                    }];
                }
                else
                {
                    weakSelf.iImageView.frame = [ImageBrowseViewCell calculateIimageViewFrame:image.size];
                    
                }
                
                _isBigOne = YES;
            }
            else
            {
                _isBigOne = NO;
                [weakSelf didAction:2];
                if ([weakSelf.activityView isAnimating]) {
                    [weakSelf.activityView stopAnimating];
                }
            }
            
        }];
    } @catch (NSException *exception) {
        APPLOG(@"exception = %@" , exception);
    } @finally {
        
    }
}



#pragma mark  设置小图先显示
- (void)isCacheImage:(NSString *)strUrl {
    WEAKSELF;
    
    [self.iImageView sd_setImageWithURL:[NSURL URLWithString:strUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.smallImage = image;
        weakSelf.iImageView.frame = [weakSelf calculateRectWithSmall:image.size];
    }];

    
}

- (CGRect)calculateRectWithSmall:(CGSize)size{
    
    if (size.width <= SMALLWIDTH) {
        return CGRectMake((kMainScreenWidth - size.width)/ 2.0, (kMainScreenHeight - size.height)/2.0, size.width, size.height);
    }
    else
    {
        CGFloat height = SMALLWIDTH * size.height / size.width;
        return CGRectMake((kMainScreenWidth - SMALLWIDTH)/2.0, (kMainScreenHeight - height)/2.0, SMALLWIDTH, height);
    }
    
}


+ (CGRect)calculateIimageViewFrame:(CGSize)size {
    
    CGSize sizeR = [self returnCGSize:size];
    CGFloat kWidth = kMainScreenWidth;
    CGFloat kHeight = kMainScreenHeight;
    CGFloat edgesW = (kWidth - sizeR.width) / 2.f;
    CGFloat edgesH = (kHeight - sizeR.height) / 2.f;
    
    CGRect rect = CGRectMake(edgesW > 0 ? edgesW : 0 ,edgesH > 0 ? edgesH: 0 , sizeR.width >kWidth ? kWidth :sizeR.width,sizeR.height > kHeight?kHeight : sizeR.height);
    
    return rect;
}

+ (CGSize)returnCGSize:(CGSize)size {
    if (size.height == 0 || size.width == 0) {
        return [kUIImage_DefaultIcon size];
    }
    
    CGFloat heiht = size.height;
    CGFloat width = size.width;
    CGFloat magnificationH = kMainScreenHeight / heiht;
    CGFloat magnificationW = kMainScreenWidth / width;
    
    CGFloat magnification = magnificationH > magnificationW ? magnificationW : magnificationH;
    
    CGSize magnificationSize = CGSizeMake(magnification * width, magnification * heiht);
    
    return magnificationSize;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _iImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat xcenter = scrollView.center.x;
    CGFloat ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 2.0 : xcenter;
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height / 2.0 : ycenter;
    
    _iImageView.center = CGPointMake(xcenter, ycenter);
}


- (void)tapAction:(UIGestureRecognizer *)sender {
    
    [self didAction:1];
    
}

- (void)iImageViewLongPress:(UILongPressGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
    }
    else if (sender.state == UIGestureRecognizerStateBegan)
    {
        UIImage *image = [self saveImageWithData:_data];
        if (image)
        {
            [self didAction:3 data:image];
        }
        
    }
}

- (UIImage *)saveImageWithData:(id)data{
    if ([data isKindOfClass:[UIImage class]])
        return data;
    else  if(_isBigOne)
        return _iImageView.image;
    else
        return nil;
    
}


+(void)beginAnimationWith:(id)data imageView:(UIImageView *)imageView rect:(void (^)(CGRect rect))myRect{
    if ([data isKindOfClass:[UIImage class]]) {
        
        imageView.image = data;
        myRect([ImageBrowseViewCell calculateIimageViewFrame:imageView.image.size]);
    }
    else {
        NSString *url = nil;
        if ([data isKindOfClass:[ImagesModel class]]) {
            ImagesModel *model = data;
            url = [model url];
        }
        else if ([data isKindOfClass:[NSString class]])
            url = data;
        
        
        NSString *bigStringUrl = [url stringByReplacingOccurrencesOfString:@"small" withString:@"big"];
        
        if ([bigStringUrl hasPrefix:@"/var"]) {
            NSURL * url = [NSURL fileURLWithPath:bigStringUrl];
            [imageView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage * image , NSError * error , SDImageCacheType cacheType , NSURL * imageURL){
                myRect([ImageBrowseViewCell calculateIimageViewFrame:image.size]);
            }];
        }
        else {
            if ([[CacheHelper shared ] diskImageFileExistsWithKey:bigStringUrl] ) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:bigStringUrl] placeholderImage:nil completed:^(UIImage * image , NSError * error , SDImageCacheType cacheType , NSURL * imageURL){
                    myRect([ImageBrowseViewCell calculateIimageViewFrame:image.size]);
                }];
            }
            else{
                CGPoint point =[UIApplication sharedApplication].keyWindow.center;
                myRect(CGRectMake(point.x, point.y, 0, 0));
            }
        }
    }
}


@end
