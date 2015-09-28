//
//  PMCacheManager.h
//  内存缓存
//
//  Created by 马健Jane on 15/9/28.
//  Copyright © 2015年 HSC. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSUInteger kPMCacheObjectValidSecond = 10 * 60;//十分钟

static NSUInteger kPMCacheManagerCachedObjectCountLimit = 1000;

@interface PMMemoryCacheManager : NSObject

@property (nonatomic,assign,readonly) NSUInteger countOfCachedObject;

+ (id)sharedCacheManager;

//增
- (void)saveShouldCacheData:(NSData *)cacheData forKey:(NSString *)key;

//删
- (void)removeCacheDataWithKey:(NSString *)key;
- (void)clean;

//查
- (NSData *)cacheDataWithKey:(NSString *)key;

@end
