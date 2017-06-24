//
//  ImagePickerTableViewController.m
//  magicbean
//
//  Created by cwytm on 16/3/21.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "ImagePickerTableViewController.h"
#import "SCImagePickerCell.h"
#import "UIViewController+Category.h"
#import "SCImageGroupPickerObject.h"
#import "TitleView.h"
#import "ImageGroupPickerView.h"
#import "UIViewController+LeeBase.h"
#import "ALAssetsLibraryHelper.h"
#define RowPicCount 3// 图片每行放3个

@interface ImagePickerTableViewController ()<OEZViewActionProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UITableView *imageTableView;

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) ALAssetsGroup   *assetsGroup;

@property (nonatomic, strong) NSMutableArray  *assetPhotos;
@property (nonatomic, strong) NSMutableArray  *assetGroups;//对象是SCImageGroupPickerObject
@property (nonatomic, strong) NSMutableArray  *saveGroups;//对象是ALAssetsGroup

@property (nonatomic,strong) UIBarButtonItem *doneButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) ImageGroupPickerView *imageGroupPickerView;
@property (nonatomic,strong) TitleView *titleView;
@property (nonatomic,assign) BOOL isTitleOpen;

@end

@implementation ImagePickerTableViewController

-(id)init {
    self = [super init];
    if (self) {
        self.assetPhotos = [[NSMutableArray alloc] init];
        self.assetGroups = [[NSMutableArray alloc] init];
        self.saveGroups = [[NSMutableArray alloc] init];
        self.sendPhotos = [[NSMutableArray alloc] init];
        self.maxPicCout = 9;
        [self initAssetPhotos];
    }
    return self;
}
- (void) initAssetPhotos {
    //初始照片 -- 链接拍照
    SCImagePickerObject *imagePickerObj = [[SCImagePickerObject alloc]init];
    imagePickerObj.isChecked = NO;
    imagePickerObj.picImage = [UIImage imageNamed:@"takePhoto_icon"];
    [self.assetPhotos addObject:imagePickerObj];
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPopoverTitleView];
    self.imageTableView = self.tableView;
    self.imageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.imageTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 1)];
//    [self.view addSubview:self.imageTableView];
    
    [self performSelector:@selector(addImageGroupPickerView) withObject:nil afterDelay:.1];
    [self getImageList];
}

#pragma mark - AddView

//获取标题
-(void)addPopoverTitleView {
    
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(62, 0, kMainScreenWidth - 70, 44)];
    self.titleView = [TitleView loadFromNib];
    _titleView.frame = CGRectMake((kMainScreenWidth - 150) / 2 - 62, 0, 150, 44);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewClicked)];
    [self.titleView addGestureRecognizer:tap];
    [view addSubview:_titleView];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.rightButton setTitleColor:kUIColorWithRGB(0xE4A63F) forState:UIControlStateHighlighted];
    self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.rightButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    [self.rightButton addTarget:self action:@selector(doneClicked) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.frame = CGRectMake(view.frameWidth - 80, 0, 80, 44);
    if (self.sendPhotos.count > 0) {
        [self.rightButton setTitle:[NSString stringWithFormat:@"发送(%@/%ld)",@(self.sendPhotos.count),(long)self.maxPicCout] forState:UIControlStateNormal];
    } else {
        
        [self.rightButton setTitle:@"发送" forState:UIControlStateNormal];
    }
    [view addSubview:_rightButton];
    
    
    self.navigationItem.titleView = view;
    
    
    
    
}

- (void)rightButtonSizeToFit {
    [self.rightButton setTitle:self.rightButton.titleLabel.text forState:UIControlStateHighlighted];
    [self.rightButton sizeToFit];
    self.rightButton.frameHeight = 44;
    CGFloat width = self.rightButton.frameWidth ;
    self.rightButton.frameX = self.rightButton.superview.frameWidth - width;
}

//获取相册弹出层
-(void)addImageGroupPickerView {
    self.imageGroupPickerView = [ImageGroupPickerView loadFromNib];
    [self.imageGroupPickerView setDelegate:self];
    self.imageGroupPickerView.frame = CGRectMake(0, - kMainScreenHeight, kMainScreenWidth, kMainScreenHeight);
    [self.view addSubview:self.imageGroupPickerView];
}
//获取照片
- (void) getImageList {
//    self.assetsLibrary = [ALAssetsLibraryHelper defaultAssetsLibrary];
    //通过该框架，我们可以获取相册列表：
    WEAKSELF
    [[ALAssetsLibraryHelper defaultAssetsLibrary] enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            //相册名字
            *stop = NO;
            //过滤成照片
            ALAssetsFilter *allPhotos = [ALAssetsFilter allPhotos];
            [group setAssetsFilter:allPhotos];
            
            SCImageGroupPickerObject *imageGroupPickerObj = [[SCImageGroupPickerObject alloc] init];
            imageGroupPickerObj.groupNameS = [group valueForProperty:ALAssetsGroupPropertyName];
            imageGroupPickerObj.groupImageNum =[group numberOfAssets];
            
            CGImageRef imageRef = [group posterImage]; //获得剪切区域
            UIImage *subIma = [UIImage imageWithCGImage:imageRef]; //转化成一张图片
            imageGroupPickerObj.groupImage = subIma;
            imageGroupPickerObj.assetsGroup = group;
            
            [weakSelf.assetGroups addObject:imageGroupPickerObj];
            [weakSelf.saveGroups addObject:group];
        } else {
            //默认进入第一层相册
            if (weakSelf.assetGroups.count > 0) {
                //进入相册weakSelf
//                SCImageGroupPickerObject *obj = [weakSelf.assetGroups objectAtIndex:weakSelf.assetGroups.count - 1];
//                weakSelf.titleView.titleL.text = obj.groupNameS;
//                weakSelf.assetsGroup = [weakSelf.saveGroups objectAtIndex:weakSelf.saveGroups.count - 1];
                
                NSInteger max = 0;
                SCImageGroupPickerObject *obj = nil;
                for (NSInteger i = 0; i < weakSelf.assetGroups.count; i ++) {
                    obj = weakSelf.assetGroups[i];
                    if (obj.groupImageNum >= max) {
                        max = obj.groupImageNum;
                        weakSelf.titleView.titleL.text = obj.groupNameS;
                        weakSelf.assetsGroup = weakSelf.saveGroups[i];
                    }
                }
                
                [weakSelf getImage];
            }
        }
    } failureBlock:^(NSError *error) {
        [weakSelf alertPower];
        APPLOG(@"Group not found!\n");
    }];
}

- (void) getImage {
    WEAKSELF
    //遍历每个group里面的照片
    [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index,BOOL *stop) {
         *stop = NO;
         // ALAsset的类型
         NSString *assetType = [result valueForProperty:ALAssetPropertyType];
         if ([assetType isEqualToString:ALAssetTypePhoto]){
             //缩略图
             UIImage * image = [UIImage imageWithCGImage:[result thumbnail]];

//             UIImage *image = (result.aspectRatioThumbnail == NULL)? nil: [UIImage imageWithCGImage:result.aspectRatioThumbnail] ;
//             UIImage *image = [UIImage imageWithCGImage:result.defaultRepresentation.fullScreenImage];
             
             dispatch_async(dispatch_get_main_queue(), ^(void) {
                 if (image != nil) {
                     SCImagePickerObject *imagePickerObj = [[SCImagePickerObject alloc]init];
                     imagePickerObj.picImage = image;
                     imagePickerObj.imagePath = result.defaultRepresentation.filename;//系统照片名称 - 0001.JPG
                     imagePickerObj.isChecked = [weakSelf isKeep:imagePickerObj].isChecked;
                     imagePickerObj.result = result;
                     [weakSelf.assetPhotos insertObject:imagePickerObj atIndex:1];
                     [weakSelf.imageTableView reloadData];
                 } else {
                     APPLOG(@"Failed to create the image.");
                 }
             });
         }
     }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.assetPhotos count] / RowPicCount;
    NSInteger backCount = [self.assetPhotos count] % RowPicCount == 0 ? count : count + 1;
    return backCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    static NSString *CellIdentifier = @"SCImagePickerCell";
    SCImagePickerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SCImagePickerCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier];
    }
    NSInteger count = [self.assetPhotos count]/RowPicCount;
    NSInteger backCount = [self.assetPhotos count] % RowPicCount == 0 ? count : count + 1;
    
    if (row == backCount - 1) {
        //最后一行
        [cell update:self.assetPhotos start:row * RowPicCount end:self.assetPhotos.count - 1];
    } else {
        [cell update:self.assetPhotos start:row * RowPicCount end:row * RowPicCount + 2];
    }
    WEAKSELF
    cell.isCheckedBlock = ^(int index) {
        NSInteger selectIndex = row * RowPicCount + index;
        if (selectIndex == 0) {
            [weakSelf takePhoto];
        } else {
            if (selectIndex < weakSelf.assetPhotos.count) {
                SCImagePickerObject *imagePickerObj = weakSelf.assetPhotos[selectIndex];
                imagePickerObj.isChecked = !imagePickerObj.isChecked;
                [weakSelf setDoneButtonText:imagePickerObj];
                [weakSelf.imageTableView reloadData];
            }
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SCImagePickerCell cellHeight];
}

#pragma mark - OEZViewActionProtocol
- (void) view:(UIView *)view  didAction:(NSInteger) action data:(id) data {
    if (action == kAction_ImageGroup) {
        NSInteger row = [(NSNumber*)data integerValue];
        self.assetsGroup = [self.saveGroups objectAtIndex:row];
        SCImageGroupPickerObject *obj = [self.assetGroups objectAtIndex:row];
        self.titleView.titleL.text = obj.groupNameS;
        [self.assetPhotos removeAllObjects];
        [self initAssetPhotos];
        [self getImage];
    }
    [self titleViewClicked];
}

#pragma mark - didAction
-(void)doneClicked {
    //点击确定，发送相应多张图片
    if ([self.delegate respondsToSelector:@selector(sendMuArrayPic:)]) {
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate sendMuArrayPic:self.sendPhotos];
    }
}
- (void) setDoneButtonText:(SCImagePickerObject *)selectObj {
    if (selectObj.isChecked == YES ) {
        if ([self.sendPhotos count] < self.maxPicCout) {
            [self.sendPhotos addObject:selectObj];
        } else {
            selectObj.isChecked = NO;
            [self showTips:[NSString stringWithFormat:@"图片最多发送%@张",@(self.maxPicCout)]];
        }
    } else {
        for (SCImagePickerObject *obj in self.sendPhotos) {
            if ([obj.imagePath isEqualToString:selectObj.imagePath]) {
                [self.sendPhotos removeObject:obj];
                break;
            }
        }
    }
    //确定按钮数值变化
    NSString *title = @"";
    if (self.sendPhotos.count > 0) {
        
        title = [NSString stringWithFormat:@"发送(%@/%@)",@(self.sendPhotos.count),@(self.maxPicCout)];
        [self.rightButton setTitle:title forState:UIControlStateNormal];

    } else {
        [self.rightButton setTitle:@"发送" forState:UIControlStateNormal];

    }
    [self rightButtonSizeToFit];
}

- (SCImagePickerObject *) isKeep:(SCImagePickerObject *)obj {
    SCImagePickerObject *imageObj = [[SCImagePickerObject alloc] init];
    for (int i = 0; i < self.sendPhotos.count; i ++) {
        imageObj.isChecked = NO;
        id data = self.sendPhotos[i];
        if ([data isKindOfClass:[SCImagePickerObject class]]) {
            SCImagePickerObject *imagePickerObject = (SCImagePickerObject *)data;
            if ([obj.imagePath isEqualToString:imagePickerObject.imagePath]) {
                imageObj.isChecked = YES;
                
                [self.sendPhotos replaceObjectAtIndex:i withObject:obj];//刷新对象
                break;
            }
        }
    }
    return imageObj;
}
-(void)titleViewClicked {
    self.isTitleOpen = !self.isTitleOpen;
    [self.titleView imageStateWith:self.isTitleOpen];
    if (self.isTitleOpen) {
        self.imageGroupPickerView.assetGroups = self.assetGroups;
        [self.imageGroupPickerView.tableView reloadData];
        [self.imageGroupPickerView show];
        
    } else {
        [self.imageGroupPickerView dismiss];
    }
    
    self.tableView.scrollEnabled = !self.isTitleOpen;

}

- (void) alertPower {
    //无权限提示
    CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:@"提示"
                                                                           message:@"请在iPhone的\"设置-隐私-照片\"选项中,允许精英管家访问你的照片" preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:@"确定" otherButtonTitles:nil];
    WEAKSELF
   [alert show:self didClicked:^(UIAlertAction *action, NSInteger buttonIndex) {
       [weakSelf.navigationController popViewControllerAnimated:YES];
   }];

}



#pragma mark - takePhoto拍照
- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    CustomImagePickerController *imagePickerController = [[CustomImagePickerController alloc] init];
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.edgesForExtendedLayout = UIRectEdgeNone;
    [self presentViewController:imagePickerController animated:YES completion:nil];  //需要以模态的形式展示
}
#pragma mark - UIImagePickerControllerDelegate(拍照+从相册选)
// 当得到照片或者视频后，调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if ([self.delegate respondsToSelector:@selector(sendTakePic:)]) {
        [self.navigationController popViewControllerAnimated:NO];
        [self.delegate sendTakePic:image];
    }
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);//将拍摄的照片保存到系统相册中去

    //    [self.icon setBackgroundImage:image forState:UIControlStateNormal];
    //    NSData *data = UIImageJPEGRepresentation(image, 0.5);//保存图片要以data形式，ios保存图片形式，压缩系数0.5
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

@implementation CustomImagePickerController


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
