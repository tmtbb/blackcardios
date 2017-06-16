//
//  CustomTextView.h
//  magicbean
//
//  Created by yaowang on 16/3/15.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UITextView

@property (weak,nonatomic)UIResponder *overrideNextResponder;


/**
 *  设置用户输入的标语
 *
 *  @param placeHolder <#placeHolder description#>
 */
- (void)setPlaceHolder:(NSString *)placeHolder;
/**
 *  设置标语颜色
 *
 *  @param placeHolderTextColor <#placeHolderTextColor description#>
 */
- (void)settingPlaceHolderTextColor:(UIColor *)placeHolderTextColor;

- (void)settingTextFont:(CGFloat )font placeHolderFont:(CGFloat )placeHolderFont;

/**
 *  获取自身文本占据有多少行
 *
 *  @return 返回行数
 */
- (NSUInteger)numberOfLinesOfText;

/**
 *  获取每行的高度
 *
 *  @return 根据iPhone或者iPad来获取每行字体的高度
 */
+ (NSUInteger)maxCharactersPerLine;

/**
 *  获取某个文本占据自身适应宽带的行数
 *
 *  @param text 目标文本
 *
 *  @return 返回占据行数
 */
+ (NSUInteger)numberOfLinesForMessage:(NSString *)text;

- (void)settingScrollIndicatorInsets:(UIEdgeInsets)insets;
- (void)settingtTextContainerInset:(UIEdgeInsets)insets;
@end
