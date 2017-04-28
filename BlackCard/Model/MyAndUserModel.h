//
//  MyAndUserModel.h
//  mgame648
//
//  Created by iMac on 15/11/24.
//  Copyright © 2015年 yaowang. All rights reserved.
//


@interface MyAndUserModel : OEZModel
/**
 *  我的及用户Model 我的主页
 */
@property (nonatomic, strong) NSString *userId;         //用户id
@property (nonatomic, strong) NSString *phoneNum;        //用户账号
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *username;         //真实姓名

@property (nonatomic, strong) NSString *headpic;
@property (nonatomic, strong) NSString *blackCardName;       //黑卡名称
@property (nonatomic) NSInteger blackCardId;         //黑卡id
@property (nonatomic, strong) NSString *blackCardNo;         //黑卡卡号
@property (nonatomic) double blackcardCreditline; //黑卡额度

@property (nonatomic, strong) NSString *blackCardCustomName;    //定制名称








/**
 *  预加参数  动态入口数组
 */
//@property (nonatomic, strong) NSMutableArray *insertObjectArrays;

@end

/**
// *  账户余额明细
// */
//@interface  MyAccountModel: OEZModel
//@property (nonatomic, strong)NSString *source;
///**
// *  变动金额
// */
//@property (nonatomic, strong) NSString *money;
///**
// *  变动时间
// */
//@property (nonatomic, strong) NSString *createTime;
//@end
//
//@interface MySettingCheckVersion : OEZModel
//@property (nonatomic, strong) NSString *version;
//@property (nonatomic, strong) NSString *url;
//@property (nonatomic, strong) NSString *intro;
//@property (nonatomic, strong) NSString *must;
//@property (nonatomic, strong) NSString *rcgStatus;
//@end
//
///**
// *  第三方登陆 所需参数
// */
@interface UserBandModel : OEZModel
@property (nonatomic, strong) NSString *openId;
@property (nonatomic) NSInteger accountType;
@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *headpic;
@property (nonatomic, strong) NSString *appType;
@property (nonatomic, strong) NSString *unionid;
@end
//
//
//@interface AdvertisementPopupModel : OEZModel
//@property (nonatomic, strong) NSString *img;
//@property (copy,nonatomic)NSString *url;
//@property (copy,nonatomic)NSString *advertisementId;
//@end
//
//
//@interface BaseMenuModel: OEZModel
//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *icon;
//@property (nonatomic)NSInteger tag;
//@end
//
//@interface LocalMenuModel : BaseMenuModel
//@property (nonatomic, copy)  NSString *isShare;
//+ (instancetype)menuName:(NSString *)name icon:(NSString *)icon tag:(NSInteger)tag;
//@end
//
//@interface LocalMenuMessageModel : LocalMenuModel
//
//@property (nonatomic,copy)NSString *num;
//@end
//
//@interface CustommenuListModel: BaseMenuModel
//@property (nonatomic, copy)  NSString *jumpType; //(1:app内部，2：外部)
//
//@property (nonatomic, strong) NSString *menuId;
//@property (nonatomic, strong) NSString *jumpUrl;
//@property (nonatomic, strong) NSString *subTitle;
//@end

