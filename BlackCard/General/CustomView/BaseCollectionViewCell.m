//
//  BaseCollectionViewCell.m
//  mgame648
//
//  Created by yaowang on 16/7/1.
//  Copyright © 2016年 ywwl. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (void)update:(id)data {
    
}


- (void)didAction:(NSInteger)action andData:(id)data {
    

        [self.delegate view:self didAction:action andData:data];
    
}
@end
