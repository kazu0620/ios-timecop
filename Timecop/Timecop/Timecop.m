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

+ (void) travelWithDate:(NSDate *)date {
    [NSDate travelWithDate:date];
}

+ (void) travelWithDate:(NSDate *)date block:(void(^)())block {
    [NSDate travelWithDate:date];
    block();
    [NSDate finishTravel];
}

+ (void) freezeWithDate:(NSDate *)date {
    [NSDate freezeWithDate:date];
}

+ (void) freezeWithDate:(NSDate *)date block:(void(^)())block {
    [NSDate freezeWithDate:date];
    block();
    [NSDate finishTravel];
}

+ (void) scaleWithRatio:(float)ratio {
    [NSDate scaleWithRatio:ratio];
}

+ (void) return {
    [NSDate finishTravel];
}

@end