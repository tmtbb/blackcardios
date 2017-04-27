//
//  EveryNoneView.h
//  douniwan
//
//  Created by simon on 15/10/19.
//  Copyright © 2015年 yaowang. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

//默认是第一个图标
typedef NS_ENUM(NSInteger, EveryNoneType){
    EveryNoneType_message = 0,
    EveryNoneType_search = EveryNoneType_message +1
    
};

@interface EveryNoneView : OEZNibView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTop;

@property (nonatomic,assign) EveryNoneType type;
+(instancetype)everyNoneViewWith:(NSString *)string type:(EveryNoneType)type;

@end
