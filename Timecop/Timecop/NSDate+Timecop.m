//
//  NSDate+Timecop.m
//  Timecop
//
//  Created by Kazuhiro Sakamoto on 2015/04/19.
//  Copyright (c) 2015年 Soragoto. All rights reserved.
//

#import "NSDate+Timecop.h"
#import <objc/runtime.h>

static NSTimeInterval diffFromRealTime;
static NSDate *freezedDate;
static float scaleRatio;

@implementation NSDate(Timecop)

+ (void) load {
    scaleRatio = 1;
    [NSDate injectTimecop];
}

+ (void) travelWithDate:(NSDate *)date {
    diffFromRealTime = [date timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970];
    if( freezedDate ){
        freezedDate = [NSDate dateWithTimeInterval:diffFromRealTime sinceDate:freezedDate];
    }
}

+ (void) freezeWithDate:(NSDate *)date {
    freezedDate = date;
}

+ (void) scaleWithRatio:(float)ratio {
    scaleRatio = ratio;
}

+ (void) finishTravel {
    diffFromRealTime = 0;
}

+ (instancetype) travelingDate {
    if( freezedDate ){
        return freezedDate;
    }
    return [NSDate dateWithTimeIntervalSinceNow:diffFromRealTime * scaleRatio];
}

+ (void) injectTimecop {
    Method fromMethod = class_getClassMethod(self, @selector(date));
    Method toMethod   = class_getClassMethod(self, @selector(travelingDate));
    method_exchangeImplementations(fromMethod, toMethod);
}

@end