//
//  Timecop.m
//  Timecop
//
//  Created by Kazuhiro Sakamoto on 2015/04/19.
//  Copyright (c) 2015年 Soragoto. All rights reserved.
//

#import "Timecop.h"
#import "NSDate+Timecop.h"

@implementation Timecop

static BOOL isSafeMode;

+ (BOOL) safeMode {
    return isSafeMode;
}

+ (void) setSafeMode:(BOOL)safeMode {
    isSafeMode = safeMode;
}

+ (void) travelWithDate:(NSDate *)date {
    [self throwExectionIfSafeMode];
    [NSDate travelWithDate:date];
}

+ (void) travelWithDate:(NSDate *)date block:(void(^)())block {
    [NSDate travelWithDate:date];
    block();
    [NSDate finishTravel];
}

+ (void) freezeWithDate:(NSDate *)date {
    [self throwExectionIfSafeMode];
    [NSDate freezeWithDate:date];
}

+ (void) freezeWithDate:(NSDate *)date block:(void(^)())block {
    [NSDate freezeWithDate:date];
    block();
    [NSDate finishTravel];
}

+ (void) scaleWithRatio:(float)ratio {
    [self throwExectionIfSafeMode];
    [NSDate scaleWithRatio:ratio];
}

+ (void) scaleWithRatio:(float)ratio  block:(void(^)())block {
    [NSDate scaleWithRatio:ratio];
    block();
    [NSDate finishTravel];
}

+ (void) finishTravel {
    [NSDate finishTravel];
}

+ (void) throwExectionIfSafeMode {
    if (isSafeMode) {
        @throw @"Safe mode is enabled, only calls passing a block are allowed.";
    }
}

@end