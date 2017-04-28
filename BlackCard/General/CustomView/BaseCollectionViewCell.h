//
//  BaseCollectionViewCell.h
//  mgame648
//
//  Created by yaowang on 16/7/1.
//  Copyright © 2016年 ywwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCollectionViewCellActionDelegate <NSObject>


- (void)view:(UIView *)view didAction:(NSInteger)action andData:(id)data;

@end

@interface BaseCollectionViewCell : UICollectionViewCell<OEZUpdateProtocol>

@property (assign,nonatomic)id<CustomCollectionViewCellActionDelegate> delegate;


- (void)didAction:(NSInteger)action andData:(id)data;
@end
