//
//  CardDetailTopTableViewCell.m
//  BlackCard
//
//  Created by xmm on 2017/5/27.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "CardDetailTopTableViewCell.h"

@implementation CardDetailTopTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //头像
        _headerImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10,10 , 41, 41)];
        _levelImageView=[[UIImageView alloc] initWithFrame:CGRectMake(28, 31, 10, 10)];
        [_headerImageView addSubview:_levelImageView];
        //名字
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(56, 10, 100, 20)];
        //日期
        _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(56, 30, 90, 20)];
        //时间
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(146, 30, 100, 20)];
        //白色区域
        _whiteView=[[UIView alloc] init];
        _whiteView.layer.cornerRadius=5.0f;
        //文章内容
        _titleLabel=[[UILabel alloc] init];
        //图片区域
        _showImageView=[[UIView alloc] init];
        //点赞按钮
        _praiseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //点赞数
        _praiseLabel=[[UILabel alloc] init];
        //评论
        _commentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //评论数
        _commentLabel=[[UILabel alloc] init];
        //更多
        _moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //更多label
        _moreLabel=[[UILabel alloc] init];
        //评论标题
        _listTitle=[[UILabel alloc] init];
        //下划线
        _underLine=[[UILabel alloc] init];
        
        [self.contentView addSubview:_headerImageView];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_dateLabel];
        [self.contentView addSubview:_timeLabel];
        [_whiteView addSubview:_titleLabel];
        [_whiteView addSubview:_showImageView];
        [_praiseBtn addSubview:_praiseLabel];
        [_commentBtn addSubview:_commentLabel];
        [_moreBtn addSubview:_moreLabel];
        [_whiteView addSubview:_praiseBtn];
        [_whiteView addSubview:_commentBtn];
        [_whiteView addSubview:_moreBtn];
//        [_whiteView addSubview:_praiseLabel];
//        [_whiteView addSubview:_commentLabel];
//        [_whiteView addSubview:_moreLabel];
        [self.contentView addSubview:_listTitle];
        [self.contentView addSubview:_underLine];
        [self.contentView addSubview:_whiteView];
        self.backgroundColor=kUIColorWithRGB(0xF8F8F8);
        _whiteView.backgroundColor=kUIColorWithRGB(0xFFFFFF);
        
        
        
    }
    return self;
}
-(void)setModel:(TribeModel *)model{
    //头像
    if (model.headUrl.length)
    {
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.headUrl]];
         UIImage *image=_headerImageView.image;
         image=[UIImage circleImage:image borderColor:[UIColor redColor] borderWidth:1.0f];
         _headerImageView.image=image;
    }else
    {
        UIImage *image=[UIImage imageNamed:@"userHeaderDefault"];
        image=[UIImage circleImage:image borderColor:[UIColor redColor] borderWidth:1.0f];
        _headerImageView.image=image;
    }
//    _levelImageView.image=[UIImage imageNamed:@"goldenAuthenticated"];
    
    //名称
    _nameLabel.text=model.nickName;
    _nameLabel.font=[UIFont systemFontOfSize:14];
    _nameLabel.textAlignment=NSTextAlignmentLeft;
    //日期
    _dateLabel.text=[self compareTime:model.createTime];
    _dateLabel.font=[UIFont systemFontOfSize:12];
    _dateLabel.textAlignment=NSTextAlignmentLeft;
    _dateLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    //时间
    _timeLabel.text=[model.formatCreateTime substringFromIndex:11];
    _timeLabel.font=[UIFont systemFontOfSize:12];
    _timeLabel.textAlignment=NSTextAlignmentLeft;
    _timeLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    
    
    //文章内容
    NSInteger length=model.message.length;
    if (length<=200)
    {
        _titleLabel.text=model.message;
    }else{
        NSString *string=[NSString stringWithFormat:@"%@...",[model.message substringToIndex:200]];
        _titleLabel.text=string;
    }
    
    _titleLabel.font=[UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines=0;
    _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize maximumLabelSize1 = CGSizeMake(kMainScreenWidth-85, 999);//labelsize的最大值
    CGSize expectSize1 = [_titleLabel sizeThatFits:maximumLabelSize1];
    _titleLabel.frame=CGRectMake(10, 10, kMainScreenWidth-85, expectSize1.height);
//    _titleLabel.backgroundColor=[UIColor redColor];
    
    //图片区域
    if (model.tribeMessageImgs.count>0)
    {
        
        //        _showImageView.backgroundColor=[UIColor blueColor];
        if (model.tribeMessageImgs.count<=2)
        {
            for (int i=0; i<2; i++) {
                UIImageView *photo=[[UIImageView alloc] initWithFrame:CGRectMake(i*((kMainScreenWidth-90-10)/2+10), 10, (kMainScreenWidth-90-10)/2, (kMainScreenWidth-90-10)/2)];
//                photo.image=[UIImage imageNamed:@"HomePageDefaultCard"];
                [photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.tribeMessageImgs[i][@"img"]]]];
                photo.contentMode=UIViewContentModeScaleAspectFit;
                [_showImageView addSubview:photo];
            }
            _showImageView.frame=CGRectMake(10, _titleLabel.frame.size.height+20, kMainScreenWidth-90, 160);
        }else{
            for (int i=0; i<model.tribeMessageImgs.count; i++ ) {
            int a= i/3;
            int b= i%3;
            UIImageView *photo=[[UIImageView alloc] initWithFrame:CGRectMake(b*((kMainScreenWidth-90-10)/3+10), a*((kMainScreenWidth-90-10)/3+10), (kMainScreenWidth-90-10)/3, (kMainScreenWidth-90-10)/3)];
//            photo.image=[UIImage imageNamed:@"HomePageDefaultCard"];
            [photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.tribeMessageImgs[i][@"img"]]]];
            photo.contentMode=UIViewContentModeScaleAspectFit;
            [_showImageView addSubview:photo];
            }
            NSInteger c=model.tribeMessageImgs.count/3;
               _showImageView.frame=CGRectMake(10, _titleLabel.frame.size.height+20, kMainScreenWidth-90, (c+1)*(kMainScreenWidth-90-10)/3+20);
            
        }
        
        
        
    }else{
        _showImageView.frame=CGRectMake(10, _titleLabel.frame.size.height+20, kMainScreenWidth-90,0);
    }

    
    //点赞按钮
    _praiseBtn.frame=CGRectMake(10, _showImageView.frame.size.height+_showImageView.frame.origin.y+10, 80, 30);
    [_praiseBtn setImage:[UIImage imageNamed:@"bottomPraise"] forState:UIControlStateNormal];
    _praiseBtn.imageEdgeInsets=UIEdgeInsetsMake(7, 0, 8, 65);
    if (model.isLike==0)
    {
        [_praiseBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [_praiseBtn addTarget:self action:@selector(praiseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_praiseBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [_praiseBtn addTarget:self action:@selector(deletePraiseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    //点赞数目
    _praiseLabel.frame=CGRectMake(20, 7, 60, 15);
    _praiseLabel.text=[NSString stringWithFormat:@"%d",model.likeNum];
    _praiseLabel.font=[UIFont systemFontOfSize:12];
    _praiseLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _praiseLabel.textAlignment=NSTextAlignmentLeft;
    
    
    //评论按钮
    _commentBtn.frame=CGRectMake(100,_praiseBtn.frame.origin.y, 80, 30);
    [_commentBtn setImage:[UIImage imageNamed:@"bottomComment"] forState:UIControlStateNormal];
    _commentBtn.imageEdgeInsets=UIEdgeInsetsMake(7, 0, 8, 65);
    [_commentBtn addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    //评论数目
    _commentLabel.frame=CGRectMake(20,7, 60, 15);
    _commentLabel.text=[NSString stringWithFormat:@"%d",model.commentNum];
    _commentLabel.font=[UIFont systemFontOfSize:12];
    _commentLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _commentLabel.textAlignment=NSTextAlignmentLeft;
    
    //更多
    _moreBtn.frame=CGRectMake(kMainScreenWidth-70-60, _praiseBtn.frame.origin.y, 80, 30);
    [_moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    _moreBtn.imageEdgeInsets=UIEdgeInsetsMake(7, 0, 8, 65);
    [_moreBtn addTarget:self action:@selector(moreBtnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    //更多label
    _moreLabel.frame=CGRectMake(20, 7, 60, 15);
    _moreLabel.text=@"更多";
    _moreLabel.font=[UIFont systemFontOfSize:12];
    _moreLabel.textColor=kUIColorWithRGB(0xA6A6A6);
    _moreLabel.textAlignment=NSTextAlignmentLeft;

    
    _whiteView.frame=CGRectMake(50, _timeLabel.frame.size.height+_timeLabel.frame.origin.y+10, kMainScreenWidth-70, _commentBtn.frame.size.height+_commentBtn.frame.origin.y+10);
    //评论标题
    _listTitle.frame=CGRectMake(23, _whiteView.frame.size.height+_whiteView.frame.origin.y+20, 50, 14) ;
    _listTitle.text=@"评论";
    _listTitle.textColor=kUIColorWithRGB(0x434343);
    _listTitle.font=[UIFont systemFontOfSize:14];
    _listTitle.textAlignment=NSTextAlignmentLeft;
    //下划线
    _underLine.frame=CGRectMake(22,_listTitle.frame.size.height+_listTitle.frame.origin.y+4,31,2);
    _underLine.backgroundColor=kUIColorWithRGB(0xE3A63F);
    
    //cell高度计算
    CGRect frame=self.frame;
    frame.size.height=_underLine.frame.size.height+_underLine.frame.origin.y+20;
    self.frame=frame;
    
}

-(void)praiseBtnClicked{
    NSLog(@"nihao");
    if ([_delegate respondsToSelector:@selector(praise:)]) {
        [_delegate praise:self];
    }
}
-(void)commentBtnClicked{
    if ([_delegate respondsToSelector:@selector(comment:)]) {
        [_delegate comment:self];
    }
    
}
-(void)moreBtnBtnClicked{
    if ([_delegate respondsToSelector:@selector(more:)]) {
        [_delegate more:self];
    }
}
-(void)deletePraiseBtnClicked{
    if ([_delegate respondsToSelector:@selector(deletePraise:)]) {
        [_delegate deletePraise:self];
    }
}
-(void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(NSString *)compareTime:(NSInteger)myTime{
    NSString *campareTime;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSInteger time1=(NSInteger)time;
    NSInteger differTime=time1-myTime/1000;
    NSInteger year=60*60*24*30*365;
    NSInteger month=60*60*24*30;
    NSInteger day=60*60*24;
    if ((differTime/year)!=0) {
        campareTime=[NSString stringWithFormat:@"%ldyear ago",differTime/year];
    }else if ((differTime/month)!=0){
        campareTime=[NSString stringWithFormat:@"%ldmonth ago",differTime/month];
    }else if((differTime/day)!=0){
        campareTime=[NSString stringWithFormat:@"%lddays ago",differTime/day];
    }else{
        campareTime=@"today";
    }
    return campareTime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
