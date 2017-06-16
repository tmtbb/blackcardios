//
//  BaseWriteTextViewController.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/15.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextView.h"
@interface BaseWriteTextViewController : UIViewController
@property(strong,nonatomic)CustomTextView *textView;
-(void)backBtnClicked;
-(void)publishBtnClicked;

- (NSString *)rightBarTitle;


- (NSInteger)textCount;
- (NSString *)textViewPlaceHolder;

//去前后空格和未输出的字 
- (NSString *)textViewFinishingString ;
@end
