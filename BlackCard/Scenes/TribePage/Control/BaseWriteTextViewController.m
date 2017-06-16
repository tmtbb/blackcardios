//
//  BaseWriteTextViewController.m
//  BlackCard
//
//  Created by abx’s mac on 2017/6/15.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "BaseWriteTextViewController.h"
#define kMaxTextCount 300

@interface BaseWriteTextViewController ()<UITextViewDelegate>
@property(strong,nonatomic)UILabel *countLabel;

@end

@implementation BaseWriteTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条内容
    [self setupNavgationBar];
    
    // 添加底部内容view
    [self setupBottomContentView];
    self.view.backgroundColor=kAppBackgroundColor;
}
-(void)setupNavgationBar{
    self.view.backgroundColor = kAppBackgroundColor;
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClicked)];
    backBar.imageInsets = UIEdgeInsetsMake(0,-8.5, 0, 8.5);
    self.navigationItem.leftBarButtonItem = backBar;
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:[self rightBarTitle] style:UIBarButtonItemStylePlain target:self action:@selector(publishBtnClicked)];
    
    self.navigationItem.rightBarButtonItem = right;
}

- (NSString *)rightBarTitle {
    
    return @"提交";
}

- (NSInteger)textCount {
    
    return kMaxTextCount;
}
#pragma mark -设置视图内容
-(void)setupBottomContentView {
    //输入框
    _textView=[[CustomTextView alloc] initWithFrame:CGRectMake(12, 64, kMainScreenWidth-24, 150)];
    [_textView setPlaceHolder:[self textViewPlaceHolder]];
    [_textView settingScrollIndicatorInsets:UIEdgeInsetsMake(20, 0, 22, 0)];
    [_textView settingPlaceHolderTextColor:kUIColorWithRGB(0xA6A6A6)];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.textColor = kUIColorWithRGB(0x434343);
    _textView.delegate=self;
    _textView.backgroundColor=[UIColor clearColor];
    
    //监控字数
    _countLabel=[[UILabel alloc] initWithFrame:CGRectMake(12, _textView.frameY + _textView.frameHeight - 22, kMainScreenWidth - 24, kFontHeigt(12))];
    _countLabel.text=[NSString stringWithFormat:@"0/%@",@([self textCount])];
    _countLabel.font=[UIFont systemFontOfSize:12];
    _countLabel.textAlignment=NSTextAlignmentRight;
    _countLabel.textColor=kUIColorWithRGB(0xE4A63F);
    
    //分割线
    
    CALayer *layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(12,  _textView.frameY + _textView.frameHeight, kMainScreenWidth-24, 1);
    layer.backgroundColor = kUIColorWithRGB(0xD7D7D7).CGColor;
    
    [self.view addSubview:_countLabel];
    [self.view addSubview:_textView];
    [self.view.layer addSublayer:layer];
    
}

- (NSString *)textViewPlaceHolder {
    
    return @"写下您的评论...";
}

-(void)backBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -发布
-(void)publishBtnClicked {
    
    
}
#pragma mark -UITextView代理
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
    
    
    if (![textView markedTextRange]) {
        
        NSString  *nsTextContent = textView.text;
        
        if (nsTextContent.length > [self textCount])
        {
            //截取到最大位置的字符
            textView.text = [nsTextContent substringToIndex:[self textCount]];
            
        }
        _countLabel.text = [NSString stringWithFormat:@"%@/%@",@(textView.text.length),@([self textCount])];
        //不让显示负数
    }
    
    
}

- (NSString *)textViewFinishingString {
    
    [self.textView replaceRange:self.textView.markedTextRange withText:@""];
    NSString *str = self.textView.text;
    return  str.trim;
}


#pragma mark -收回键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}
@end
