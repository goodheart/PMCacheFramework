//
//  PMCacheManager.m
//  CacheFramework
//
//  Created by 马健Jane on 15/9/28.
//  Copyright © 2015年 HSC. All rights reserved.
//

#import "PMMemoryCacheManager.h"
#import "PMCacheObject.h"

#define kPMMemeryCacheName @"com.goodheart.memoryCache"

@interface PMMemoryCacheManager ()
/* private Property */
@property (nonatomic,strong) NSCache * cache;
@property (nonatomic,strong) NSMutableArray * allCachedObjectKeysArrayM;

/* private Method  */
- (void)removeAllOutOfDatedCache;
@end

static PMMemoryCacheManager * _cacheManager;
@implementation PMMemoryCacheManager
#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSTimeInterval period = 1.0;//设置时间间隔
        
        dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
        dispatch_source_set_timer(source, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(source, ^{
            [self removeAllOutOfDatedCache];
        });
        
        dispatch_resume(source);
    }
    
    return self;
}

- (void)dealloc {
    [self.cache removeAllObjects];
    [self.allCachedObjectKeysArrayM removeAllObjects];
}

#pragma mark - initial Method
+ (id)sharedCacheManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cacheManager = [[PMMemoryCacheManager alloc] init];
    });
    return _cacheManager;
}

#pragma mark - Public Method
//增
- (void)saveShouldCacheData:(NSData *)cacheData forKey:(NSString *)key {
    
    PMCacheObject * cacheObject = [self.cache objectForKey:key];
    
    if (nil == cacheObject) {
        cacheObject = [[PMCacheObject alloc] init];
        cacheObject.cacheObjectValidSecond = kPMCacheObjectValidSecond;
    }
    
    [cacheObject updateData:cacheData];
    
    [self.cache setObject:cacheObject forKey:key];
    
    [self.allCachedObjectKeysArrayM addObject:key];
}

//删
- (void)removeCacheDataWithKey:(NSString *)key {
    [self.cache removeObjectForKey:key];
    [self.allCachedObjectKeysArrayM removeObject:key];
}

- (void)clean {
    [self.cache removeAllObjects];
    [self.allCachedObjectKeysArrayM removeAllObjects];
}

//查
- (NSData *)cacheDataWithKey:(NSString *)key {
    
    PMCacheObject * cacheObject = [self.cache objectForKey:key];
    
    if (cacheObject.isOutOfDate) {//过期就把它删除
        [self removeCacheDataWithKey:key];
        return nil;
    } else {
        return cacheObject.cacheData;
    }
}

//将过期的删除
- (void)removeAllOutOfDatedCache {
    
    __block PMCacheObject * cacheObject = nil;
    NSArray * keysArray = [self.allCachedObjectKeysArrayM copy];
    [keysArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull cacheKey, NSUInteger idx, BOOL * _Nonnull stop) {
         cacheObject = [self.cache objectForKey:cacheKey];
        
        if (cacheObject.isOutOfDate) {
            [self removeCacheDataWithKey:cacheKey];
        }
    }];
}

#pragma mark - Property Getter
- (NSCache *)cache {
    if (_cache) {
        return _cache;
    }
    
    _cache = [[NSCache alloc] init];
    _cache.countLimit = kPMCacheManagerCachedObjectCountLimit;
    _cache.evictsObjectsWithDiscardedContent = YES;
    _cache.name = kPMMemeryCacheName;
    
    return _cache;
}

- (NSMutableArray *)allCachedObjectKeysArrayM {
    if (_allCachedObjectKeysArrayM) {
        return _allCachedObjectKeysArrayM;
    }
    
    _allCachedObjectKeysArrayM = [[NSMutableArray alloc] initWithCapacity:self.cache.countLimit];
    
    return _allCachedObjectKeysArrayM;
}
@end
