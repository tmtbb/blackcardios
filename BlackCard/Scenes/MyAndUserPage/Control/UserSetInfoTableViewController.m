//
//  UserSetInfoTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "UserSetInfoTableViewController.h"
#import "MyAndUserModel.h"
#import "CustomAlertController.h"
#import "ValidateHelper.h"
#import "ImageProvider.h"
#import "UIViewController+Category.h"
@interface UserSetInfoTableViewController ()<UITextFieldDelegate,ImageProvider_delegate>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *userIconVidew;
@property (weak, nonatomic) IBOutlet UITextField *blackCardNumField;
@property (weak, nonatomic) IBOutlet UITextField *userTrueNameField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;
@property (weak, nonatomic) IBOutlet UITextField *companyNameField;
@property (weak, nonatomic) IBOutlet UITextField *userJobField;
@property (weak, nonatomic) IBOutlet UITextField *userIdentityField;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneField;
@property (weak, nonatomic) IBOutlet UITextField *userEmailField;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UITableViewCell *jobCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *identityCell;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *changeButton;
@property (weak, nonatomic) IBOutlet UIView *myFootView;

@property(strong,nonatomic)UIImage *theNewIcon;

@property(nonatomic, strong)ImageProvider * imageProvider;


@property(strong,nonatomic)UserDetailModel *model;


@end

@implementation UserSetInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layerSetting];
    
    self.changeButton.title = nil;
    self.changeButton.enabled = NO;
  
    
    _myFootView.hidden = YES;
    [self userInformationHandle];

}


- (void)didRequest {
    
    [[AppAPIHelper shared].getMyAndUserAPI getUserDetailComplete:_completeBlock error:_errorBlock];
}

- (void)didRequestComplete:(UserDetailModel *)data {
    
    _model = data;
    _myFootView.hidden = NO;
    _changeButton.title = nil;
    _changeButton.enabled = NO;
    [self userInformationSetting];
    [super didRequestComplete:data];
}

- (void)userInformationSetting {
    [_userIconVidew sd_setImageWithURL:[NSURL URLWithString:_model.headUrl] placeholderImage:[UIImage imageNamed:@"userHeaderDefault"]];
    
    _blackCardNumField.text = _model.blackCardNo;
    _userTrueNameField.text = _model.fullName;
    _nickNameField.text = _model.nickName;
    [_sexButton setTitle:_model.sex forState:UIControlStateNormal];
    _companyNameField.text = _model.company;
    _userJobField.text = _model.position;
    
    _userEmailField.text = _model.email;
    
    if (![NSString isEmpty:_model.identityCard] && _model.identityCard.length >=16) {
        
        NSString *identity = [_model.identityCard stringByReplacingCharactersInRange:NSMakeRange(4, _model.identityCard.length - 4) withString:@"**************"];
      _userIdentityField.text = identity;
    }else {
        _userIdentityField.text = nil;
    }
    
    if (![NSString isEmpty:_model.phoneNum] && _model.phoneNum.length == 11) {
        NSString *phone = [_model.phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, _model.phoneNum.length - 3) withString:@"*********"];
        _userPhoneField.text = phone;
        
    }else{
        _userPhoneField.text = _model.phoneNum;
    }
    
    if ([NSString isEmpty:_model.identityCard]) {
        _userIdentityField.userInteractionEnabled = YES;
    }

    
    
}


- (void)userInformationHandle {

    NSArray *field = @[_nickNameField,_companyNameField,_userJobField,_userIdentityField,_userEmailField];
    
    [field enumerateObjectsUsingBlock:^(UITextField  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }];
//    for (NSInteger i = 0 ; i < 5; i++) {
//        UITextField *field = [self.tableView viewWithTag:100 + i];
//        [field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        
//    }
    
    
}







- (void)layerSetting {
    CALayer *layer = [[CALayer alloc]init];
    CGColorRef color = kUIColorWithRGB(0xd7d7d7).CGColor;
    CGRect    rect = CGRectMake(0, 19.5, kMainScreenWidth, 0.5);
    layer.backgroundColor = color;
    layer.frame = rect;
    [_headerView.layer addSublayer:layer];
    
    CALayer *logoutLayer = [[CALayer alloc]init];
    logoutLayer.backgroundColor = color;
    rect.origin.y = 30;
    logoutLayer.frame = rect;
    [_logoutButton.superview.layer addSublayer:logoutLayer];
    
    logoutLayer = [[CALayer alloc]init];
    logoutLayer.backgroundColor = color;
    rect.origin.y = 80;
    logoutLayer.frame = rect;
    [_logoutButton.superview.layer addSublayer:logoutLayer];
    
    logoutLayer = [[CALayer alloc]init];
    logoutLayer.backgroundColor = color;
    rect.origin.y = 0;
    logoutLayer.frame = rect;
    [_logoutButton.superview.layer addSublayer:logoutLayer];

//    
    CALayer *cellLayer = [[CALayer alloc]init];
    cellLayer.backgroundColor = color;
    rect.origin.y = 43.5;
    cellLayer.frame =  CGRectMake(0, 43.5, kMainScreenWidth, 0.5);
    [_jobCell.layer addSublayer:cellLayer];
    

    cellLayer = [[CALayer alloc]init];
    cellLayer.backgroundColor = color;
    rect.origin.y = 0;
    cellLayer.frame = rect;
    [_identityCell.layer addSublayer:cellLayer];
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _model ? [super numberOfSectionsInTableView:tableView] : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return 20;
       default:
            return 0.1;
    }
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 1:{
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 20)];
            return view;
                  }
        default:
            return nil;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 3:{
                
                [self pushStoryboardViewControllerIdentifier:@"SetPasswordTableViewController" block:nil];
            }
                break;
            case 4:{
                
                [self showTips:@"敬请期待"];
            }
                break;

        }
    }else if(indexPath.section == 0 && indexPath.row == 0) {
        
        [self chooseImageAction];
     
        
    }
}



- (void)chooseImageAction {
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
    if (self.changeButton.enabled == NO) {
        self.changeButton.title = @"完成";
        self.changeButton.enabled = YES;
    }
    self.userIconVidew.image = editedImage;
    _theNewIcon = editedImage;
    

}

- (void)upLoadImage:(void(^)(id data))complete error:(void(^)(NSError *error))error{
    NSData *data = UIImageJPEGRepresentation(_theNewIcon, 0.5);//保存图片要以data形式，ios保存图片形式，压缩系数0.5
    //    [self showLoader:@"正在上传头像..."];
    [[AppAPIHelper shared].getMyAndUserAPI doUpLoadUserHeaderIcon:data complete:complete error:error];

}


- (void)textFieldDidChange:(UITextField *)field {
    if (self.changeButton.enabled == NO) {
        self.changeButton.title = @"完成";
        self.changeButton.enabled = YES;
    }
    
    
}


- (IBAction)buttonAction:(id)sender {
    
    [[CurrentUserHelper shared] logout:self];
    
    [self setMainRootViewController:@"LoginViewController"];
    
    
}
- (IBAction)sexButtonAction:(UIButton *)sender {
    
    CustomAlertController *alert = [CustomAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addButtonTitles:@"男",@"女",@"保密",nil];
    
    WEAKSELF
    [alert didClickedButtonWithHandler:^(UIAlertAction * _Nullable action, NSInteger buttonIndex) {
        
        if (![weakSelf.model.sex isEqualToString:action.title]) {
            weakSelf.model.sex = action.title;
            [weakSelf.sexButton setTitle:action.title forState:UIControlStateNormal];
            weakSelf.changeButton.title = @"完成";
            weakSelf.changeButton.enabled = YES;
            
        }
    }];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)saveInformationAciotn:(UIBarButtonItem *)sender {
    
    _model.position = _userJobField.text  == nil ? @"" : _userJobField.text.trim;
    _model.email = _userEmailField.text.trim ;
    _model.nickName = _nickNameField.text.trim;
    _model.company = _companyNameField.text == nil ? @"" :_companyNameField.text.trim;
    _model.identityCard = [NSString isEmpty:_model.identityCard] ? _userIdentityField.text.trim : _model.identityCard;
    NSError *error = nil;
    if (![[ValidateHelper shared] checkEmail:_model.email error:&error]) {
        [self showError:error];
    }else if([NSString isEmpty:_model.nickName] ){
        [self showTips:@"昵称不能为空"];
    }else if (![[ValidateHelper shared] checkPersonIdentityNumebr:_model.identityCard error:&error]){
        
        [self showError:error];
    }else {
        [self showLoader:@"资料上传中..."];
        if (_theNewIcon) {
            WEAKSELF
            [self upLoadImage:^(id data) {
                weakSelf.model.headUrl = [data firstObject][@"url"];
                [weakSelf changeUserDetail];
                
                
            } error:^(NSError *error) {
                [weakSelf showError:error];
            }];
        }else {
            [self changeUserDetail];
        }
        
    }

}

- (void)changeUserDetail{
    NSError *error = nil;
    
    NSDictionary *dic = [OEZJsonModelAdapter jsonDictionaryFromModel:_model error:&error];
    if (error == nil) {
        WEAKSELF
        [[AppAPIHelper shared].getMyAndUserAPI  doChangeUserDetail:dic complete:^(id data) {
            [weakSelf saveUserInfo:weakSelf.theNewIcon];
            [weakSelf showTips:@"修改成功"];
            [weakSelf didRequest];
           
        } error:^(NSError *error) {
            [weakSelf showError:error];
        }];
    }else {
        [self showTips:@"修改失败"];
    }
   
}


- (void)saveUserInfo:(id )model {
    
    if ([self.delegate respondsToSelector:@selector(saveUserInformation:)]) {
        [self.delegate  saveUserInformation:model];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return  [textField resignFirstResponder];
}

- (ImageProvider *)imageProvider {
    if (_imageProvider  == nil) {
        _imageProvider=[[ImageProvider alloc] init];
        _imageProvider.editPhotoFrame = CGRectMake(0, 0, kMainScreenWidth, kMainScreenWidth);
        [_imageProvider setImageDelegate:self];
    }
    return _imageProvider;
}

@end
