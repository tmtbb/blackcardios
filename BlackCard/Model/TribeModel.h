//
//  ClubModel.h
//  BlackCard
//
//  Created by xmm on 2017/5/25.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>
@class TribeMessageImgsModel;

@interface BaseTribeModel : OEZModel
@property(copy,nonatomic)NSString *formatCreateTime;
// 子类重写 返回要格式化的时间
- (NSString *)giveTime;


- (CGFloat)modelHeight;
- (BOOL)hasHeight;
- (void)setHeigth:(CGFloat)height;



@end


@interface TribeModel : BaseTribeModel
@property(copy,nonatomic)NSString  *createTime;//创建时间
@property(copy,nonatomic)NSString *nickName;//昵称
@property(copy,nonatomic)NSString *message;//文章内容
@property(copy,nonatomic)NSString *userId;//用户id
@property(copy,nonatomic)NSString *headUrl;//头像
@property(copy,nonatomic)NSString *circleId;//文章ID
@property(assign,nonatomic)NSInteger isTop;//置顶
@property(assign,nonatomic)NSInteger isLike;//是否点赞过
@property(assign,nonatomic)NSInteger likeNum;//点赞数
@property(assign,nonatomic)NSInteger commentNum;//评论数
@property(strong,nonatomic)NSArray<TribeMessageImgsModel *> *circleMessageImgs;//图片数组


@property(nonatomic)NSInteger yearMonth;// 格式化取出 年月
@end

@interface TribeMessageImgsModel : OEZModel
@property(copy,nonatomic)NSString *img; //缩略图地址，截去_thumb为原图地址
@property(copy,nonatomic)NSString *size; //图片原始尺寸格式:宽x高

@end


@interface TheArticleModel : BaseTribeModel

@property(copy,nonatomic)NSString *commentNum;  //评论数
@property(copy,nonatomic)NSString *summary;     //摘要
@property(copy,nonatomic)NSString *articleId;   //id
@property(copy,nonatomic)NSString *title;       //标题
@property(copy,nonatomic)NSString *createTime;
@property(copy,nonatomic)NSString *coverUrl;    //封面图片地址


@end


@interface TheArticleDetailModel : TheArticleModel

@property(copy,nonatomic)NSString *detailUrl;   //详情ur


@end

@interface CommentListModel : BaseTribeModel
@property(copy,nonatomic)NSString *createTime;//创建时间
@property(copy,nonatomic)NSString *nickName;//评论人别称
@property(assign,nonatomic)NSInteger userId;//评论人id
@property(copy,nonatomic)NSString *headUrl;//评论人头像
@property(copy,nonatomic)NSString *comment;//评论内容



@property(nonatomic)NSInteger yearMonth;// 格式化取出 年月



@end


@class ManorStatusModel;
@class ManorDescribeModel;
@interface ManorModel : OEZModel
@property(strong,nonatomic)ManorStatusModel *ownTribe;//当前用户创建的部落,没创建部落只输出status
@property(strong,nonatomic)NSArray *recommendTribes;//推荐部落列表
@property(strong,nonatomic)NSArray *userTribes;//当前用户加入的部落列表


@end

@interface ManorStatusModel : OEZModel
@property(assign,nonatomic)NSInteger status;//状态 0：没有创建 1:审核中 2:审核通过
@property(copy,nonatomic)NSString *tribeId;//部落id
@property(assign,nonatomic)NSInteger verifyNum;//待审核成员数量,0时不显示红点

@end



@interface ManorDescribeModel : OEZModel

@property(copy,nonatomic)NSString *tribeId;//部落id
@property(copy,nonatomic)NSString *name;//名称
@property(copy,nonatomic)NSString *industry;//领域
@property(copy,nonatomic)NSString *describe;//描述
@property(assign,nonatomic)NSInteger memberNum;//成员数量



@end


@interface ManorPersonModel : BaseTribeModel

@property(copy,nonatomic)NSString *nickName;//成员呢称
@property(copy,nonatomic)NSString *userId;//用户id
@property(copy,nonatomic)NSString *headUrl;//成员头像
@property(copy,nonatomic)NSString *personId;//成员id
@property(assign,nonatomic)NSInteger status;//int	状态 1：审核中 2：通过 3：拒绝
@property(assign,nonatomic)NSInteger identity;//状态 0：普通成员 1：创建者
@property(copy,nonatomic)NSString *createTime;//加入时间

@end


@class ManorDetailModel;
@class ManorMemberInfoModel;
@interface ManorInfoModel : OEZModel

@property(strong,nonatomic)ManorDetailModel *tribeInfo;//部落信息
@property(strong,nonatomic)ManorMemberInfoModel *memberInfo;//当前用户在部落中成员信息


@end


@interface ManorDetailModel : OEZModel

@property(copy,nonatomic)NSString *tribeId;//部落id
@property(copy,nonatomic)NSString *name;//名称
@property(copy,nonatomic)NSString *industry;//领域
@property(copy,nonatomic)NSString *describe;//描述
@property(copy,nonatomic)NSString *coverUrl;//封面

@property(copy,nonatomic)NSString *city;//	城市
@property(copy,nonatomic)NSString *province;//	省份



@property(assign,nonatomic)NSInteger memberNum;//成员数量
@property(assign,nonatomic)NSInteger status;//状态 1：审核中 2：审核通过


@end

@interface ManorMemberInfoModel : OEZModel

@property(assign,nonatomic)NSInteger status;//状态0：末加入 1：审核中 2：审核通过 3：拒绝
@property(assign,nonatomic)NSInteger identity;//	身份 0：普通成员 1：创建者

@end


