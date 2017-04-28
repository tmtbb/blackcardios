//
//  CustomPickView.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CustomPickView.h"
#import "AreaModel.h"
@interface CustomPickView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(strong,nonatomic)NSArray<CityModel *> *dataArray;
@property(strong,nonatomic)CityModel *cityModel;
@property(strong,nonatomic)CityLocationModel *locationModel;
@property(strong,nonatomic)NSIndexPath *index;
@end

@implementation CustomPickView


- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [self addGestureRecognizer:tap];
    _locationModel = [[CityLocationModel alloc]init];
    _index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self setColorWithPickView];
}
- (void)update:(id)data {
    _dataArray = data;
    _cityModel = _dataArray.firstObject;
    _locationModel.state = _cityModel.state;
    _locationModel.city = _cityModel.cities.firstObject;
    [_pickerView reloadAllComponents];
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    switch (component) {
        case 0:
            return _dataArray.count;
        case 1:
            
            return  _cityModel.cities.count;
            
        default:
            return 0;
    }
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            
            return _dataArray[row].state;
        case 1:
            
            
            return _cityModel.cities[row];
            
        default:
            return nil;
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:{
            _cityModel = _dataArray[row];
            _locationModel.state = _cityModel.state;
            _locationModel.city = _cityModel.cities.firstObject;
            _index = [NSIndexPath indexPathForRow:0 inSection:row];
            
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView reloadComponent:1];
            
        }
        
            break;
         case 1:
            _locationModel.city = _cityModel.cities[row];
            _index = [NSIndexPath indexPathForRow:row inSection:_index.section];
    
            break;
    }
    
}

- (void)inChooseLocation {
    _cityModel = _dataArray[_index.section];
    [self.pickerView selectRow:_index.section inComponent:0 animated:NO];
    [self.pickerView selectRow:_index.row inComponent:1 animated:NO];
    

    
}


- (void)setColorWithPickView  {
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)kUIColorWithRGBAlpha(0xffffff, 1.0).CGColor, (__bridge id)kUIColorWithRGBAlpha(0xffffff, 0.8).CGColor, (__bridge id)kUIColorWithRGBAlpha(0x434343, 0.3).CGColor];
    
    gradientLayer.locations = @[@0.2, @0.8, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 1.0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    gradientLayer.frame = CGRectMake(0, kMainScreenHeight - 216 , kMainScreenWidth , 216);
    [self.layer insertSublayer:gradientLayer below:_pickerView.layer];
    
    
}

- (void)tapAction:(UIGestureRecognizer *)sender {
    
    [self didAction:CustomPickViewStatus_Close];
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    
    [self didAction:CustomPickViewStatus_Choose data:_locationModel];
    
}

@end
