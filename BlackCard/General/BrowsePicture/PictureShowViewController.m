//
//  PictureShowViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/16.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "PictureShowViewController.h"
#import "PictureController.h"
#import "PictureHandle.h"
@interface PictureShowViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,PictureControllerProcotol>
@property (strong,nonatomic) UIPageViewController *pageViewController;

@property(strong,nonatomic)NSArray *imageArray;
@property(strong,nonatomic)NSArray *rectArray;
@property(strong,nonatomic)NSNumber *index;
@property(strong,nonatomic)UILabel *pageLabel;
@property(nonatomic)NSInteger pageIndex;

@end

@implementation PictureShowViewController

- (instancetype)initWithImageArray:(NSArray<ImagesModel *> *)imageArray rectArray:(NSArray<NSString *> *)rectArray index:(NSNumber *)index {
    
    self = [super init];
    if (self) {
        self.imageArray = imageArray;
        self.rectArray = rectArray;
        self.index  = index;
        
    }
    return self;
}


+ (void)showInControl:(UIViewController *)control imageArray :(NSArray<ImagesModel *> *)imageArray rectArray:(NSArray<NSString *> *)rectArray index:(NSNumber *)index {
    PictureShowViewController *pic = [[PictureShowViewController alloc]initWithImageArray:imageArray rectArray:rectArray index:index];
   __block CGRect rect1 = CGRectFromString([rectArray objectAtIndex:index.integerValue]) ;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect1];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    ImagesModel *model = [imageArray objectAtIndex:index.integerValue];
    
    if ([NSString isEmpty:model.url]) {
        imageView.image = model.image;
        rect1.size = [PictureHandle imageScreenCalculateSize:model.image.size];
        
    }else if([NSString isEmpty:model.size]) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.url]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGSize size  =  [PictureHandle imageScreenCalculateSize:image.size];
            rect1.size = size;
        }];
        
    }else {
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.url]];
        rect1.size = [PictureHandle imageCalculateSize:model.size scale:2.0];
        
    }
    UIView  *view =[[UIView alloc]initWithFrame:control.view.window.bounds];
    view.backgroundColor = kUIColorWithRGBAlpha(0x000000, 1);
    [view addSubview:imageView];
    
    [control.view.window addSubview:view];

    
    rect1.origin = CGPointMake((kMainScreenWidth - rect1.size.width) / 2.0, (kMainScreenHeight - rect1.size.height) / 2.0);
    
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedDuration animations:^{
        imageView.frame = rect1;

    } completion:^(BOOL finished) {
        [control presentViewController:pic animated:NO completion:^{
            [view removeFromSuperview];
        }];
    }];
    
    
    
//    [UIView animateWithDuration:0.5 animations:^{
//        imageView.frame = rect1;
//        
//    } completion:^(BOOL finished) {
//        view.hidden = YES;
//        [control presentViewController:pic animated:NO completion:nil];
//        [view removeFromSuperview];
//        [control.view.window.layer removeAllAnimations];
//
//
//    }];
    
    
    
    
//    
//    
//    CATransition *animation = [CATransition animation];
//    animation.duration = 0.6;
//    animation.type = kCATransitionFade;
//    [control.view.window.layer addAnimation:animation forKey:nil];
//    [control presentViewController:pic animated:NO completion:^{
//        [control.view.window.layer removeAllAnimations];
//    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    NSInteger index = [_index integerValue];
    PictureController *pic = [PictureController pictureWithModel:_imageArray[index]];
    pic.delegate= self;
    pic.tag = index;
    _pageIndex = index + 1;
    [self.pageViewController setViewControllers:@[pic] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self pageLabelSetting];
}

- (void)pageLabelSetting {
     if (_imageArray.count > 1) {
    _pageLabel = [[UILabel alloc]initWithFrame: CGRectMake(20, kMainScreenHeight - 50, kMainScreenWidth - 40, 20)];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    _pageLabel.font = [UIFont systemFontOfSize:14];
    _pageLabel.textColor = [UIColor whiteColor];
    _pageLabel.text = [NSString stringWithFormat:@"[ %@/%@ ]",@(_index.integerValue + 1),@(_imageArray.count)];
   [self.view addSubview:_pageLabel];
    }
    
    
}
-(UIPageViewController *)pageViewController
{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.view.backgroundColor = [UIColor blackColor];;
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
        [self.view addSubview:_pageViewController.view];
        [self addChildViewController:_pageViewController];
    }
    return _pageViewController;
}

#pragma mark -PageViewController DataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = ((PictureController *)viewController).tag;
    
    if (index == 0) {
        return nil;
    }else {
        PictureController *pic = [PictureController pictureWithModel:_imageArray[--index]];
        pic.tag = index;
        pic.delegate= self;
        return pic;
    }
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = ((PictureController *)viewController).tag;
    
    if (index == _imageArray.count - 1) {
        return nil;
    }else {
        PictureController *pic = [PictureController pictureWithModel:_imageArray[++index]];
        pic.tag = index;
        pic.delegate = self;
        return pic;
    }
}

#pragma mark -PageViewController Delegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        
        PictureController *control = pageViewController.viewControllers.firstObject;
        _pageIndex = control.tag + 1;
        _pageLabel.text =  [NSString stringWithFormat:@"[ %@/%@ ]",@(_pageIndex),@(_imageArray.count)];
        
    }
    
}


- (void)pictureDidAction:(PictureControllerType)type data:(id)data {
    switch (type) {
        case PictureType_Dismiss:{
            UIView *view = [[UIView alloc]initWithFrame:self.view.window.bounds];
            UIImageView * imageV = data;
//            imageV.contentMode = UIViewContentModeScaleToFill;
            [view addSubview:imageV];
            [self.view.window  addSubview:view];
            NSUInteger index  = _pageIndex - 1;
            CGRect rect = CGRectFromString([_rectArray objectAtIndex:index]);
            
            
            [self dismissViewControllerAnimated:NO completion:nil];

            [UIView animateWithDuration:0.5 animations:^{
                imageV.frame = rect;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
            
            
            
            
            
            
//            [self dismissViewControllerAnimated:NO completion:^{
//                UIImageView * imageV = data;
//                UIView
//                
//                
//                
//                
//            }];
            
            
        }
            break;
            
        default:
            break;
    }
    
    
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}




@end
