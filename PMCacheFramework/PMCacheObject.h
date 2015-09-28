//
//  PMCachedObject.h
//  缓存对象
//
//  Created by 马健Jane on 15/9/28.
//  Copyright © 2015年 HSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMCacheObject : NSObject

@property (nonatomic,copy) NSData * cacheData;
@property (nonatomic,copy,readonly) NSDate * lastCachedTime;
@property (nonatomic,assign,getter=isOutOfDate) BOOL outOfDate;
//有效时间
@property (nonatomic,assign) NSUInteger cacheObjectValidSecond;//以秒为单位，如果为0，表示没有过期时间

- (id)initWithCacheData:(NSData *)cacheData;
+ (id)cacheObjectWithCacheData:(NSData *)cacheData;

- (void)updateData:(NSData *)newData;
- (BOOL)isEmpty;

@end
