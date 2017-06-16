//
//  CustomTextView.m
//  magicbean
//
//  Created by yaowang on 16/3/15.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "CustomTextView.h"

@interface CustomTextView ()


@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic,strong)UIFont *placeHolderFont;
@property (nonatomic, strong) UIColor *placeHolderTextColor;
@property (nonatomic)BOOL isClearPlaceHolder;

@end
@implementation CustomTextView
- (UIResponder *)nextResponder {
    if (_overrideNextResponder != nil)
        return _overrideNextResponder;
    else
        return [super nextResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_overrideNextResponder != nil)
        return NO;
    else
        return [super canPerformAction:action withSender:sender];
}

#pragma mark - Setters

- (void)setPlaceHolder:(NSString *)placeHolder {
    if([placeHolder isEqualToString:_placeHolder]) {
        return;
    }
    
    NSUInteger maxChars = [CustomTextView maxCharactersPerLine];
    if([placeHolder length] > maxChars) {
        placeHolder = [placeHolder substringToIndex:maxChars - 8];
        placeHolder = [[placeHolder stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByAppendingFormat:@"..."];
    }
    _placeHolder = placeHolder;
    _isClearPlaceHolder = NO;
    [self setNeedsDisplay];
}

- (void)settingTextFont:(CGFloat)font placeHolderFont:(CGFloat)placeHolderFont {
    self.font = [UIFont systemFontOfSize:font];
    self.placeHolderFont = [UIFont systemFontOfSize:placeHolderFont];
    [self setNeedsDisplay];
}
- (void)settingPlaceHolderTextColor:(UIColor *)placeHolderTextColor {
    if([placeHolderTextColor isEqual:_placeHolderTextColor]) {
        return;
    }
    
    _placeHolderTextColor = placeHolderTextColor;
    [self setNeedsDisplay];
}

- (void)settingScrollIndicatorInsets:(UIEdgeInsets)insets {
    self.scrollIndicatorInsets = insets;
    insets.left -= 5;
    self.textContainerInset = insets;
//    [self layoutIfNeeded];
    [self setNeedsDisplay];
    
}

- (void)settingtTextContainerInset:(UIEdgeInsets)insets {
    
    self.textContainerInset = insets;
    //    [self layoutIfNeeded];
    [self setNeedsDisplay];
}
- (UIColor *)placeHolderTextColor {
    if (_placeHolderTextColor == nil) {
        _placeHolderTextColor = [UIColor lightGrayColor];
    }
    return _placeHolderTextColor;
}



#pragma mark - Message text view

- (NSUInteger)numberOfLinesOfText {
    return [CustomTextView numberOfLinesForMessage:self.text];
}

+ (NSUInteger)maxCharactersPerLine {
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 33 : 109;
}

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text {
    return (text.length / [CustomTextView maxCharactersPerLine]) + 1;
}

#pragma mark - Text view overrides

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

#pragma mark - Notifications

- (void)didReceiveTextDidChangeNotification:(NSNotification *)notification {
    [self setNeedsDisplay];
}

#pragma mark - Life cycle

- (void)setup {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveTextDidChangeNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.layoutManager.allowsNonContiguousLayout = NO;
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.font = [UIFont systemFontOfSize:14];
//    self.scrollIndicatorInsets = UIEdgeInsetsMake(13,10, 13, 10);
    self.userInteractionEnabled = YES;
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
//    self.textContainerInset = UIEdgeInsetsMake(12, 0, 13, 0);           // 调整光标位置  默认是（8 0 8 0） 调小需要微调 不建议输入条这么小
    self.textAlignment = NSTextAlignmentLeft;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
        
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self setup];
}


- (void)dealloc {
    _placeHolder = nil;
    _placeHolderTextColor = nil;
    _placeHolderFont = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];

    if([self.text length] == 0 && self.placeHolder) {
        CGRect placeHolderRect = CGRectMake(self.scrollIndicatorInsets.left,[self placeHolderTop:rect.origin.y],rect.size.width - 2 * self.scrollIndicatorInsets.left,rect.size.height);
        [self.placeHolderTextColor set];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            paragraphStyle.alignment = self.textAlignment;
            
            [self.placeHolder drawInRect:placeHolderRect
                          withAttributes:@{ NSFontAttributeName : self.placeHolderFont,
                                            NSForegroundColorAttributeName : self.placeHolderTextColor,
                                            NSParagraphStyleAttributeName : paragraphStyle }];
        _isClearPlaceHolder = NO;
        }
    else if (_isClearPlaceHolder == NO){
      _isClearPlaceHolder = YES;
       CGContextRef  context = UIGraphicsGetCurrentContext();
       CGContextClearRect(context, CGRectZero);
    }
    
//    if ([self.text length] > 1) {
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.lineSpacing = 4;// 字体的行间距
//        NSDictionary *attributes = @{
//                                     NSFontAttributeName:[UIFont systemFontOfSize:13],
//                                     NSParagraphStyleAttributeName:paragraphStyle};
//        self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
//    }
}
//-(UIColor*)placeHolderTextColor {
//    
//    if (_placeHolderTextColor == nil) {
//        
//    }
//    return _
//}



- (CGFloat)placeHolderTop:(CGFloat)y {
    
     CGFloat height  = y + self.scrollIndicatorInsets.top;
    height +=  (self.font.lineHeight -  self.placeHolderFont.lineHeight) / 2.0;
    return height;
    
}
- (UIFont *)placeHolderFont {
    
    if (_placeHolderFont == nil) {
        _placeHolderFont = self.font;
    }
    return _placeHolderFont;
}


@end
