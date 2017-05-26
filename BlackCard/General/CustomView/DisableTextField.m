//
//  DisableTextField.m
//  BlackCard
//
//  Created by abx’s mac on 2017/5/23.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "DisableTextField.h"

@implementation DisableTextField

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    UIMenuController*menuController = [UIMenuController sharedMenuController];
    
    if(menuController) {
        
        [UIMenuController sharedMenuController].menuVisible=NO;
        
    }
    
    return NO;
    
}

@end
