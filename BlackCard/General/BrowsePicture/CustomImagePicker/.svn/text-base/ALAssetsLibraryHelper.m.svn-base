//
//  ALAssetsLibraryHelper.m
//  bluesharktv
//
//  Created by taeyoona on 16/11/3.
//  Copyright © 2016年 yaowang. All rights reserved.
//

#import "ALAssetsLibraryHelper.h"

@implementation ALAssetsLibraryHelper


+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred,
                  ^{
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}

@end
