//
//  EliteDetailTopTableViewCell.m
//  BlackCard
//
//  Created by xmm on 2017/5/29.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "EliteDetailTopTableViewCell.h"

@implementation EliteDetailTopTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //白色区域
        _whitView=[[UIView alloc] init];
        //文章标题
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(12,15,kMainScreenWidth-48,16)];
        //日期
        _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 38, 100, 9)];
        //时间
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(110,38,50,20)];
        
        //文章图片
        _articleIamge=[[UIImageView alloc] initWithFrame:CGRectMake(12,61,kMainScreenWidth-48 , (kMainScreenWidth-48)/2)];
        //文章内容
        _articleLabel=[[UILabel alloc] init];
        //分割线
        _partingLine=[[UILabel alloc] init];
        //阅读全文按钮
        _allBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_whitView addSubview:_titleLabel];
        [_whitView addSubview:_dateLabel];
        [_whitView addSubview:_timeLabel];
        [_whitView addSubview:_articleIamge];
        [_whitView addSubview:_articleLabel];
        [_whitView addSubview:_partingLine];
        [_whitView addSubview:_allBtn];
        [self.contentView addSubview:_whitView];
        self.backgroundColor=kUIColorWithRGB(0xF8F8F8);
        _whitView.backgroundColor=kUIColorWithRGB(0xFFFFFF);
        _whitView.layer.cornerRadius=5.0f;
    }
    return self;
}
-(void)setModel:(EliteLifeModel *)model{
    //标题
    _titleLabel.text=model.title;
    _titleLabel.font=[UIFont systemFontOfSize:16.0f];
    _titleLabel.textColor=kUIColorWithRGB(0x434343);
    _titleLabel.numberOfLines=1;
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    
    //日期
    _dateLabel.text=model.date;
    _dateLabel.font=[UIFont systemFontOfSize:11.0f];
    _dateLabel.textAlignment=NSTextAlignmentLeft;
    _dateLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _dateLabel.numberOfLines=1;
    _dateLabel.textAlignment=NSTextAlignmentLeft;
    
    //时间
    _timeLabel.text=model.time;
    _timeLabel.font=[UIFont systemFontOfSize:11.0f];;
    _timeLabel.textAlignment=NSTextAlignmentLeft;
    _timeLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _timeLabel.numberOfLines=1;
    _timeLabel.textAlignment=NSTextAlignmentLeft;
    
    //文章图片
    _articleIamge.image=[UIImage imageNamed:@"HomePageDefaultCard"];
    
    //文章内容
    _articleLabel.text=model.article;
    NSInteger length=model.article.length;
    if (length<=300)
    {
        _articleLabel.text=model.article;
    }else{
        NSString *string=[NSString stringWithFormat:@"%@...",[model.article substringToIndex:300]];
        _articleLabel.text=string;
    }
    _articleLabel.font=[UIFont systemFontOfSize:14];
    _articleLabel.numberOfLines=0;
    _articleLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _articleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize maximumLabelSize1 = CGSizeMake(kMainScreenWidth-48, 999);//labelsize的最大值
    CGSize expectSize1 = [_articleLabel sizeThatFits:maximumLabelSize1];
    _articleLabel.frame=CGRectMake(12, _articleIamge.frame.size.height+_articleIamge.frame.origin.y+15, kMainScreenWidth-48, expectSize1.height);
    _articleLabel.backgroundColor=[UIColor redColor];
    //分割线
    _partingLine.frame=CGRectMake(12, _articleLabel.frame.size.height+_articleLabel.frame.origin.y+15, kMainScreenWidth-48, 1) ;
    _partingLine.backgroundColor=kUIColorWithRGB(0xD7D7D7);
    
    //阅读全文
    _allBtn.frame=CGRectMake(12, _partingLine.frame.origin.y+_partingLine.frame.size.height, kMainScreenWidth-48, 44);
    [_allBtn setTitle:@"阅读全文" forState:UIControlStateNormal];
    _allBtn.titleLabel.font=[UIFont systemFontOfSize:14.0f];
    _allBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    [_allBtn setTitleColor:kUIColorWithRGB(0x434343) forState:UIControlStateNormal];
    _allBtn.titleEdgeInsets=UIEdgeInsetsMake(15,-10,15,kMainScreenWidth-108);
    [_allBtn setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
    _allBtn.imageEdgeInsets=UIEdgeInsetsMake(5, kMainScreenWidth-63, 5, 0);
    
    //白色区域frame
    _whitView.frame=CGRectMake(12, 20, kMainScreenWidth-24, _allBtn.frame.size.height+_allBtn.frame.origin.y);
    
    CGRect frame=self.frame;
    frame.size.height=_whitView.frame.size.height+_whitView.frame.origin.y;
    self.frame=frame;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
