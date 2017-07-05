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

#define kRegisterControllerCustomName 101
#define kRegisterControllerNoName 100

@interface RegisterTableViewController ()<UITextFieldDelegate,SubviewWithCollectionViewDelegate>
@property (weak, nonatomic) IBOutlet RegisterWithCollectionView *subCollctionView;
@property (weak, nonatomic) IBOutlet RegisterCardCell *cardCell;

@property(strong,nonatomic)CardListModel *model;
@property(strong,nonatomic)BlackCardModel *cardModel;
@property (weak, nonatomic) IBOutlet UIView *NameSettingView;
@property(strong,nonatomic)PrivilegePowerPoint *chooseLevel;
@property(nonatomic)NSInteger nameTag;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIView *pageCountView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIButton *useNameButton;
@property(nonatomic)NSInteger pageCount;
@property(nonatomic)NSInteger chooseCount;

@end

@implementation RegisterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chooseLevel = [PrivilegePowerPoint new];
    _subCollctionView.myDelegate = self;
    [self backButtonSetting];
    [self setNameButtonTransformWithTag:kRegisterControllerCustomName];
}

- (void)didRequest {
    WEAKSELF
    [[AppAPIHelper shared].getMyAndUserAPI getDeviceKeyWithComplete:^(id data) {
        [weakSelf myHttpPost];
        
    } withError:_errorBlock];
    
}

- (void)myHttpPost {
    
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
    
    [self pageRemoveFromView:_pageCount];
   _pageCount =  [_subCollctionView update:data.privileges];
    [self pageCountViewSetting];
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
    _levelLabel.text = [NSString stringWithFormat:@"%@专属特权",_cardModel.blackcardName];
    
    [_subCollctionView  reloadData];
    
    
    if (_cardModel.blackcardPrice == 0) {
        
        [self  setNameButtonTransformWithTag:kRegisterControllerNoName];
    }
    
    
}






//- (IBAction)levelButtonAction:(UIButton *)sender {
//    
//    [self setLevelButtonTransformWithTag:sender.tag];
//}

- (IBAction)nameButtonAction:(UIButton *)sender {
    if (_cardModel.blackcardPrice > 0) {
        [self setNameButtonTransformWithTag:sender.tag];
  
    }else {
        NSString *tips = [NSString stringWithFormat:@"%@暂不支持定制姓名",_cardModel.blackcardName];
        [self showTips:tips afterDelay:2.5];
    }
    
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
    [self pushStoryboardViewControllerIdentifier:@"WriteaApplicationTableViewController" block:^(UIViewController *viewController) {
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



- (void)pageCountViewSetting {
    
    CGFloat width = _pageCount * 8   + (_pageCount -1)* 1;
    CGFloat  x = (kMainScreenWidth - width) / 2.0;
    CGFloat  y =  (38 - 4) / 2.0;
    for (NSInteger i = 0 ; i < _pageCount; i++) {
        UIImageView *imageView =  [[UIImageView alloc]initWithFrame:CGRectMake(x + i * 9, y, 8, 4)];
        imageView.image = [UIImage imageNamed:@"pageCountPointNone"];
        imageView.tag = 100 + i;
        imageView.contentMode = UIViewContentModeCenter;
        [_pageCountView addSubview:imageView];
    }
    
    UIImageView *image = [_pageCountView viewWithTag:100 + _chooseCount];
    image.image = [UIImage imageNamed:@"pageCountPointChoose"];
    
}

- (void)pageRemoveFromView:(NSInteger)count{
    if (count != 0) {
        
        for (UIView *view  in _pageCountView.subviews) {
            if (view.tag >= 100) {
                [view removeFromSuperview];
            }
        }
        
    }
    
}

- (void)setChoosePageCount:(NSInteger)page {
    if (_chooseCount != page) {
        
        UIImageView *oldImage = [_pageCountView viewWithTag:100 + _chooseCount];
        UIImageView *image = [_pageCountView viewWithTag:100 + page];
        oldImage.image = [UIImage imageNamed:@"pageCountPointNone"];
        image.image = [UIImage imageNamed:@"pageCountPointChoose"];
        
        
        _chooseCount = page;
        
    }
}

- (void)view:(UIView *)view pageIndex:(NSInteger)pageIndex {
    
    [self setChoosePageCount:pageIndex];
}
- (IBAction)rightBarButtonAction:(UIBarButtonItem *)sender {
    
    
    [self pushWithIdentifier:@"WKWebViewController" complete:^(UIViewController *controller) {
      [controller setValue:kHttpAPIUrl_webCallWaiter forKey:@"url"];
    }];
    
    

    
    
}


@end
