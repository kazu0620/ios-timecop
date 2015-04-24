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
static NSTimeInterval scaledTimeOriginTime;
static NSDate *freezedDate;
static double scaleRatio;

@implementation NSDate(Timecop)

+ (void) load {
    scaleRatio = 1;
    [NSDate injectTimecop];
}

+ (void) travelWithDate:(NSDate *)date {
    diffFromRealTime     = [date timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970];
    if( freezedDate ){
        freezedDate = [NSDate dateWithTimeInterval:diffFromRealTime sinceDate:freezedDate];
    }
}

+ (void) freezeWithDate:(NSDate *)date {
    freezedDate = date;
}

+ (void) scaleWithRatio:(float)ratio {
    scaledTimeOriginTime = [[NSDate date] timeIntervalSince1970];
    scaleRatio           = ratio;
}

+ (void) finishTravel {
    diffFromRealTime = 0;
    scaleRatio       = 1;
    freezedDate      = nil;
}

+ (instancetype) travelingDate {
    if( freezedDate ) {
        return freezedDate;
    }
    
    if( scaleRatio != 1 ) {
        NSTimeInterval now        = [self realUnixTime];
        NSTimeInterval scaledDiff = now - scaledTimeOriginTime;
        NSTimeInterval adjusted   = scaledDiff * scaleRatio;
        
        if( scaledDiff > adjusted ){
            adjusted = (scaledDiff-adjusted) * -1;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:[self realUnixTime] + adjusted + diffFromRealTime];
    }
    
    return [NSDate dateWithTimeIntervalSince1970:[self realUnixTime] + diffFromRealTime];
}

+ (instancetype) traveringDateWithTimeIntervalSinceNow:(NSTimeInterval)secs {
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970] + secs];
}

+ (void) injectTimecop {
    [self switchInstanceMethodFrom:@selector(date) To:@selector(travelingDate)];
    [self switchInstanceMethodFrom:@selector(dateWithTimeIntervalSinceNow:) To:@selector(traveringDateWithTimeIntervalSinceNow:)];
}

+(void)switchInstanceMethodFrom:(SEL)from To:(SEL)to
{
    Method fromMethod = class_getClassMethod(self,from);
    Method toMethod   = class_getClassMethod(self,to  );
    method_exchangeImplementations(fromMethod, toMethod);
}

+ (double) realUnixTime {
    return time(NULL);
}

@end