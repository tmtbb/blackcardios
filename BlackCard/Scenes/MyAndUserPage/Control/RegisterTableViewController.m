//
//  RegisterTableViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "RegisterTableViewController.h"
#import "RegisterWithCollectionView.h"
#import "HomePageModel.h"
#import "RegisterCardCell.h"
#import "ValidateHelper.h"
@interface RegisterTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet SubviewWithCollectionView *subCollctionView;
@property (weak, nonatomic) IBOutlet RegisterCardCell *cardCell;

@property(strong,nonatomic)CardListModel *model;
@property(strong,nonatomic)BlackCardModel *cardModel;
@property (weak, nonatomic) IBOutlet UIView *NameSettingView;
@property(strong,nonatomic)PrivilegePowerPoint *chooseLevel;
@property(nonatomic)NSInteger nameTag;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@end

@implementation RegisterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chooseLevel = [PrivilegePowerPoint new];
    
    [self backButtonSetting];
    
    [self setNameButtonTransformWithTag:101];
}

- (void)didRequest {
    [[AppAPIHelper shared].getHomePageAPI cardListWithComplete:_completeBlock withError:_errorBlock];
    
}

- (void)didRequestComplete:(CardListModel *)data {
    _model = data;
    [super didRequestComplete:data.privileges];
    
    [self.cardCell update:data.blackcards];
    
    WEAKSELF
    [data.privileges enumerateObjectsUsingBlock:^(HomePageModel   *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.privilegePowerType = weakSelf.chooseLevel;
    }];
    
    
    [_subCollctionView update:data.privileges];
    [self.tableView reloadData];
}










- (void)setNameButtonTransformWithTag:(NSInteger)tag{
    if (_nameTag != tag) {
        [self transformWithSuperView:self.NameSettingView newTag:tag andLastTag:_nameTag];
        _nameTag = tag;
        
        _nameField.enabled = (tag - 100);
        if (!_nameField.enabled) {
            _nameField.text = nil;
        }
    }
}


- (void)transformWithSuperView:(UIView *)view newTag:(NSInteger)tag andLastTag:(NSInteger)lastTag{
    UIButton *button = [view viewWithTag:lastTag];
    if (lastTag > 0) {
        
        button.transform =CGAffineTransformMakeScale(1, 1);
        button.layer.borderWidth = 1;
        button.layer.borderColor = kUIColorWithRGB(0xA6A6A6).CGColor;
    }

    
    
    button = [view viewWithTag:tag];
    button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    button.layer.borderWidth = 2;
    button.layer.borderColor = kUIColorWithRGB(0xE3A63F).CGColor;
    
    
    
    
    
}

- (void)tableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath didSelectColumnAtIndex:(NSInteger)column {
    _cardModel = [_model.blackcards objectAtIndex:column];
    _chooseLevel.type = @(_cardModel.blackcardId);
    
    [_subCollctionView  reloadData];
    
    
}






//- (IBAction)levelButtonAction:(UIButton *)sender {
//    
//    [self setLevelButtonTransformWithTag:sender.tag];
//}

- (IBAction)nameButtonAction:(UIButton *)sender {

    [self setNameButtonTransformWithTag:sender.tag];
    
}
- (IBAction)backButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)nextButton:(UIButton *)sender {
    

    NSString *customizeName = nil;
    if (_chooseLevel.type == nil) {
        [self showTips:@"请选择会籍类型"];
        return;
    }
    if (_nameTag == 0) {
        [self showTips:@"请选择是否定制姓名"];
        return;
    }else if (_nameTag == 101) {
        NSError *error = nil;
        
        if (![[ValidateHelper shared] checkLetter:_nameField.text emptyString:@"请输入定制姓名" errorString:@"请输入正确的定制姓名" error:&error]) {
            [self showError:error];
            return;
        }
        customizeName = [_nameField.text uppercaseString];;
        
    }
    WEAKSELF
    [self pushMainStoryboardViewControllerIdentifier:@"WriteaApplicationTableViewController" block:^(UIViewController *viewController) {
        if (customizeName) {
             [viewController setValue:customizeName forKey:@"customizeName"];
        }
       
        [viewController setValue:weakSelf.cardModel forKey:@"cardModel"];
    }];
}

- (void)backButtonSetting {
    self.backButton.imageInsets = UIEdgeInsetsMake(0,-8.5, 0, 8.5);
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return [textField resignFirstResponder];
}

@end
