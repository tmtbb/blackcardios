//
//  MomentViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "MomentViewController.h"
#import "ImageProvider.h"
#import "CustomAlertController.h"

@interface MomentViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(strong,nonatomic)UITextView *textView;
@property(strong,nonatomic)UILabel *placeholderLabel;
@property(strong,nonatomic)UILabel *countLabel;
@property(assign,nonatomic)NSInteger selectTag;
@property(strong,nonatomic)NSMutableArray *imageArray;
@property(strong,nonatomic)NSArray *myArray;
@property(strong,nonatomic)NSMutableDictionary *imageDict;
@property(nonatomic, strong)ImageProvider * imageProvider;
@end

@implementation MomentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageArray=[NSMutableArray array];
    _imageDict=[[NSMutableDictionary alloc] init];
    _myArray=@[@"image1",@"image2",@"image3",@"image4",@"image5",@"image6"];
    // 设置导航条内容
    [self setupNavgationBar];
    
    // 添加底部内容view
    [self setupBottomContentView];
    self.view.backgroundColor=kUIColorWithRGB(0xF8F8F8);
}
#pragma mark -设置导航条内容
-(void)setupNavgationBar{
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
    topView.backgroundColor=kUIColorWithRGB(0x434343);
    
    //返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 20, 50, 40) ;
    [backBtn setImage:[UIImage imageNamed:@"icon-back"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 40);
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    
    //视图标题
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-40,25,80 , 30)];
    titleLabel.text=@"此刻";
    titleLabel.font=[UIFont systemFontOfSize:16];
    titleLabel.textColor=kUIColorWithRGB(0xFFFFFF);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    //发布按钮
    UIButton *publishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame=CGRectMake(kMainScreenWidth-50, 25, 40, 30);
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    publishBtn.titleLabel.textColor=kUIColorWithRGB(0xFFFFFF);
    publishBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    publishBtn.tag=200;
    [publishBtn addTarget:self action:@selector(publishBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:publishBtn];
    
    [self.view addSubview:topView];
    
}
#pragma mark -设置视图内容
-(void)setupBottomContentView {
    //输入框
    _textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 74, kMainScreenWidth-20, 150)];
    _textView.delegate=self;
    //placehoder
    _placeholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
    _placeholderLabel.text=@"此刻的想法...300字内";
    _placeholderLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _placeholderLabel.font=[UIFont systemFontOfSize:14];
    _placeholderLabel.textAlignment=NSTextAlignmentLeft;
    [_textView addSubview:_placeholderLabel];
    
    //监控字数
    _countLabel=[[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-100, 225, 80, 25)];
    _countLabel.text=@"0/300";
    _countLabel.font=[UIFont systemFontOfSize:12];
    _countLabel.textAlignment=NSTextAlignmentRight;
    _countLabel.textColor=kUIColorWithRGB(0xE4A63F);
    [self.view addSubview:_countLabel];
    [self.view addSubview:_textView];
    
    //分割线
    UILabel *partingLine=[[UILabel alloc] initWithFrame:CGRectMake(10, 255, kMainScreenWidth-20, 2)];
    partingLine.backgroundColor=kUIColorWithRGB(0xA6A6A6);
    [self.view addSubview:partingLine];
    
    CGFloat width=(kMainScreenWidth-40)/3;
    //上传图片
    for (int i=0; i<6; i++)
    {
        int a= i/3;
        int b= i%3;
        UIButton *photo=[UIButton buttonWithType:UIButtonTypeCustom];
        photo.frame=CGRectMake(10+b*(10+width), 265+a*(10+width), width,width );
        [photo setBackgroundImage:[UIImage imageNamed:@"addPhotos"] forState:UIControlStateNormal];
        [photo addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
        photo.tag=i+1;
            
        UIButton *delete=[UIButton buttonWithType:UIButtonTypeCustom];
        delete.frame=CGRectMake(width-30, 0,30 ,30 );
        [delete setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [delete addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        delete.hidden=YES;
        delete.tag=100+i+1;
        [photo addSubview:delete];
            
        [self.view addSubview:photo];
    
        
    }
    
}
#pragma mark -返回
-(void)backBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -发布
-(void)publishBtnClicked {
    for (NSString *key in _myArray)
    {
        if ([_imageDict valueForKey:key] !=nil)
        {
            [_imageArray addObject:[_imageDict objectForKey:key]];
        }
    }
    if (_textView.text.length==0&&_imageArray.count==0)
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"内容和图片不能同时为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    [self showLoader:@"消息发布中"];
    WEAKSELF
    [[AppAPIHelper shared].getMyAndUserAPI postMessageWithMessage:_textView.text imageArray:_imageArray complete:^(id data) {
        [weakSelf removeMBProgressHUD];
        [weakSelf showTips:@"消息发布成功"];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        [weakSelf removeMBProgressHUD];
        [weakSelf showError:error];
    }];
}
#pragma mark -选择图片
-(void)clickImage:(UIButton *)sender{
    _selectTag=sender.tag;
    UIButton *btn=[self.view viewWithTag:100+sender.tag];
    if (btn.hidden) {
        CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:@"上传照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addCancleButton:@"取消" otherButtonTitles:@"拍一张照片",@"从相册选择",nil];
        
        WEAKSELF
        [alert didClickedButtonWithHandler:^(UIAlertAction * _Nullable action, NSInteger buttonIndex) {
            if (action.style != UIAlertActionStyleCancel) {
                switch (buttonIndex) {
                    case 0:{
                        [weakSelf.imageProvider selectPhotoFromCamera];
                        
                    }
                        break;
                    case 1:{
                        
                        [weakSelf.imageProvider selectPhotoFromPhotoLibrary];
                    }
                        
                        break;
                }
                
            }
            
        }];
        [self presentViewController:alert animated:YES completion:nil];

    
    
    }

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //将image压缩
    UIButton *btn=[self.view viewWithTag:_selectTag];
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    UIButton *delBtn=[self.view viewWithTag:_selectTag+100];
    delBtn.hidden=NO;
    
    NSData *imageData= UIImageJPEGRepresentation(image, 0.5);//保存图片要以data形式，ios保存图片形式，压缩系数0.5
    
    [_imageDict setObject:imageData forKey:_myArray[_selectTag-1]];
}
-(void)deleteImage:(UIButton *)sender{
    UIButton *btn=[self.view viewWithTag:sender.tag-100];
    sender.hidden=YES;
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
//    [_imageDict setObject:@"" forKey:_myArray[sender.tag-100-1]];
    [_imageDict setValue:nil forKey:_myArray[sender.tag-100-1]];
    [btn setImage:[UIImage imageNamed:@"addPhotos"] forState:UIControlStateNormal];
}
#pragma mark -UITextView代理
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //监控占位符
    if (![text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _placeholderLabel.hidden = NO;
    }
    //控制输入字数
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = 300 - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
    
}
-(void)textViewDidChange:(UITextView *)textView{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > 300)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:300];
        
        [textView setText:s];
    }
    
    //不让显示负数
    _countLabel.text = [NSString stringWithFormat:@"%ld/300",existTextNum];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (ImageProvider *)imageProvider {
    if (_imageProvider  == nil) {
        _imageProvider=[[ImageProvider alloc] init];
        _imageProvider.editPhotoFrame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth);
        [_imageProvider setImageDelegate:self];
    }
    return _imageProvider;
}
- (void)hasSelectImage:(UIImage *)editedImage{
    
    UIButton *btn=[self.view viewWithTag:_selectTag];
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    [btn setBackgroundImage:editedImage forState:UIControlStateNormal];
    UIButton *delBtn=[self.view viewWithTag:_selectTag+100];
    delBtn.hidden=NO;
    
    NSData *imageData= UIImageJPEGRepresentation(editedImage, 0.5);//保存图片要以data形式，ios保存图片形式，压缩系数0.5

    
    [_imageDict setObject:imageData forKey:_myArray[_selectTag-1]];
    
    
}
#pragma mark -收回键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
