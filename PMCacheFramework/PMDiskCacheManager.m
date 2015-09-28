//
//  PMDiskCacheManager.m
//  CacheFramework
//
//  Created by 马健Jane on 15/9/28.
//  Copyright © 2015年 HSC. All rights reserved.
//

#import "PMDiskCacheManager.h"
#define kPMDiskCachePathName @"com.goodheart.diskCache"
@interface PMDiskCacheManager ()

@end

static NSString * _diskCachePath = nil;
@implementation PMDiskCacheManager
#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        //设置默认硬盘缓存地址
        _diskCachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:kPMDiskCachePathName];;
    }
    
    return self;
}

#pragma mark - Public Method
+ (id)sharedDiskCacheManager {
    static PMDiskCacheManager * _diskCacheManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _diskCacheManager = [[PMDiskCacheManager alloc] init];
    });
    
    return _diskCacheManager;
}

- (void)saveShouldCachedData:(NSData *)shouldCachedData forKey:(NSString *)key {
    
}

- (void)removeDataForKey:(NSString *)key {
    
}

- (NSData *)dataForKey:(NSString *)key {
    return nil;
}

#pragma mark - Propery Getter
- (NSString *)cachePath {
    return _diskCachePath;
}

@end
