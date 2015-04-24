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

@implementation NSDate(SRGTimecop)

+ (void) load {
    scaleRatio = 1;
    [NSDate injectTimecop];
}

+ (void) srg_travelWithDate:(NSDate *)date {
    diffFromRealTime     = [date timeIntervalSince1970] - [[NSDate date] timeIntervalSince1970];
    if( freezedDate ){
        freezedDate = [NSDate dateWithTimeInterval:diffFromRealTime sinceDate:freezedDate];
    }
}

+ (void) srg_freezeWithDate:(NSDate *)date {
    freezedDate = date;
}

+ (void) srg_scaleWithRatio:(float)ratio {
    scaledTimeOriginTime = [[NSDate date] timeIntervalSince1970];
    scaleRatio           = ratio;
}

+ (void) srg_finishTravel {
    diffFromRealTime = 0;
    scaleRatio       = 1;
    freezedDate      = nil;
}

+ (instancetype) srg_travelingDate {
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

+ (instancetype) srg_traveringDateWithTimeIntervalSinceNow:(NSTimeInterval)secs {
    return [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970] + secs];
}

+ (void) injectTimecop {
    [self switchInstanceMethodFrom:@selector(date) To:@selector(srg_travelingDate)];
    [self switchInstanceMethodFrom:@selector(dateWithTimeIntervalSinceNow:) To:@selector(srg_traveringDateWithTimeIntervalSinceNow:)];
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