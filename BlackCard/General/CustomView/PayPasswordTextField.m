//
//  PayPasswordTextField.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "PayPasswordTextField.h"

@interface PayPasswordTextField ()<UITextFieldDelegate>
@property(nonatomic)double textWidth;
@property(nonatomic)double width;
@property(nonatomic)double textEdge;
@end

@implementation PayPasswordTextField


- (void)awakeFromNib{
    [super awakeFromNib];
    [self allSetting];
    
    
    
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self allSetting];
    }
    return self;
}

- (void)allSetting {
    [self fieldSetting];
    [self getTextWidth];
    [self settingText];
    [self payPasswordSetting];
    [self addChanged];
    
}


- (void)fieldSetting {
    self.borderStyle = UITextBorderStyleNone;
    self.layer.borderWidth = 1;
    self.layer.borderColor = kUIColorWithRGB(0xd7d7d7).CGColor;
    self.layer.cornerRadius = 3;
    [self setSecureTextEntry:YES];
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.tintColor = [UIColor clearColor];
    self.font = [UIFont systemFontOfSize:25];
    
}

-(void)payPasswordSetting {

    
    CGFloat width = _width;
     CGColorRef colorRef = kUIColorWithRGB(0xd7d7d7).CGColor;
    for (NSInteger i = 1 ; i < 6; i++) {
        CALayer *layer = [[CALayer alloc] init];
        layer.backgroundColor = colorRef;
        layer.frame = CGRectMake(width * i - 0.25, 0, 0.5, self.bounds.size.height);
        [self.layer addSublayer:layer];
    }
    
}

- (void)settingText{
    UIFont *font = self.font;

//    
    NSDictionary *dic = @{NSForegroundColorAttributeName : kUIColorWithRGB(0xD7D7D7),NSFontAttributeName :font,NSKernAttributeName : @(_textEdge)};
    self.defaultTextAttributes = dic;
    
    
    
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
//    [super borderRectForBounds:bounds];

    return  [self setNewRect:bounds];
}

- (CGRect)textRectForBounds:(CGRect)bounds{
//    [super borderRectForBounds:bounds];

    return  [self setNewRect:bounds];

}

- (CGRect)setNewRect:(CGRect)bounds {
    CGFloat width = (_textEdge) / 2.0;
    bounds.origin.x +=width;
    bounds.size.width += width + 10;
    return  bounds;
    
}


- (void)getTextWidth {

   
    
    self.textWidth =  [@"8" sizeWithAttributes:@{NSFontAttributeName :self.font}].width;
    
    self.width =self.bounds.size.width  > kMainScreenWidth ? (kMainScreenWidth - 40) / 6.0 : self.bounds.size.width  / 6.0;
    
    self.textEdge =  kSystemVersion >= 9.0 ?  (NSInteger)(_width - _textWidth) : _width - _textWidth - 1.5 ;
}

- (void)addChanged{
    self.delegate = self;
    [self addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        textField.text = nil;
    }
    return YES;
}


- (void)textChanged:(UITextField *)field{


    
    if ([self.changedDelegate respondsToSelector:@selector(textFieldChanged:)]) {
        [self.changedDelegate textFieldChanged:field];
    }
}




@end
