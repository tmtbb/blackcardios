//
//  RegisterWithCollectionView.m
//  BlackCard
//
//  Created by abx’s mac on 2017/4/22.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import "RegisterWithCollectionView.h"

@implementation RegisterWithCollectionView

- (UIEdgeInsets)collectionViewLayoutEdge {
    
    return UIEdgeInsetsMake(20, 24, 20, 24);
}

- (CGFloat)minimumInteritemSpacing {
    
    return 20;
}

- (CGFloat)minimumLineSpacing {
    
    return 15;
}

- (NSString *)cellKey {
    static NSString *key = @"RegisterCollectionViewCell";
    return key;
}


- (NSInteger)sectionWithUnmber {
    CGFloat width =  kMainScreenWidth - 48 - 70 + 1;
    NSInteger count = width / (70 + 15) + 1;
    
    self.minLine = (kMainScreenWidth - 48 - count * 70 ) /(count - 1.0);
    
    return  count * 2;
    
    
    
}
@end
