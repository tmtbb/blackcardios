//
//  ClubModel.h
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

@interface TribeModel : OEZModel
@property(copy,nonatomic)NSString *headUrl;//头像
@property(assign,nonatomic)NSInteger userId;//用户id
@property(copy,nonatomic)NSString *id;//文章ID
@property(assign,nonatomic)int isLike;//是否点赞过
@property(copy,nonatomic)NSString *nickName;//昵称
//@property(copy,nonatomic)NSString *company;
//@property(copy,nonatomic)NSString *job;
@property(copy,nonatomic)NSString *message;//文章内容
@property(assign,nonatomic)int likeNum;//点赞数
@property(assign,nonatomic)int commentNum;//评论数
@property(assign,nonatomic)NSInteger createTime;//创建时间
@property(copy,nonatomic)NSArray *tribeMessageImgs;//图片数组
@property(assign,nonatomic)int isTop;//置顶
@property(copy,nonatomic)NSString *formatCreateTime;
@property(nonatomic)NSInteger yearMonth;// 格式化取出 年月
@end


@interface EliteLifeModel : OEZModel

@property(copy,nonatomic)NSString *imageUrl;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *date;
@property(copy,nonatomic)NSString *time;
@property(copy,nonatomic)NSString *article;
@end

@interface CommentListModel : OEZModel
@property(copy,nonatomic)NSString *headUrl;//评论人头像
@property(copy,nonatomic)NSString *nickName;//评论人别称
@property(assign,nonatomic)NSInteger userId;//评论人id
//@property(copy,nonatomic)NSString *date;
//@property(copy,nonatomic)NSString *time;
@property(assign,nonatomic)NSInteger createTime;//创建时间
@property(copy,nonatomic)NSString *comment;//评论内容
@property(copy,nonatomic)NSString *formatCreateTime;
@property(nonatomic)NSInteger yearMonth;// 格式化取出 年月



@end
