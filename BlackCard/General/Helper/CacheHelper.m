//
// Created by yaobanglin on 15/9/27.
// Copyright (c) 2015 yaowang. All rights reserved.
//

#import "CacheHelper.h"
#import "SDImageCache.h"
#import <CommonCrypto/CommonDigest.h>

@interface SDImageCache ()

@property (strong, nonatomic) NSCache *memCache;
@property (strong, nonatomic) NSString *diskCachePath;
- (NSString *)cachedFileNameForKey:(NSString *)key;
@end

@implementation CacheHelper {
    NSFileManager *_fileManager;
    NSString *_imageDiskCachePath;
    NSString *_soundDiskCachePath;
    NSString *_tempDiskCachePath;
}
HELPER_SHARED(CacheHelper);

- (instancetype)init {
    self = [super init];
    if (self) {
        _fileManager = [NSFileManager defaultManager];
        _imageDiskCachePath = [[SDImageCache sharedImageCache] diskCachePath];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *identifier = [infoDictionary objectForKey:@"CFBundleIdentifier"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _soundDiskCachePath = [paths[0] stringByAppendingPathComponent:[identifier stringByAppendingString:@".sound.default"]];
        _tempDiskCachePath = [paths[0] stringByAppendingPathComponent:[identifier stringByAppendingString:@".temp.default"]];
        [self fileExistsAtPath:_imageDiskCachePath];
        [self fileExistsAtPath:_soundDiskCachePath];
        [self fileExistsAtPath:_tempDiskCachePath];
    }

    return self;
}

- (NSURL *)imageNSURLWithStrUrl:(NSString *)strUrl {
    NSURL *nsurl = [[NSURL alloc] initWithString:strUrl];
    if (![strUrl hasPrefix:@"http://"]) {
        NSString *fileName = strUrl;
        if (![strUrl hasPrefix:@"/"])
            fileName = [[CacheHelper shared] tempFileCachePathForKey:strUrl];
        nsurl = [[NSURL alloc] initFileURLWithPath:fileName];
    }
    return nsurl;
}

- (void)fileExistsAtPath:(NSString *)path {
    if (![_fileManager fileExistsAtPath:path]) {
        [_fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
}

- (void)moveImageFileAtPath:(NSString *)path key:(NSString *)key {
    [self fileExistsAtPath:_imageDiskCachePath];
    [_fileManager moveItemAtPath:path toPath:[[SDImageCache sharedImageCache] defaultCachePathForKey:key] error:nil];
}

- (void)moveSoundFileAtPath:(NSString *)path key:(NSString *)key {
    [self fileExistsAtPath:_soundDiskCachePath];
    [_fileManager moveItemAtPath:path toPath:[self soundFileCachePathForKey:key] error:nil];
}

- (NSString *)cachePathForKey:(NSString *)key inPath:(NSString *)path {
    NSString *filename = [self cachedFileNameForKey:key];
    return [path stringByAppendingPathComponent:filename];
}


- (NSString *)soundFileCachePathForKey:(NSString *)key {
    return [self cachePathForKey:key inPath:_soundDiskCachePath];
}


- (NSString *)cachedFileNameForKey:(NSString *)key {

    
    return [[SDImageCache sharedImageCache] cachedFileNameForKey:key];
}


- (void)clearDisk {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
}

- (void)removeImageForKey:(NSString *)key {
    [[SDImageCache sharedImageCache] removeImageForKey:key];
}

- (BOOL)diskSoundFileExistsWithKey:(NSString *)key {
    BOOL exists = NO;
    exists = [[NSFileManager defaultManager] fileExistsAtPath:[self soundFileCachePathForKey:key]];
    return exists;
}


- (NSString *)imageFileCachePathForKey:(NSString *)key {
    return [[SDImageCache sharedImageCache] defaultCachePathForKey:key];
}

- (void)removeExpireImageFileCahce:(NSString *)key lastSec:(NSTimeInterval)lastSec {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *path = [self imageFileCachePathForKey:key];
    if ([fileMgr fileExistsAtPath:path]) {
        NSDictionary *fileAttributes = [fileMgr fileAttributesAtPath:path traverseLink:YES];
        NSDate *lastModificationDate = [fileAttributes objectForKey:NSFileCreationDate];
        if (([[NSDate date] timeIntervalSince1970] - [lastModificationDate timeIntervalSince1970]) > lastSec) {
            [[CacheHelper shared] removeImageForKey:key];
        }
    }
}


- (BOOL)diskImageFileExistsWithKey:(NSString *)key {
    BOOL exists = NO;
    exists = [[NSFileManager defaultManager] fileExistsAtPath:[self imageFileCachePathForKey:key]];
    return exists;
}



- (NSString *)tempFileCachePathForKey:(NSString *)key {
    return [_tempDiskCachePath stringByAppendingPathComponent:key];
}

- (BOOL)diskTempFileExistsWithKey:(NSString *)key {
    BOOL exists = NO;
    exists = [[NSFileManager defaultManager] fileExistsAtPath:[self tempFileCachePathForKey:key]];
    return exists;
}

- (void)tempFileExists {
    [self fileExistsAtPath:_tempDiskCachePath];
}

- (void)soundFileExists {
    [self fileExistsAtPath:_soundDiskCachePath];
}

@end