//
//  WriteaApplicationTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/24.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "WriteaApplicationTableViewController.h"
#import "ValidateHelper.h"
#import "AreaModel.h"
#import "CustomPickView.h"
typedef NS_ENUM(NSInteger,WriteaApplicationType) {
    WriteaApplication_Phone       =  1000,
    WriteaApplication_Email,
    WriteaApplication_DetailAdd,
    WriteaApplication_Mark,
    WriteaApplication_TrueName,
    WriteaApplication_IdentityNum
};

@interface WriteaApplicationTableViewController ()<UITextFieldDelegate,OEZViewActionProtocol>

@property(strong,nonatomic)BlackCardModel *cardModel;
@property(copy,nonatomic)NSString * customizeName;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton *roughAddressButton;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *markField;
@property (weak, nonatomic) IBOutlet UITextField *trueNameField;
@property (weak, nonatomic) IBOutlet UITextField *identityNumberField;
@property(strong,nonatomic)CustomPickView  *pickerView;
@property(strong,nonatomic)CityLocationModel *locationModel;

@end

@implementation WriteaApplicationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingFieldPlaceholder];
    [self locationButtonSetting:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    switch (textField.tag) {
        case WriteaApplication_Phone:
        case WriteaApplication_DetailAdd:
        case WriteaApplication_Mark:
        case WriteaApplication_TrueName: {
            
            UITextField *field = [self.tableView viewWithTag:textField.tag + 1];
            return [field becomeFirstResponder];
            
        }
            
        case WriteaApplication_Email:
        case WriteaApplication_IdentityNum:{
            
            return [textField resignFirstResponder];
            
        }
            
    }
    
    
    return YES;
}

- (void)settingFieldPlaceholder {
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : kUIColorWithRGB(0xA6A6A6)};
    self.phoneField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入您的手机号码" attributes:dic];
     self.emailField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入您的电子邮箱" attributes:dic];
     self.detailAddressField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入您的详细地址" attributes:dic];
     self.markField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"备注（第二地址）" attributes:dic];
    

    
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:@"真实姓名" attributes:dic];
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:@"（我们将保密您的私人信息）" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : kUIColorWithRGB(0xE3A63F)}];
    [name appendAttributedString:string];
    
    NSMutableAttributedString *identity = [[NSMutableAttributedString alloc]initWithString:@"真实身份证号码" attributes:dic];
    [identity appendAttributedString:string];
    
    self.trueNameField.attributedPlaceholder = name;
    self.identityNumberField.attributedPlaceholder = identity;
    
    
    
    
}

- (IBAction)buttonAction:(id)sender {
    if ([self checkApplication]) {
        
        RegisterModel *model =  [[RegisterModel alloc]init];
        model.cardModel = _cardModel;
        model.blackcardId = _cardModel.blackcardId;
        model.phoneNum = self.phoneField.text;
        model.email = self.emailField.text;
        model.fullName = self.trueNameField.text;
        model.customName = self.customizeName ? _customizeName : @"";
        NSString *identity = self.identityNumberField.text.trim;
        model.identityCard = identity ? identity : @"";
        model.addr = self.detailAddressField.text.trim;
        model.addr1 = self.markField.text.trim;
        
        
        model.province = _locationModel.state;
        model.city = _locationModel.city;
        
  
        [self pushStoryboardViewControllerIdentifier:@"ConfirmApplicationTableViewController" block:^(UIViewController *viewController) {
            [viewController setValue:model forKey:@"model"];
        }];
 
        
        
        
        
  
    }
    
}





- (BOOL)checkApplication {
    NSError *error = nil;
    if (![[ValidateHelper shared] checkUserPhone:self.phoneField.text error:&error]) {
        [self showError:error];
       
    }else if (![[ValidateHelper shared] checkEmail:self.emailField.text error:&error]) {
        [self showError:error];
    }
    else if (_locationModel == nil) {
        [self showTips:@"请选择地区"];
    }
    else if ([NSString isEmpty:self.detailAddressField.text]) {
        [self showTips:@"请请输入详细地址"];
    }
//    else if ( [NSString isEmpty:self.markField.text]) {
//         [self showTips:@"请输入备注"];
//        
//    }
    else if ([NSString isEmpty:self.trueNameField.text]) {
         [self showTips:@"请输入姓名"];

    }else if (![NSString isEmpty:self.identityNumberField.text.trim]  && ![[ValidateHelper shared] checkPersonIdentityNumebr:self.identityNumberField.text error:&error]){
        [self showError:error];
        
    }else {
        
        return YES;
    }
 
    
    return NO;
    
}



- (IBAction)roughAddAction:(UIButton *)sender {
    [self hideKeyboard];
    if (_locationModel != nil) {
        [self.pickerView inChooseLocation];
    }
    [self.view.window addSubview:self.pickerView];

    
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
        string =  [NSString stringWithFormat:@"地区：%@-%@ ",model.state,model.city];
        color = kUIColorWithRGB(0x000000);
    }else {
       string =  @"地区：";
        color =kUIColorWithRGB(0xa6a6a6);
        
    }
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:string attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    NSTextAttachment *ment = [[NSTextAttachment alloc]init];
    ment.image = [UIImage imageNamed:@"locationDown"];
    [attStr appendAttributedString:[NSAttributedString attributedStringWithAttachment:ment]];
    [self.roughAddressButton setAttributedTitle:attStr forState:UIControlStateNormal];
    
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
@end
