//
//  ImageFromIphone.m
//  WanziTG
//
//  Created by TaeYoona on 15/4/9.
//  Copyright (c) 2015年 wanzi. All rights reserved.
//

#import "ImageProvider.h"
#import <UIKit/UIKit.h>

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "VPImageCropperViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
//#import "UIView+Extension.h"

@interface ImageProvider ()
<
UINavigationControllerDelegate, UIImagePickerControllerDelegate, VPImageCropperDelegate // 截取图片部分
>
@property(nonatomic, weak)id<ImageProvider_delegate> imageProvider_delegate;
@property(nonatomic, weak)UIViewController * superVC;

@end

@implementation ImageProvider

- (void)setImageDelegate:(id)oneDelegate
{
    self.imageProvider_delegate=oneDelegate;
    self.superVC=(UIViewController *)self.imageProvider_delegate;
}

- (void)selectPhotoFromPhotoLibrary
{
    if ([self isPhotoLibraryAvailable]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [self.superVC presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     APPLOG(@"Picker View Controller is presented");
                                     
                                 }];
    }
}

- (void)selectPhotoFromCamera
{
    if (![self CameraIsEnabled]) {
        UIAlertView * oneAV=[[UIAlertView alloc] initWithTitle:@"警告" message:@"请在iPhone的“设置-隐私-相机”选项中，允许无限黑卡访问您的相机。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [oneAV show];
        return;
    }
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        //if ([self isFrontCameraAvailable]) {
        //    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        //}
        if ([self isRearCameraAvailable]) {
            controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self.superVC presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     APPLOG(@"Picker View Controller is presented");
                                 }];
    }
}

//- (void)didClickOnDestructiveButtonWithID:(LXActionSheet *)theLXActionSheet;
//{
//    NSLog(@"destructuctive");
//}
//
//- (void)didClickOnCancelButtonWithID:(LXActionSheet *)theLXActionSheet;
//{
//    NSLog(@"cancelButton");
//    if (theLXActionSheet==self.reUploadImageActionSheet) {
//
//    }
//}


#pragma mark [设置头像]
#pragma mark VPImageCropperDelegate
- (void)imageCropper:(UIViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    WEAKSELF
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.imageProvider_delegate && [weakSelf.imageProvider_delegate respondsToSelector:@selector(hasSelectImage:)]) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            [weakSelf.imageProvider_delegate hasSelectImage:editedImage];
        }
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    WEAKSELF
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.imageProvider_delegate && [weakSelf.imageProvider_delegate respondsToSelector:@selector(desSelectImage)]) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            [weakSelf.imageProvider_delegate desSelectImage];
        }
    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    WEAKSELF
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //[NSAssistant saveImage:portraitImg To:[NSString stringWithFormat:@"%@/wkq_001.png", self.oneS.cachesPath]];// 当初测试第三方列表.
        if (weakSelf.isAutoImageFrame) {
            // 不进行剪切
            portraitImg =[weakSelf imageByScalingAndCroppingForSourceImage:portraitImg targetSize:portraitImg.size];
            if (weakSelf.imageProvider_delegate && [weakSelf.imageProvider_delegate respondsToSelector:@selector(hasSelectImage:)]) {
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                [weakSelf.imageProvider_delegate hasSelectImage:portraitImg];
            }
            return ;
        }
        portraitImg = [weakSelf imageByScalingToMaxSize:portraitImg];
        // 裁剪
        if (CGRectEqualToRect(weakSelf.editPhotoFrame, CGRectZero)) {
            weakSelf.editPhotoFrame=CGRectMake(0, 0, weakSelf.superVC.view.frame.size.width, weakSelf.superVC.view.frame.size.width);
        }
        weakSelf.editPhotoFrame=CGRectMake(0, (kMainScreenHeight-weakSelf.editPhotoFrame.size.height)/2, weakSelf.editPhotoFrame.size.width
                                       , weakSelf.editPhotoFrame.size.height);
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:weakSelf.editPhotoFrame limitScaleRatio:3.0];
        imgEditorVC.delegate = weakSelf;
        [weakSelf.superVC presentViewController:imgEditorVC animated:NO completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (self.imageProvider_delegate && [self.imageProvider_delegate respondsToSelector:@selector(desSelectImage)]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.imageProvider_delegate desSelectImage];
    }
    [picker dismissViewControllerAnimated:YES completion:^(){
        
    }];
}



#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark - 裁切图片
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < kMainScreenWidth) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = kMainScreenWidth;
        btWidth = sourceImage.size.width * (kMainScreenWidth / sourceImage.size.height);
    } else {
        btWidth = kMainScreenWidth;
        btHeight = sourceImage.size.height * (kMainScreenWidth / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) APPLOG(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 检测相机 相册权限
- (BOOL)CameraIsEnabled {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];      //获取对相机的权限
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted)
        return NO;
    return YES;
}

- (BOOL)PicLibraryIsEnabled {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];                           //获取对相册的权限
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    return YES;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.automaticallyAdjustsScrollViewInsets = NO;
    if ([NSStringFromClass([viewController class]) isEqualToString:@"PUUIAlbumListViewController"])
    {
        for (UIView * view in viewController.view.subviews) {
            if ([view isKindOfClass:[UITableView class]]) {
                view.frameY = 64;
                view.frameHeight = kMainScreenHeight - 64;
                break;
            }
        }
    }
    if ([NSStringFromClass([viewController class]) isEqualToString:@"PUUIPhotosAlbumViewController"]) {
        for (UIView * view in viewController.view.subviews) {
            if ([view isKindOfClass:[UICollectionView class]]) {
                view.frameY = 64;
                view.frameHeight = kMainScreenHeight - 64;
                break;
            }
        }
    }
    
}
@end
