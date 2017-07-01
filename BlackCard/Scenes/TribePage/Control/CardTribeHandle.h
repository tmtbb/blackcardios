//
//  CardTribeHandle.h
//  BlackCard
//
//  Created by abx’s mac on 2017/6/19.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TribeModel;

typedef void(^CardTribeHandleBlock)(BOOL isDelete,id data,NSError *error);
@interface CardTribeHandle : NSObject


+(void)doPraise:(UIViewController *)control  model:(TribeModel *)model complete:(void(^)())complete;

+(void)doComment:(UIViewController *)control indexPath:(NSIndexPath *)path model:(TribeModel *)model complete:(void(^)(NSIndexPath *path))complete;

+ (void)doMore:(UIViewController *)control model:(TribeModel *)model  block:(CardTribeHandleBlock)block;
@end
