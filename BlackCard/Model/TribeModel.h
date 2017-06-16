//
//  ClubModel.h
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
@class TribeMessageImgsModel;
@interface TribeModel : OEZModel
@property(copy,nonatomic)NSString  *createTime;//创建时间
@property(copy,nonatomic)NSString *nickName;//昵称
@property(copy,nonatomic)NSString *message;//文章内容
@property(copy,nonatomic)NSString *userId;//用户id
@property(copy,nonatomic)NSString *headUrl;//头像
@property(copy,nonatomic)NSString *tribeId;//文章ID
@property(assign,nonatomic)NSInteger isTop;//置顶
@property(assign,nonatomic)NSInteger isLike;//是否点赞过
@property(assign,nonatomic)NSInteger likeNum;//点赞数
@property(assign,nonatomic)NSInteger commentNum;//评论数
@property(strong,nonatomic)NSArray<TribeMessageImgsModel *> *tribeMessageImgs;//图片数组


- (CGFloat)modelHeight;
- (BOOL)hasHeight;
- (void)setHeigth:(CGFloat)height;

@property(copy,nonatomic)NSString *formatCreateTime;
@property(nonatomic)NSInteger yearMonth;// 格式化取出 年月
@end

@interface TribeMessageImgsModel : OEZModel
@property(copy,nonatomic)NSString *img; //缩略图地址，截去_thumb为原图地址
@property(copy,nonatomic)NSString *size; //图片原始尺寸格式:宽x高

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
