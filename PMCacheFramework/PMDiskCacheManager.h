//
//  PMDiskCacheManager.h
//  本地缓存
//
//  Created by 马健Jane on 15/9/28.
//  Copyright © 2015年 HSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMDiskCacheManager : NSObject
//缓存路径
@property (nonatomic,copy,readonly) NSString * cachePath;

+ (id)sharedDiskCacheManager;

//增 改
- (void)saveShouldCachedData:(NSData *)shouldCachedData forKey:(NSString *)key;
//删
- (void)removeDataForKey:(NSString *)key;
//查
- (NSData *)dataForKey:(NSString *)key;

@end
