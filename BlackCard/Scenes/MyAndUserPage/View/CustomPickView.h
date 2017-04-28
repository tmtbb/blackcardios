//
//  CustomPickView.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/26.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <OEZCommSDK/OEZCommSDK.h>

typedef NS_ENUM(NSInteger,CustomPickViewStatus) {
    CustomPickViewStatus_Close = 1,
    CustomPickViewStatus_Choose,
    
};
@interface CustomPickView : OEZNibView
- (void)inChooseLocation ;
@end
