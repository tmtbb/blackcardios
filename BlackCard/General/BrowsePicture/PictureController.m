//
//  PictureController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/16.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "PictureController.h"
#import "PictureHandle.h"
#import "CacheHelper.h"

@interface PictureController ()<UIScrollViewDelegate>
@property(strong,nonatomic)ImagesModel *model;
@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UIActivityIndicatorView *activity;
@property(strong,nonatomic)UIScrollView *iScrollView;

@end

@implementation PictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.iScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.iScrollView.contentSize = self.view.bounds.size;
    self.iScrollView.zoomScale = 1.0;
    self.iScrollView.maximumZoomScale =  5.0;
    self.iScrollView.minimumZoomScale = 0.5;
    self.iScrollView.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.iScrollView addGestureRecognizer:tap];
    [self.view addSubview:_iScrollView];
    [self imageShow:nil];
    
    
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    self.iScrollView.zoomScale = 1.0;
    
}

- (instancetype)initWithModel:(ImagesModel *)model {
    self = [super init];
    if (self) {
        self.model = model;
        
    }
    
    return self;
    
}

+ (instancetype)pictureWithModel:(ImagesModel *)model {
    return  [[PictureController alloc]initWithModel:model];
}


- (void)imageShow:(ImagesModel *)model{
    
    self.imageView.frame = self.view.bounds;
    [self.activity stopAnimating];
    if (_model.image) {
        self.imageView.image = _model.image;
    }
    else if(![NSString isEmpty:_model.url]){
        WEAKSELF
        NSString *smallUrl = _model.url;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
            NSString *bigStringUrl = [PictureHandle bigImageUrl:smallUrl];
             UIImage *bigImage = [PictureHandle findImgae:bigStringUrl];
                if (bigImage) {
                    
                    
                    
                    CGSize size = [self imageSize:bigImage.size];
                    self.imageView.frameSize = size;
                    self.imageView.center = weakSelf.view.center;
                    
                    self.imageView.image = bigImage;

                }else {
                    [self.activity startAnimating];
                    UIImage *image = [PictureHandle findImgae:smallUrl];
                    _imageView.frame = self.view.bounds;
                    _imageView.contentMode = UIViewContentModeCenter;
                    if (![NSString isEmpty:_model.size]) {
                     _imageView.contentMode = UIViewContentModeScaleAspectFill;
                     _imageView.frameSize =  [PictureHandle imageCalculateSize:_model.size scale:2];
                     _imageView.center = weakSelf.view.center;
                        [_imageView sd_setImageWithURL:[NSURL URLWithString:bigStringUrl] placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            [weakSelf.activity stopAnimating];
                        }];
                        
                        
                    }else [_imageView sd_setImageWithURL:[NSURL URLWithString:bigStringUrl] placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        CGSize size = [weakSelf imageSize:image.size];
                        _imageView.contentMode = UIViewContentModeScaleAspectFill;
                        
                        weakSelf.imageView.frame = CGRectMake(0, 0, size.width, size.height);
                        weakSelf.imageView.center = weakSelf.view.center;
                        [weakSelf.activity stopAnimating];
                    }];
                    
                }
                
                
                
    }
    
    
    
    
}


- (CGSize )imageSize:(CGSize)size {
    if ([NSString isEmpty:_model.size]) {
        
        return [PictureHandle imageCalculateSize:size];
    }else {
        
        return [PictureHandle imageCalculateSize:_model.size scale:2];
    }
    
}



- (UIImageView *)imageView {
    if (_imageView  == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(iImageViewLongPress:)];
        [_imageView addGestureRecognizer:longPress];
        [self.iScrollView addSubview:_imageView];
    }
    
    return _imageView;
}
- (void)iImageViewLongPress:(UILongPressGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
    }
    else if (sender.state == UIGestureRecognizerStateBegan)
    {
//        UIImage *image = [self saveImageWithData:_data];
//        if (image)
//        {
//            [self didAction:3 data:image];
//        }
        
    }
}
-(UIActivityIndicatorView *)activity {
    if (_activity == nil) {
        _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activity.center = self.view.center;
        [self.view addSubview:_activity];
        
    }
    return _activity;
}

- (void)tapAction:(UIGestureRecognizer *)sender {
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:_imageView.frame];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image  = _imageView.image;
    [self didAction:PictureType_Dismiss data:imageView];
}


-(void)didAction:(PictureControllerType )type data:(id)data {
    if ([self.delegate respondsToSelector:@selector(pictureDidAction:data:)]) {
        [self.delegate pictureDidAction:type data:data];
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat xcenter = scrollView.center.x;
    CGFloat ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 2.0 : xcenter;
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height / 2.0 : ycenter;
    
    self.imageView.center = CGPointMake(xcenter, ycenter);
}


@end
