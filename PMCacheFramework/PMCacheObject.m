//
//  PMCachedObject.m
//  CacheFramework
//
//  Created by 马健Jane on 15/9/28.
//  Copyright © 2015年 HSC. All rights reserved.
//

#import "PMCacheObject.h"

@interface PMCacheObject ()
/* header readonly  */
@property (nonatomic,copy,readwrite) NSDate * lastCachedTime;
@end

@implementation PMCacheObject
#pragma mark - initial Method
- (id)initWithCacheData:(NSData *)cacheData {
    if (self = [super init]) {
        self.cacheData = cacheData;
    }
    
    return self;
}

+ (id)cacheObjectWithCacheData:(NSData *)cacheData {
    return [[[self class] alloc] initWithCacheData:cacheData];
}

#pragma mark - Public Method
- (void)updateData:(NSData *)newData {
    self.cacheData = newData;
}

- (BOOL)isEmpty {
    return self.cacheData == nil;
}

#pragma mark - Property Getter
- (BOOL)isOutOfDate {
    return [[NSDate alloc] timeIntervalSinceDate:self.lastCachedTime] > kPMCacheObjectValidSecond;
}

#pragma mark - Property Setter
- (void)setCacheData:(NSData *)cacheData {
    _cacheData = [cacheData copy];
    self.lastCachedTime = [NSDate dateWithTimeIntervalSinceNow:0];
}


@end
