//
//  homePageCollectionViewCell.h
//  BlackCard
//
//  Created by abx’s mac on 2017/4/21.
//  Copyright © 2017年 abx’s mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageCollectionViewCell : UICollectionViewCell<OEZUpdateProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
