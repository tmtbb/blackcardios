//
//  ImageBrowseViewController.m
//  douniwan
//
//  Created by ABX on 15/9/13.
//  Copyright (c) 2015年 yaowang. All rights reserved.
//

#import "ImageBrowseViewController.h"
#import "UIViewController+Category.h"
//#import "Masonry.h"
#import <OEZCommSDK/OEZPageView1.h>
#import "CacheHelper.h"
#import "ImageBrowseViewCell.h"
#import "MyAndUserAPI.h"
#import "CurrentUserActionHelper.h"
#define kMinWidth 20
#define kEdges 10
#define kImageBrowseViewCell @"ImageBrowseViewCell"

@interface ImageBrowseViewController ()<UIScrollViewDelegate,OEZPageViewDelegate,OEZViewActionProtocol>
{
    UIImage *_image;
    BOOL dismissNeedAnimation;
}
@property (nonatomic, strong) UIView *navView;
@property(nonatomic,strong)OEZPageView1 *pageView;
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong)UIImageView *animationImageView;
@property (nonatomic) NSInteger oldIndex;
@property (nonatomic, strong) UIButton *deleteBtn;
@end


@implementation ImageBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dismissNeedAnimation = YES;
    self.pageView = [[OEZPageView1 alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    self.pageView.pageControl.hidden = YES;
    [self.view addSubview:_pageView];
    [self.pageView registerNib:[UINib nibWithNibName:kImageBrowseViewCell bundle:nil] forCellReuseIdentifier:kImageBrowseViewCell];
    _oldIndex = _index;
    self.pageView.delegate = self;
    [self.pageView  setPageIndex:_index];
    
    
    [self creatNumberLabel];
    [self.view addSubview:[self customNav]];
    
}

- (UIView *)customNav {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, kMainScreenWidth, 64)];
        [_navView setBackgroundColor:kUIColor_Red];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(0, 20, 40, 40)];
        [backBtn setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:backBtn];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setFrame:CGRectMake(kMainScreenWidth - 50, 20, 40, 40)];
        [_deleteBtn setImage:[UIImage imageNamed:@"deleteImahe"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_deleteBtn];
    }
    return _navView;
}

- (void)back {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//浏览时删除照片
- (void)deleteImage {
    _deleteBtn.enabled = NO;
    
    CustomAlertController *sheet = [CustomAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet cancelButtonTitle:@"取消" otherButtonTitles:@"确定" ,nil];
    WEAKSELF
    [sheet didClickedButtonWithHandler:^(UIAlertAction * _Nullable action, NSInteger buttonIndex) {
        if (action.style != UIAlertActionStyleCancel ) {
            [weakSelf deleteOneImage];

        }
    }];
    
    [self presentViewController:sheet animated:YES completion:nil];
    

}

- (void)deleteOneImage {
    
    
    if( [self.images count] > _index && _index >= 0)
    {
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.images];
        NSMutableArray *rectArray = [NSMutableArray arrayWithArray:_rectArray];
        [array removeObjectAtIndex:self.index];
        [rectArray removeObjectAtIndex:self.index];
        self.images = array;
        _rectArray = rectArray;
        self.indexPath = [NSIndexPath indexPathForRow:_index inSection:self.indexPath.section];
        [[CurrentUserActionHelper shared] sender:self didIsDelete:self.indexPath];//通知外部删除
        if( array.count == _index ) {
             --_index;
        }
        if( _index >= 0  ) {
             [self reloadData:_index];
        }
        else {
            [self back];
        }
    }
    _deleteBtn.enabled = YES;
    
}

- (void)reloadData:(NSInteger)index {
    self.label.text = [NSString stringWithFormat:@"[%@/%@]",@(index + 1) ,@(_images.count)];
    if ([self.images count] == 0) {
        [self back];
    }
    else {
        [self.pageView reloadData];
        [self.pageView setPageIndex:index];
    }
   
}

- (void)creatNumberLabel{
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, kMainScreenHeight - 60, kMainScreenWidth, 20)];
    self.label.hidden = _images.count == 1 ? YES : NO;
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.label.text = [NSString stringWithFormat:@"[%@/%@]",@(_index + 1) ,@(_images.count)];
    self.label.textColor = [UIColor whiteColor];
    [self.view addSubview:_label];
    
    
}

-(NSInteger) numberPageCountPageView:(OEZPageView1 *)pageView{
    
    return _images.count;
}
- (OEZPageViewCell *)pageView:(OEZPageView *)pageView cellForPageAtIndex:(NSInteger)pageIndex{
    
    ImageBrowseViewCell *cell = [pageView dequeueReusableCellWithIdentifier:kImageBrowseViewCell];
    cell.delegate = self;
    [cell update:_images[pageIndex]];
    
    return cell;
    
    
}

- (void)pageView:(OEZPageView *)pageView didShowPageAtIndex:(NSInteger)pageIndex{
    
    self.label.text = [NSString stringWithFormat:@"[%@/%@]",@(pageIndex + 1) ,@(_images.count)];
    _index = pageIndex;
}


- (void)view:(UIView *)view didAction:(NSInteger)action data:(id)data{
    
    switch (action) {
        case 1:
        {
            if (self.isDelete) {
                WEAKSELF
                if (self.navView.frame.origin.y < 0) {
                    [UIView animateWithDuration:0.2 animations:^{
                        [weakSelf.navView setFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
                    }];
                }else {
                    [UIView animateWithDuration:0.2 animations:^{
                        [weakSelf.navView setFrame:CGRectMake(0, -64, kMainScreenWidth, 64)];
                    }];
                }
            } else {
                [self dismissViewControllerAnimated:NO completion:nil];
            }
        }
            break;
        case 2:
            [self showTips:@"无法加载图片" afterDelay:2.0];
            break;
        default: {
            if (!self.isDelete) { //如果有删除照片（发布里面），则不出现长按保存图片功能 add by caowei
                _image = data;
               
                
//                if (self.needJuBao && [CurrentUserHelper shared].isLogin) {
//             
//                    sheet = [CustomAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet cancelButtonTitle:@"取消" otherButtonTitles:@"保存图片",@"投诉",nil];
//                    
//                    
//                }
//                else {
//                    sheet = [CustomAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet cancelButtonTitle:@"取消" otherButtonTitles:@"保存图片",nil];
//                    sheet = [[CustomActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片",nil];
//                }
                
                BOOL  juBao = self.needJuBao && [CurrentUserHelper shared].isLogin;
                
                 CustomAlertController *sheet = [CustomAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet cancelButtonTitle:@"取消" otherButtonTitles:@"保存图片", juBao ? @"投诉" : nil ,nil];
                WEAKSELF
                [sheet didClickedButtonWithHandler:^(UIAlertAction * _Nullable action, NSInteger buttonIndex) {
                    if (action.style == UIAlertActionStyleCancel) {
                        
                    } else if (buttonIndex == 0) {
                        UIImageWriteToSavedPhotosAlbum(_image, self, nil, nil);
                        [weakSelf showTips:@"已保存至系统相册" afterDelay:1.0];
                    }
                    else {
                        
                        if ([weakSelf isLogin]) {
                
//                        APPLOG(@"投诉 %@",tab.selectedViewController);
                     
                            
                        }
                    }
                }];
                
                [self presentViewController:sheet animated:YES completion:nil];
                
            }
        }
            break;
    }
}




//#pragma mark - CustomActionSheetDelegate
//- (void)customAtionSheet:(CustomActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex != actionSheet.cancelButtonIndex) {
//        if (actionSheet.tag == 1001) {
//            if (buttonIndex == 0) {
//                UIImageWriteToSavedPhotosAlbum(_image, self, nil, nil);
//                [self showTips:@"已保存至系统相册" afterDelay:1.0];
//            }
//            else {
//                WEAKSELF
//                if ([self isLogin]) {
//                    UITabBarController * tab = (UITabBarController *)self.presentingViewController;
//                    UINavigationController * nav = (UINavigationController *)tab.selectedViewController;
////                    APPLOG(@"投诉 %@",tab.selectedViewController);
//                    [nav.viewControllers[0] pushViewControllerWithIdentifier:@"ComplaintViewController" animated:YES block:^(UIViewController *viewController) {
//                        dismissNeedAnimation = NO;
//                        [viewController setValue:@(1) forKey:@"complaintsType"];
//                        [viewController setValue:self.objectId forKey:@"objectId"];
//                        [weakSelf dismissViewControllerAnimated:NO completion:nil];
//                    }];
//                    
//                }
//            }
//        }
//        else if (actionSheet.tag == 1000) {
//            [self deleteOneImage];
//
//        }
//    } else {
//        _deleteBtn.enabled = YES;
//    }
//}

-(void)viewWillAppear:(BOOL)animated{
    self.view.hidden = YES;
    _animationImageView = [[UIImageView alloc]init];
    _animationImageView.contentMode = UIViewContentModeScaleAspectFill;
    //    _animationImageView.contentMode = UIViewContentModeScaleAspectFit;
    _animationImageView.clipsToBounds = YES;
    _animationImageView.frame = _imageRect;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    if (_images.count > _index) {
        WEAKSELF
        [ImageBrowseViewCell beginAnimationWith:_images[_index] imageView:_animationImageView rect:^(CGRect rect) {
            {
                if (rect.size.width > 0)
                {
                    [weakSelf.view.window addSubview:_animationImageView];
                    [UIView animateWithDuration:.2 animations:^{
                        _animationImageView.frame = rect;
                    } completion:^(BOOL finished) {
                        weakSelf.view.hidden = NO;
                        [_animationImageView removeFromSuperview];
                        _animationImageView = nil;
                        [UIApplication sharedApplication].statusBarHidden=YES;
                    }];
                }
                else
                {
                    _animationImageView = nil;
                    weakSelf.view.hidden = NO;
                }
            }
        }];
    }
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated{
    
    ImageBrowseViewCell *cell = (ImageBrowseViewCell *)[self.pageView cellForRowAtIndex:_index];
    UIImageView *imageView = cell.iImageView;
    imageView.frame = [ImageBrowseViewCell calculateIimageViewFrame:imageView.image.size];
    [imageView removeFromSuperview];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.view.window addSubview:imageView];
    
    imageView.userInteractionEnabled = YES;
    
//    WEAKSELF
//    if (_rectArray && dismissNeedAnimation)
//        [UIView animateWithDuration:0.5 animations:^{
//            if (_rectArray != nil)
//                imageView.frame =CGRectFromString( [_rectArray objectAtIndex:_index]);
//            else if (_index == _oldIndex && _imageRect.size.height != 0)
//                imageView.frame = _imageRect;
//            else
//            {
//                imageView.layer.cornerRadius = 6;
//                imageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
//                imageView.alpha = 0.1;
//            }
//        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
            [self.view.window.layer removeAllAnimations];
            [UIApplication sharedApplication].statusBarHidden=NO;
//        }];
//    else {
//        [imageView removeFromSuperview];
//        [weakSelf.view.window.layer removeAllAnimations];
//        [UIApplication sharedApplication].statusBarHidden=NO;
//    }
    
    [super viewWillDisappear:animated];
}


//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}
//
//
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}



@end
