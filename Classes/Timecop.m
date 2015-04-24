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
    [NSDate srg_travelWithDate:date];
}

+ (void) travelWithDate:(NSDate *)date block:(void(^)())block {
    [NSDate srg_travelWithDate:date];
    block();
    [NSDate srg_finishTravel];
}

+ (void) freezeWithDate:(NSDate *)date {
    [self throwExectionIfSafeMode];
    [NSDate srg_freezeWithDate:date];
}

+ (void) freezeWithDate:(NSDate *)date block:(void(^)())block {
    [NSDate srg_freezeWithDate:date];
    block();
    [NSDate srg_finishTravel];
}

+ (void) scaleWithFactor:(float)ratio {
    [self throwExectionIfSafeMode];
    [NSDate srg_scaleWithFactor:ratio];
}

+ (void) scaleWithFactor:(float)ratio  block:(void(^)())block {
    [NSDate srg_scaleWithFactor:ratio];
    block();
    [NSDate srg_finishTravel];
}

+ (void) finishTravel {
    [NSDate srg_finishTravel];
}

+ (void) throwExectionIfSafeMode {
    if (isSafeMode) {
        [NSException raise:@"Timecop Exception" format:@"Safe mode is enabled, only calls passing a block are allowed."];
    }
}

@end