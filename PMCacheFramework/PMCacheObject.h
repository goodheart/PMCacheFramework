//
//  PMCachedObject.h
//  缓存对象
//
//  Created by 马健Jane on 15/9/28.
//  Copyright © 2015年 HSC. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSUInteger kPMCacheObjectValidSecond = 10 * 60;//十分钟

@interface PMCacheObject : NSObject

@property (nonatomic,copy) NSData * cacheData;
@property (nonatomic,copy,readonly) NSDate * lastCachedTime;
@property (nonatomic,assign,getter=isOutOfDate) BOOL outOfDate;
//@property (nonatomic,assign) 

- (id)initWithCacheData:(NSData *)cacheData;
+ (id)cacheObjectWithCacheData:(NSData *)cacheData;

- (void)updateData:(NSData *)newData;
- (BOOL)isEmpty;

@end
