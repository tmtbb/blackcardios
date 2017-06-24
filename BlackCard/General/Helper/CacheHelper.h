//
// Created by yaobanglin on 15/9/27.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CacheHelper : NSObject <OEZHelperProtocol>
- (void)moveImageFileAtPath:(NSString *)path key:(NSString *)key;

- (void)moveSoundFileAtPath:(NSString *)path key:(NSString *)key;

- (BOOL)diskSoundFileExistsWithKey:(NSString *)key;

- (NSString *)soundFileCachePathForKey:(NSString *)key;

- (void)soundFileExists;

- (NSString *)imageFileCachePathForKey:(NSString *)key;

- (BOOL)diskImageFileExistsWithKey:(NSString *)key;

- (NSURL *)imageNSURLWithStrUrl:(NSString *)strUrl;

- (NSString *)tempFileCachePathForKey:(NSString *)key;

- (BOOL)diskTempFileExistsWithKey:(NSString *)key;

- (void)tempFileExists;

- (void)removeExpireImageFileCahce:(NSString *)key lastSec:(NSTimeInterval)lastSec;

- (void)clearDisk;

- (void)removeImageForKey:(NSString *)key;


@end