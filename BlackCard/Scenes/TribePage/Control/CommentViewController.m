//
//  CommentViewController.m
//  BlackCard
//
//  Created by xmm on 2017/5/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CommentViewController.h"
#import "BaseHttpAPI.h"
#import "UIViewController+Category.h"

@interface CommentViewController ()<UITextViewDelegate>
@property(strong,nonatomic)UITextView *textView;
@property(strong,nonatomic)UILabel *placeholderLabel;
@property(strong,nonatomic)UILabel *countLabel;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条内容
    [self setupNavgationBar];
    
    // 添加底部内容view
    [self setupBottomContentView];
    self.view.backgroundColor=kUIColorWithRGB(0xF8F8F8);
}
#pragma mark -设置导航条内容
-(void)setupNavgationBar{
    UIView *topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 64)];
    topView.backgroundColor=kUIColorWithRGB(0x434343);
    
    //返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(10, 25, 50, 30) ;
    [backBtn setImage:[UIImage imageNamed:@"icon-back"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 40);
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    
    //视图标题
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth/2-40,25,80 , 30)];
    titleLabel.text=@"评论";
    titleLabel.font=[UIFont systemFontOfSize:16];
    titleLabel.textColor=kUIColorWithRGB(0xFFFFFF);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    //发布按钮
    UIButton *publishBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame=CGRectMake(kMainScreenWidth-50, 25, 40, 30);
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    publishBtn.titleLabel.textColor=kUIColorWithRGB(0xFFFFFF);
    publishBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [publishBtn addTarget:self action:@selector(publishBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:publishBtn];
    
    [self.view addSubview:topView];
    
}
#pragma mark -设置视图内容
-(void)setupBottomContentView {
    //输入框
    _textView=[[UITextView alloc] initWithFrame:CGRectMake(10, 74, kMainScreenWidth-20, 150)];
    _textView.delegate=self;
    //placehoder
    _placeholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
    _placeholderLabel.text=@"此刻的想法...300字内";
    _placeholderLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _placeholderLabel.font=[UIFont systemFontOfSize:14];
    _placeholderLabel.textAlignment=NSTextAlignmentLeft;
    [_textView addSubview:_placeholderLabel];
    
    //监控字数
    _countLabel=[[UILabel alloc] initWithFrame:CGRectMake(kMainScreenWidth-100, 225, 80, 25)];
    _countLabel.text=@"0/300";
    _countLabel.font=[UIFont systemFontOfSize:12];
    _countLabel.textAlignment=NSTextAlignmentRight;
    _countLabel.textColor=kUIColorWithRGB(0xE4A63F);
    [self.view addSubview:_countLabel];
    [self.view addSubview:_textView];
    
}
#pragma mark -返回
-(void)backBtnClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -发布
-(void)publishBtnClicked {
    WEAKSELF

    [[AppAPIHelper shared].getMyAndUserAPI postTribeCommentTribeMessageId:@"89C97C660605430C834DFADFFFA5CFE6" message:_textView.text complete:^(id data) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } error:^(NSError *error) {
        [weakSelf showError:error];
    }];

}
#pragma mark -UITextView代理
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //监控占位符
    if (![text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _placeholderLabel.hidden = NO;
    }
    //控制输入字数
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = 300 - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
    
}
-(void)textViewDidChange:(UITextView *)textView{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > 300)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:300];
        
        [textView setText:s];
    }
    
    //不让显示负数
    _countLabel.text = [NSString stringWithFormat:@"%ld/300",existTextNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
