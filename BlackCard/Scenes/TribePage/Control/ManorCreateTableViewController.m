//
//  ManorCreateTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "ManorCreateTableViewController.h"
#import "CustomTextView.h"
#import "CustomPickView.h"
#import "AreaModel.h"
#import "ImageProvider.h"

@interface ManorCreateTableViewController ()<UITextViewDelegate,UITextFieldDelegate,OEZViewActionProtocol,ImageProvider_delegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *backImageButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseAddress;
@property (weak, nonatomic) IBOutlet UITextField *workTypeField;
@property (weak, nonatomic) IBOutlet CustomTextView *detailTextView;
@property(strong,nonatomic)CustomPickView  *pickerView;
@property(strong,nonatomic)CityLocationModel *locationModel;
@property(nonatomic, strong)ImageProvider * imageProvider;
@property(strong,nonatomic)UIImage *manorImage;


@end

@implementation ManorCreateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textViewSetting];
   
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.row == 1 ? (kMainScreenWidth - 24 )* 0.6 : [super tableView:tableView heightForRowAtIndexPath:indexPath];
    
}
- (IBAction)chooseImageAction:(UIButton *)sender {
    
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

- (void)hasSelectImage:(UIImage *)editedImage{
    _manorImage = editedImage;
    [self.backImageButton setTitle:nil forState:UIControlStateNormal];
    [self.backImageButton setImage:editedImage forState:UIControlStateNormal];
    
    
}
- (IBAction)chooseAddressAction:(UIButton *)sender {
    
    
    [self hideKeyboard];
    if (_locationModel != nil) {
        [self.pickerView inChooseLocation];
    }
    [self.view.window addSubview:self.pickerView];
}
- (IBAction)createButtonAction:(UIButton *)sender {
    NSString *name = self.nameField.text.trim;
    NSString *workType = self.workTypeField.text.trim;
    NSString *detail = self.detailTextView.text.trim;
    if ([NSString isEmpty:name]) {
        [self showTips:@"请输入部落名称"];
    }else if (!_manorImage){
        
        [self showTips:@"请选择部落背景图"];
        
    }else if (!_locationModel) {
        
        [self showTips:@"请选择部落地址"];
        
    }else if ([NSString isEmpty:workType]){
        
        [self showTips:@"请输入部落行业"];
    }else if ([NSString isEmpty:detail]){
        
        [self showTips:@"请输入简介"];
    }else {
        
        NSData *data = UIImageJPEGRepresentation(_manorImage, 0.5);
        NSDictionary *dic = @{@"name":name,
                              @"industry":workType,
                              @"province":_locationModel.state,
                              @"city":_locationModel.city,
                              @"description" : detail,
                              @"image" : data };
       
        WEAKSELF
     [[AppAPIHelper shared].getTribeAPI doCreateManorWihtDic:dic complete:^(id data) {
         
         [weakSelf showTips:@"申请成功,请等待审核"];
         [weakSelf createManorSuccess:nil];
         [weakSelf.navigationController popViewControllerAnimated:YES];
     } error:^(NSError *error) {
         [weakSelf showError:error];
     }];
    }
    
    
    
    
}


- (void)createManorSuccess:(id)data {
    if ([self.delegate respondsToSelector:@selector(manorCreateSuccess:)]) {
        [self.delegate manorCreateSuccess:data];
    }
    
}

- (void)view:(UIView *)view didAction:(NSInteger)action data:(id)data {
    switch (action) {
        case CustomPickViewStatus_Close:
            [_pickerView removeFromSuperview];
            break;
            
        case CustomPickViewStatus_Choose: {
            _locationModel = data;
            [_pickerView removeFromSuperview];
            [self locationButtonSetting:data];
            
        }
            break;
    }
    
    
}

- (void)locationButtonSetting:(CityLocationModel *)model {
    UIColor   *color = nil;
    NSString * string = nil;
    if (model) {
        string =  [NSString stringWithFormat:@"部落地址：%@-%@ ",model.state,model.city];
        color = kUIColorWithRGB(0x434343);
    }else {
        string =  @"选择部落地址";
        color =kUIColorWithRGB(0xa6a6a6);
        
    }
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:string attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont systemFontOfSize:14]}];
   
    [self.chooseAddress setAttributedTitle:attStr forState:UIControlStateNormal];
    
}
#pragma mark -UITextView代理
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
    
    
    if (![textView markedTextRange]) {
        
        NSString  *nsTextContent = textView.text;
        
        if (nsTextContent.length > 200)
        {
            //截取到最大位置的字符
            textView.text = [nsTextContent substringToIndex:200];
            
        }
    }
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
}

- (void)textViewSetting {
    
    [_detailTextView setPlaceHolder:@"请输入简介"];
    [_detailTextView settingScrollIndicatorInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [_detailTextView settingPlaceHolderTextColor:kUIColorWithRGB(0xA6A6A6)];
    _detailTextView.delegate=self;
    
    
}

#pragma mark - Table view data source
- (CustomPickView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [CustomPickView loadFromNib];
        _pickerView.delegate = self;
        _pickerView.frame = self.view.window.bounds;
        NSError *error = nil;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil];
        NSArray *array = [OEZPListModelAdapter modelsOfClass:[CityModel class] plistPath:filePath error:&error];
        [_pickerView update:array];
        
    }
    
    return _pickerView;
    
}

- (ImageProvider *)imageProvider {
    if (_imageProvider  == nil) {
        _imageProvider=[[ImageProvider alloc] init];
        _imageProvider.editPhotoFrame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth * 450 / 750);
        [_imageProvider setImageDelegate:self];
    }
    return _imageProvider;
}

@end
