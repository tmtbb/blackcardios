//
//  CardDetailBottomTableViewCell.m
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CardDetailBottomTableViewCell.h"

@implementation CardDetailBottomTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _headerImageView=[[UIImageView alloc] initWithFrame:CGRectMake(22, 10, 31,31)];
        //名称
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(63, 10, 100, 14)];
        //日期
        _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(63, 30, 60,10)];
        //时间
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(138, 30, 50, 10)];
        //白色区域
        _whiteView=[[UIView alloc] init];
        //评论内容
        _titleLabel=[[UILabel alloc] init];
        
        [self.contentView addSubview:_headerImageView];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_dateLabel];
        [self.contentView addSubview:_timeLabel];
        [_whiteView addSubview:_titleLabel];
        [self.contentView addSubview:_whiteView];
        self.backgroundColor=kUIColorWithRGB(0xF8F8F8);
        _whiteView.backgroundColor=kUIColorWithRGB(0xFFFFFF);
        self.userInteractionEnabled=YES;
//        self.isUserInteractionEnabled=YES;
    }
    return self;
}
-(void)setModel:(CommentListModel *)model{
    //头像
    UIImage *image=[UIImage imageNamed:@"HomePageDefaultCard"];
    image=[UIImage circleImage:image borderColor:[UIColor redColor] borderWidth:1.0f];
    _headerImageView.image=image;
    //名称
    _nameLabel.text=model.nickName;
    _nameLabel.textAlignment=NSTextAlignmentLeft;
    _nameLabel.font=[UIFont systemFontOfSize:12];
    _nameLabel.textColor=kUIColorWithRGB(0x434343);
    
    //日期
    _dateLabel.text=[NSString stringWithFormat:@"%ld",model.yearMonth];
    _dateLabel.textAlignment=NSTextAlignmentLeft;
    _dateLabel.font=[UIFont systemFontOfSize:10];
    _dateLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    
    //时间
    _titleLabel.text=[NSString stringWithFormat:@"%ld",model.yearMonth];
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    _titleLabel.font=[UIFont systemFontOfSize:10];
    _titleLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    
    //评论内容
    _titleLabel.text=model.comment;
    _titleLabel.font=[UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines=0;
    _titleLabel.textColor=kUIColorWithRGB(0x434343);
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize maximumLabelSize1 = CGSizeMake(kMainScreenWidth-98, 999);//labelsize的最大值
    CGSize expectSize1 = [_titleLabel sizeThatFits:maximumLabelSize1];
    _titleLabel.frame=CGRectMake(12, 15, kMainScreenWidth-98, expectSize1.height);
    //白色区域
    _whiteView.frame=CGRectMake(52, 52, kMainScreenWidth-76, _titleLabel.frame.size.height+30);
    _whiteView.layer.cornerRadius=5.0f;
    //cell的高度
    CGRect frame=self.frame;
    frame.size.height=_whiteView.frame.size.height+_whiteView.frame.origin.y+15;
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
