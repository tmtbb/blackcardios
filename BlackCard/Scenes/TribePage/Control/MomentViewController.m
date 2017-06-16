//
//  MomentViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "MomentViewController.h"
#import "ImageProvider.h"
#import "ImagePickerTableViewController.h"
#import "PhotosCollectionViewCell.h"
@interface MomentViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,SCImagePickerViewControllerDelegate>
@property(assign,nonatomic)NSInteger selectTag;
@property(strong,nonatomic)NSMutableArray<SCImagePickerObject *> *imageArray;
@property(strong,nonatomic)UICollectionView *photoCollectionView;
@property(assign,nonatomic)CGFloat itemWH;
@property(assign,nonatomic)CGFloat margin;
@end

@implementation MomentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"此刻";
    _imageArray=[NSMutableArray array];
       //添加图片内容
    [self configCollectionView];
}

#pragma mark -设置图片
- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (kMainScreenWidth - 16-2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    CGFloat y = self.textView.frameY + self.textView.frameHeight + 15;
    _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(8,y, kMainScreenWidth-16, kMainScreenHeight - y) collectionViewLayout:layout];
    _photoCollectionView.alwaysBounceVertical = YES;
    _photoCollectionView.backgroundColor = kAppBackgroundColor;
    _photoCollectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _photoCollectionView.dataSource = self;
    _photoCollectionView.delegate = self;
    _photoCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_photoCollectionView];
    [_photoCollectionView registerClass:[PhotosCollectionViewCell class] forCellWithReuseIdentifier:@"PhotosCell"];
}


- (NSString *)rightBarTitle {
    return @"发布";
}

- (NSString *)textViewPlaceHolder {
    
    return @"此刻的想法...";
}
#pragma mark -返回
-(void)backBtnClicked {
    
    NSString *str = [self textViewFinishingString];
    if (![NSString isEmpty:str] || _imageArray.count != 0){
        CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:@"提示" message:@"您已进行编辑是否退出" preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        WEAKSELF
        [alert show:self didClicked:^(UIAlertAction *action, NSInteger buttonIndex) {
           
            if (action.style != UIAlertActionStyleCancel) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [weakSelf hideKeyboard];
            }
            
        }];
        
        
    }else [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -发布
-(void)publishBtnClicked {
    
    NSString *str = [self textViewFinishingString];
    if ([NSString isEmpty:str]&&_imageArray.count == 0)
    {

        
        CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:nil message:@"内容和图片不能同时为空" preferredStyle:UIAlertControllerStyleAlert cancelButtonTitle:nil otherButtonTitles:@"确认",nil];
        
        [alert show:self didClicked:nil];
        
        
        return;
    }
    [self showLoader:@"消息发布中"];
    WEAKSELF
    NSMutableArray *array = [NSMutableArray array];
    [self.imageArray enumerateObjectsUsingBlock:^(SCImagePickerObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
      NSData *imageData= UIImageJPEGRepresentation(obj.picImage, 0.5);//保存图片要以data形式，ios保存图片形式，压缩系数0.5
        [array addObject:imageData];
    }];
    
    [[AppAPIHelper shared].getMyAndUserAPI postMessageWithMessage:str imageArray:array complete:^(id data) {
        [weakSelf removeMBProgressHUD];
        [weakSelf showTips:@"消息发布成功"];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        [weakSelf removeMBProgressHUD];
        [weakSelf showError:error];
    }];
}
#pragma mark -UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _imageArray.count + 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotosCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotosCell" forIndexPath:indexPath];
    if (indexPath.row == _imageArray.count) {
        cell.imageView.image = [UIImage imageNamed:@"addPhotos"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = _imageArray[indexPath.row].picImage;
        cell.deleteBtn.hidden = NO;
    }
    if (_imageArray.count==9&&indexPath.row == _imageArray.count)
    {
        cell.hidden=YES;
    }else{
        cell.hidden=NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _imageArray.count) {
        [self clickImage];
    }
}

#pragma mark -选择图片
-(void)clickImage{
    ImagePickerTableViewController *vc = [[ImagePickerTableViewController alloc] init];
    [vc.sendPhotos addObjectsFromArray:self.imageArray];
    vc.delegate = self;
    vc.maxPicCout = 9;
    [self.navigationController pushViewController:vc animated:YES];

}
- (void) sendMuArrayPic:(NSMutableArray<SCImagePickerObject *> *)sendPhotos{
    
    WEAKSELF
    self.imageArray = sendPhotos;
    [weakSelf.photoCollectionView reloadData];

}

- (void) sendTakePic:(UIImage*)sendTakePhoto{
    SCImagePickerObject *imagePickerObj = [[SCImagePickerObject alloc]init];
    imagePickerObj.isChecked = NO;
    imagePickerObj.picImage = sendTakePhoto;
    [self.imageArray  addObject:imagePickerObj];
    [self.photoCollectionView reloadData];
}

#pragma mark -删除图片
- (void)deleteBtnClik:(UIButton *)sender {
    [_imageArray removeObjectAtIndex:sender.tag];
    WEAKSELF
    [_photoCollectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [weakSelf.photoCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [weakSelf.photoCollectionView reloadData];
    }];
}



@end
