//
//  CustomAlertController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CustomAlertController.h"

typedef void(^__nullable CustomHandle)(UIAlertAction *action);
typedef  void (^ __nullable CustomIndexHandle)(UIAlertAction *action,NSInteger buttonIndex);
@interface CustomAlertController ()
@property(copy,nonatomic)CustomIndexHandle indexBlock;
@property(copy,nonatomic)CustomHandle block;
@end

@implementation CustomAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}


- (instancetype)init {
    self = [super init];
    if (self) {
        WEAKSELF
       _block = ^(UIAlertAction *action) {
           [weakSelf.actions enumerateObjectsUsingBlock:^(UIAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if (obj == action) {
                   [weakSelf clcikButtonWithAction:action andButtonIndex:idx];
                   *stop = YES;
               }
           }];
       };
        
    }
    return self;
}


+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                          preferredStyle:(UIAlertControllerStyle)preferredStyle
                       cancelButtonTitle:(nullable NSString *)cancelButton
                       otherButtonTitles:(nullable NSString *)otherButton, ...{
    
    CustomAlertController *alert = [self alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    va_list arguments;
    id eachObject;
    if (otherButton) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:otherButton style:UIAlertActionStyleDefault handler:alert.block];
        
        [alert addAction:action];
        va_start(arguments,otherButton);
        
        while ((eachObject = va_arg(arguments, id))) {
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:eachObject style:UIAlertActionStyleDefault handler:alert.block];
            
            [alert addAction:action];
            
        }
        va_end(arguments);
    }
    
    if (cancelButton) {
        [alert addCancleButton:cancelButton];
    }
    
    return  alert;
}


- (void)addButtonTitles:(NSString *)title, ... {
    va_list arguments;
    id eachObject;
    if (title) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:_block];
        
        [self addAction:action];
        va_start(arguments, title);
        
        while ((eachObject = va_arg(arguments, id))) {
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:eachObject style:UIAlertActionStyleDefault handler:_block];
            
            [self addAction:action];
            
        }
        va_end(arguments);
    }
    
    
}

- (void)addCancleButton:(NSString *)cancle otherButtonTitles:(NSString *)title, ... {
    
    va_list arguments;
    id eachObject;
    if (title) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:_block];
        
        [self addAction:action];
        va_start(arguments, title);
        
        while ((eachObject = va_arg(arguments, id))) {
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:eachObject style:UIAlertActionStyleDefault handler:_block];
            
            [self addAction:action];
            
        }
        va_end(arguments);
    }
    
    if (cancle) {
        [self addCancleButton:cancle];
    }
    
    
}


- (void)addCancleButton:(NSString *)title {
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:_block];
    
    [self addAction:action];
}

- (void)addButtonWithTitle:(NSString *)title andStyle:(UIAlertActionStyle)style {
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:_block];
    
    [self addAction:action];
}


- (void)didClickedButtonWithHandler:(void (^ __nullable)(UIAlertAction *action,NSInteger buttonIndex))handler{
     _indexBlock = handler;
 
}

- (void)clcikButtonWithAction:(UIAlertAction *)action andButtonIndex:(NSInteger)buttonIndex{
    
    if (_indexBlock) {
        _indexBlock(action,buttonIndex);
    }
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
