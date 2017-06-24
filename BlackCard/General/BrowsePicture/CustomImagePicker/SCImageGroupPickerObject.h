//
//  SCImageGroupPickerObject.h
//  SecretChat
//
//  Created by soyeaios2 on 15/2/11.
//  Copyright (c) 2015年 Patrick.Coin. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface SCImageGroupPickerObject : NSObject

@property (nonatomic, strong) UIImage  *groupImage;
@property (nonatomic, strong) NSString *groupNameS;
@property (nonatomic, assign) NSInteger groupImageNum;

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@end
