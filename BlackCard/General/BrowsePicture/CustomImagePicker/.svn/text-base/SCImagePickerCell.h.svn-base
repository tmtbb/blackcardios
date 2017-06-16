//
//  SCImagePickerCell.h
//  SecretChat
//
//  Created by soyeaios2 on 15/3/1.
//  Copyright (c) 2015年 Patrick.Coin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCImagePickerCell;

typedef void(^SCImagePickerCellIsCheckedBlock)(int index);

@interface SCImagePickerCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *logoArray;
@property (nonatomic, strong) NSMutableArray *isSelectArray;

@property (nonatomic,copy) SCImagePickerCellIsCheckedBlock isCheckedBlock;

-(void)update:(id)data start:(NSInteger)startInt end:(NSInteger)endInt;
+(CGFloat)cellHeight;

@end
